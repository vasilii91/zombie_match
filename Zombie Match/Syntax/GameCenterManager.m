//
//  GameCenterManager.m
//  Syntax
//
//  Created by Seby Moisei on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCenterManager.h"
#import "SyntaxEngageView.h"
#import "SyntaxMainView.h"

@implementation GameCenterManager

@synthesize isUserAuthenticated;
@synthesize isMatchStarted;
@synthesize isWaitingForOtherPlayer;
@synthesize isOtherPlayerWaiting;
@synthesize myMatch;
@synthesize otherPlayer;
@synthesize pendingInvite;
@synthesize pendingPlayersToInvite;


- (id)initWithViewController:(ViewController *)controller {
	if ((self = [super init])) {
        myViewController = [controller retain];
        isUserAuthenticated = NO;
        isMatchStarted = NO;
        isGameCenterAvailable = [self isGameCenterAPIAvailable];
        if (isGameCenterAvailable) {
            NSNotificationCenter *nc = 
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self 
                   selector:@selector(authenticationChanged) 
                       name:GKPlayerAuthenticationDidChangeNotificationName 
                     object:nil];
            [self authenticateLocalUser];
        }
    }
    return self;
}

-(BOOL)isGameCenterAPIAvailable {
    BOOL localPlayerClassAvailable = (NSClassFromString(@"GKLocalPlayer")) != nil;
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);    
    return (localPlayerClassAvailable && osVersionSupported);
}

- (void)authenticationChanged {
    if ([GKLocalPlayer localPlayer].isAuthenticated && !isUserAuthenticated) {
        isUserAuthenticated = TRUE;
        [self checkInvites];
    }
    else if (![GKLocalPlayer localPlayer].isAuthenticated && isUserAuthenticated) {
        isUserAuthenticated = FALSE;
    }
    
}

- (void)authenticateLocalUser {     
    if (isGameCenterAvailable) {
        if ([GKLocalPlayer localPlayer].authenticated == NO) {     
            [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];        
        }        
    }
}

- (void)checkInvites {
    [GKMatchmaker sharedMatchmaker].inviteHandler = ^(GKInvite *acceptedInvite, NSArray *playersToInvite) {
        self.pendingInvite = acceptedInvite;
        self.pendingPlayersToInvite = playersToInvite;
    };    
}

- (void)disconnect {
    if (myMatch != nil) [myMatch disconnect];
    self.myMatch = nil;
    self.otherPlayer = nil;
    self.pendingInvite = nil;
    self.pendingPlayersToInvite = nil;
    isMatchStarted = NO;
    isWaitingForOtherPlayer = NO;
    isOtherPlayerWaiting = NO;
}

//////////////////////////

- (void)startMatch {
    if (!isUserAuthenticated) return;
    isWaitingForOtherPlayer = NO;
    isOtherPlayerWaiting = NO;
    self.myMatch = nil;
    if (pendingInvite != nil) {
        [myViewController dismissModalViewControllerAnimated:YES];
        GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithInvite:pendingInvite] autorelease];
        mmvc.matchmakerDelegate = self;
        [myViewController presentModalViewController:mmvc animated:YES];
        
    }
    else {
        [myViewController dismissModalViewControllerAnimated:YES];
        GKMatchRequest *request = [[[GKMatchRequest alloc] init] autorelease];
        request.minPlayers = 2;
        request.maxPlayers = 2;
        
        GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithMatchRequest:request] autorelease];
        mmvc.matchmakerDelegate = self;
        
        [myViewController presentModalViewController:mmvc animated:YES];        
    }    
}

- (void)restartMatch {
    isWaitingForOtherPlayer = YES;    
    
    PacketPlayAgain packet;
    packet.packetType.isPacketType = kPacketPlayAgain;
    NSData *packetData = [NSData dataWithBytes:&packet length:sizeof(PacketPlayAgain)];
    [self sendPacket:packetData];

    [self checkRestart];
}

- (void)checkRestart {
    if (isWaitingForOtherPlayer & isOtherPlayerWaiting) {
        isMatchStarted = YES;
        [myViewController.engageView startMatchWithPlayer1:[GKLocalPlayer localPlayer].alias andPlayer2:otherPlayer.alias];        
    }    
}

- (void)lookupPlayers {
    [GKPlayer loadPlayersForIdentifiers:myMatch.playerIDs withCompletionHandler:^(NSArray *players, NSError *error) {        
        if (error != nil) {
            isMatchStarted = NO;
            if (myMatch != nil) 
                if (myViewController.isPlayingEngage) [myViewController.engageView disconnectGame];
        }
        else {
            self.otherPlayer = [players objectAtIndex:0];
            isMatchStarted = YES;
            [myViewController.engageView startMatchWithPlayer1:[GKLocalPlayer localPlayer].alias andPlayer2:otherPlayer.alias];
        }
    }];    
}

- (void)sendPacket:(NSData *)thisPacket {
    if (myMatch == nil) return;
    NSError *error;
    if (![myMatch sendDataToAllPlayers:thisPacket withDataMode:GKMatchSendDataReliable error:&error]) {
    }
}

#pragma GKMatchmakerViewControllerDelegate

- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController {
    [myViewController dismissModalViewControllerAnimated:YES];
    [myViewController.engageView disconnectGame];
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error {
    [myViewController dismissModalViewControllerAnimated:YES];
    [myViewController.engageView disconnectGame];
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)theMatch {
    [myViewController dismissModalViewControllerAnimated:YES];
    self.myMatch = theMatch;
    myMatch.delegate = self;
    if (!isMatchStarted && myMatch.expectedPlayerCount == 0) {
        [self lookupPlayers];
    }
}

#pragma GKMatchDelegate

- (void)match:(GKMatch *)theMatch didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {    
    if (myMatch != theMatch) return;
    
    PacketType *packet = (PacketType *)[data bytes];
    if (packet->isPacketType == kPacketPlayAgain) {
        isOtherPlayerWaiting = YES;
        [self checkRestart];        
    }
    else [myViewController.engageView.clientGameEngine addPacketToQueue:data];
}

- (void)match:(GKMatch *)theMatch player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state {    
    if (myMatch != theMatch) return;
    
    switch (state) {
        case GKPlayerStateConnected:             
            if (!isMatchStarted && theMatch.expectedPlayerCount == 0) {
                [self lookupPlayers];
            }            
            break; 
        case GKPlayerStateDisconnected:
            if (myViewController.isPlayingEngage) [myViewController.engageView disconnectGame];
            break;
    }   
}

- (void)match:(GKMatch *)theMatch connectionWithPlayerFailed:(NSString *)playerID withError:(NSError *)error {    
    if (myMatch != theMatch) return;  
    
    if (myViewController.isPlayingEngage) [myViewController.engageView disconnectGame];
}

- (void)match:(GKMatch *)theMatch didFailWithError:(NSError *)error {    
    if (myMatch != theMatch) return;
    
    if (myViewController.isPlayingEngage) [myViewController.engageView disconnectGame];
}

@end
