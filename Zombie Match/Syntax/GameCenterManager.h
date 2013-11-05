//
//  GameCenterManager.h
//  Syntax
//
//  Created by Seby Moisei on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "ViewController.h"
#import "SyntaxEngageView.h"
#import "SyntaxEngagePacket.h"

@interface GameCenterManager : NSObject <GKMatchmakerViewControllerDelegate, GKMatchDelegate> {
    ViewController *myViewController;
    BOOL isGameCenterAvailable;
    BOOL isUserAuthenticated;
    BOOL isMatchStarted;
    BOOL isWaitingForOtherPlayer;
    BOOL isOtherPlayerWaiting;
    GKMatch *myMatch;
    GKPlayer *otherPlayer;
    GKInvite *pendingInvite;
    NSArray *pendingPlayersToInvite;
}

@property (nonatomic) BOOL isUserAuthenticated;
@property (nonatomic) BOOL isMatchStarted;
@property (nonatomic) BOOL isWaitingForOtherPlayer;
@property (nonatomic) BOOL isOtherPlayerWaiting;
@property (nonatomic, retain) GKMatch *myMatch;
@property (nonatomic, retain) GKPlayer *otherPlayer;
@property (nonatomic, retain) GKInvite *pendingInvite;
@property (nonatomic, retain) NSArray *pendingPlayersToInvite;

- (id)initWithViewController:(ViewController *)controller;
- (BOOL)isGameCenterAPIAvailable;
- (void)authenticationChanged;
- (void)authenticateLocalUser;
- (void)checkInvites;
- (void)disconnect;

- (void)startMatch;
- (void)restartMatch;
- (void)checkRestart;
- (void)lookupPlayers;
- (void)sendPacket:(NSData *)thisPacket;

@end
