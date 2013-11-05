//
//  MusicController.h
//  Syntax
//
//  Created by Seby Moisei on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicController : NSObject {
    NSUserDefaults *userDefaults;
    BOOL isMusicOff;
    NSMutableDictionary *music;
    NSDictionary *musicLoopPoints;
    NSArray *songNames;
    NSString *currentSongPlaying;    
    AVAudioPlayer *currentSong;
    AVAudioPlayer *previousSong;
    BOOL songIsReplaying;
}

@property (nonatomic) BOOL isMusicOff;;
@property (nonatomic, retain) NSString *currentSongPlaying;

- (void)fadeToSongFromLevel:(int)thisLevel;
- (void)fadeToSong:(NSString *)thisSong andReplay:(BOOL)isReplaying;
- (void)fadeOutSong;
- (void)fadeInSong;
- (void)turnMusicOn;
- (void)turnMusicOff;


@end
