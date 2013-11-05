//
//  SoundController.h
//  Recycle Bins
//
//  Created by MSSeby on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundController : NSObject <AVAudioPlayerDelegate> {
    NSUserDefaults *userDefaults;
    BOOL isSFXOff;
    NSMutableDictionary *SFX;
}

@property (nonatomic) BOOL isSFXOff;

- (void)playSound:(NSString *)thisSound;
- (void)turnSoundOn;
- (void)turnSoundOff;

@end
