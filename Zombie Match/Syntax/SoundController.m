//
//  SoundController.m
//  Recycle Bins
//
//  Created by MSSeby on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundController.h"

@implementation SoundController

@synthesize isSFXOff;

- (id)init {
	if ((self = [super init])) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        NSBundle *bundle = [[NSBundle mainBundle] retain];
        
        isSFXOff = [[userDefaults valueForKey:@"isSFXOff"] boolValue];
        
        SFX = [[NSMutableDictionary alloc] init];
        
        NSString *path = [bundle pathForResource:@"SFX-GeneralMenuButton" ofType:@"caf"];
        NSData *soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"GeneralMenuButton"];
        
        path = [bundle pathForResource:@"SFX-SymbolSelect_A" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"SymbolSelect_A"];  
        
        path = [bundle pathForResource:@"SFX-SymbolSelect_B" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"SymbolSelect_B"];
        
        path = [bundle pathForResource:@"SFX-SymbolDeselect" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"SymbolDeselect"];
        
        path = [bundle pathForResource:@"SFX-Match" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"Match"];
        
        path = [bundle pathForResource:@"SFX-SymbolElimination" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"SymbolElimination"];
        
        path = [bundle pathForResource:@"SFX-NoMatch" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"NoMatch"];
        
        path = [bundle pathForResource:@"SFX-PromptButton" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"PromptButton"];
        
        path = [bundle pathForResource:@"SFX-PenaltyFreePrompt" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"PenaltyFreePrompt"];
        
        path = [bundle pathForResource:@"SFX-4Match" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"4Match"];
        
        path = [bundle pathForResource:@"SFX-4Match_Explosion" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"4Match_Explosion"];
        
        path = [bundle pathForResource:@"SFX-5Match" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"5Match"];
        
        path = [bundle pathForResource:@"SFX-SuperSymbolElimination" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"SuperSymbolElimination"];
        
        path = [bundle pathForResource:@"SFX-LMatch" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"LMatch"];
        
        path = [bundle pathForResource:@"SFX-HiddenSymbolMorph" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"HiddenSymbolMorph"];
        
        path = [bundle pathForResource:@"SFX-WildcardMenu_Open" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"WildcardMenu_Open"];
        
        path = [bundle pathForResource:@"SFX-WildcardMenu_Choose" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"WildcardMenu_Choose"];
        
        path = [bundle pathForResource:@"SFX-WildcardMorph" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"WildcardMorph"];
        
        path = [bundle pathForResource:@"SFX-RedeemWildcard" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"RedeemWildcard"];
        
        path = [bundle pathForResource:@"SFX-Rectify" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"Rectify"];
        
        path = [bundle pathForResource:@"SFX-IAP" ofType:@"caf"];
        soundData = [NSData dataWithContentsOfFile:path];
        [SFX setObject:soundData forKey:@"IAP"];
        
        [bundle release];
    }
	return self;
}

- (void)playSound:(NSString *)thisSound {
    if (!isSFXOff) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            AVAudioPlayer *sound = [[AVAudioPlayer alloc] initWithData:[SFX objectForKey:thisSound] error:nil];
            sound.delegate = self;
            [sound prepareToPlay];
            [sound play];
        });            
    }
}

- (void)turnSoundOn {
    isSFXOff = NO;
    [userDefaults setBool:isSFXOff forKey:@"isSFXOff"];    
}

- (void)turnSoundOff {
    isSFXOff = YES;
    [userDefaults setBool:isSFXOff forKey:@"isSFXOff"];    
}

- (void)dealloc {
    [userDefaults release];
    [SFX removeAllObjects];
    [SFX release];
    [super dealloc];    
}

#pragma AVAudioPlayerDelegate Methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [player release];
}

@end 
