//
//  MusicController.m
//  Syntax
//
//  Created by Seby Moisei on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MusicController.h"

@implementation MusicController

@synthesize isMusicOff;
@synthesize currentSongPlaying;

- (id)init {
	if ((self = [super init])) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        NSBundle *bundle = [[NSBundle mainBundle] retain];
        
        isMusicOff = [[userDefaults valueForKey:@"isMusicOff"] boolValue];
        
        music = [[NSMutableDictionary alloc] init];
        musicLoopPoints = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [NSNumber numberWithFloat:24.000], @"01-InitiationSequence",
                           [NSNumber numberWithFloat:0], @"02-InTheGame",
                           [NSNumber numberWithFloat:0], @"03-Assimilation",
                           [NSNumber numberWithFloat:0], @"04-Resistance",
                           [NSNumber numberWithFloat:0], @"05-TheMysteryTheEpiphany",
                           [NSNumber numberWithFloat:0], @"06-WeOnlyComeOutAtNite",
                           [NSNumber numberWithFloat:44.308], @"07-DigitalRain", nil];
        songNames = [[NSArray alloc] initWithObjects:
                     @"01-InitiationSequence",
                     @"02-InTheGame",
                     @"03-Assimilation",
                     @"04-Resistance",
                     @"05-TheMysteryTheEpiphany",
                     @"06-WeOnlyComeOutAtNite",
                     @"07-DigitalRain", nil];
        
        NSString *path = [bundle pathForResource:@"MUSIC-01-InitiationSequence-Mono" ofType:@"m4a"];
        NSData *soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"01-InitiationSequence"];
        
        path = [bundle pathForResource:@"MUSIC-02-InTheGame-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"02-InTheGame"];
        
        path = [bundle pathForResource:@"MUSIC-03-Assimilation-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"03-Assimilation"];
        
        path = [bundle pathForResource:@"MUSIC-01-InitiationSequence-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"04-Resistance"];
        
        path = [bundle pathForResource:@"MUSIC-02-InTheGame-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"05-TheMysteryTheEpiphany"];
        
        path = [bundle pathForResource:@"MUSIC-03-Assimilation-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"06-WeOnlyComeOutAtNite"];
        
        path = [bundle pathForResource:@"MUSIC-01-InitiationSequence-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"07-DigitalRain"];
        
        path = [bundle pathForResource:@"MUSIC-Engage-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"Engage"];
        
        path = [bundle pathForResource:@"MUSIC-GameOver-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"GameOver"];
        
        path = [bundle pathForResource:@"MUSIC-LevelUp-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"LevelUp"];
        
        path = [bundle pathForResource:@"MUSIC-MainTitles(Syntax)-Mono" ofType:@"m4a"];
        soundData = [NSData dataWithContentsOfFile:path];
        [music setObject:soundData forKey:@"MainTitles(Syntax)"];
        
        [bundle release];
        
        currentSong = [[AVAudioPlayer alloc] initWithData:[music objectForKey:@"MainTitles(Syntax)"] error:nil];
        [currentSong prepareToPlay];
        currentSong.numberOfLoops = -1;
        currentSong.volume = 0.01;
        if (!isMusicOff) [currentSong play];
        self.currentSongPlaying = @"";
    }
	return self;
}

- (void)fadeToSongFromLevel:(int)thisLevel {
    songIsReplaying = YES;
    int k = (thisLevel + 6) % 7;
    [self fadeToSong:[songNames objectAtIndex:k] andReplay:YES];
}

- (void)fadeToSong:(NSString *)thisSong andReplay:(BOOL)isReplaying {
    if (isMusicOff) {
        currentSongPlaying = thisSong;
    }
    else if (![currentSongPlaying isEqualToString:thisSong]) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            previousSong = [currentSong retain];
            [currentSong release];
            currentSong = nil;
            currentSong = [[AVAudioPlayer alloc] initWithData:[music objectForKey:thisSong] error:nil];
            [currentSong prepareToPlay];
            currentSong.volume = 0.1;    
            self.currentSongPlaying = thisSong;
            if (isReplaying) currentSong.numberOfLoops = -1;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self fadeOutSong]; 
            });          
        });           
    }
}

- (void)fadeOutSong {
    float vol = previousSong.volume;
    vol -= 0.05;
    previousSong.volume = vol;
    if (vol > 0) [self performSelector:@selector(fadeOutSong) withObject:nil afterDelay:0.01666];
    else {
        [previousSong stop];
        [previousSong release];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        dispatch_async(queue, ^{
            [currentSong play];            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self fadeInSong]; 
            });             
        });           
    }    
}

- (void)fadeInSong {
    currentSong.volume += 0.05;
    if (currentSong.volume < 1) [self performSelector:@selector(fadeInSong) withObject:nil afterDelay:0.01666];
}

- (void)turnMusicOn {
    isMusicOff = NO;
    [userDefaults setBool:isMusicOff forKey:@"isMusicOff"];
    BOOL doReplay = [songNames containsObject:currentSongPlaying];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [currentSong release];
        currentSong = nil;
        currentSong = [[AVAudioPlayer alloc] initWithData:[music objectForKey:currentSongPlaying] error:nil];
        [currentSong prepareToPlay];
        currentSong.volume = 1;    
        if (doReplay) currentSong.numberOfLoops = -1;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [currentSong play]; 
        });          
    });  
}

- (void)turnMusicOff {
    [currentSong stop];
    isMusicOff = YES;
    [userDefaults setBool:isMusicOff forKey:@"isMusicOff"];    
}

- (void)dealloc {
    [music removeAllObjects];
    [music release];
    [musicLoopPoints release];
    [songNames release];
    [currentSongPlaying release];
    [currentSong stop];
    [currentSong release];
    [super dealloc];    
}

@end
