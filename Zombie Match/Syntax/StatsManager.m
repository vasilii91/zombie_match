//
//  StatsManager.m
//  Syntax
//
//  Created by Seby Moisei on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatsManager.h"

@implementation StatsManager

@synthesize selectedGameMode;
@synthesize currentLevel;
@synthesize currentScore;
@synthesize currentLevelScore;
@synthesize pointsToCompleteLevel;
@synthesize player1Score;
@synthesize player2Score;

- (id)init {
	if ((self = [super init])) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
    }
	return self;
}

- (void)clearGameStats{
    currentLevel = 1;
    currentScore = 0;
    currentLevelScore = 0;
    pointsToCompleteLevel = 0;
    player1Score = 0;
    player2Score = 0;
}

- (BOOL)didSeePopUpForSpecialType:(int)thisType{
    BOOL didSee = NO;
    switch (thisType) {
        case 0:
            didSee = [userDefaults boolForKey:@"didSeeSpecialType0"];
            if (!didSee) [userDefaults setBool:YES forKey:@"didSeeSpecialType0"];
            break;
        case 1:
            didSee = [userDefaults boolForKey:@"didSeeSpecialType1"];
            if (!didSee) [userDefaults setBool:YES forKey:@"didSeeSpecialType1"];
            break;
        case 2:
            didSee = [userDefaults boolForKey:@"didSeeSpecialType2"];
            if (!didSee) [userDefaults setBool:YES forKey:@"didSeeSpecialType2"];
            break;
        case 3:
            didSee = [userDefaults boolForKey:@"didSeeSpecialType3"];
            if (!didSee) [userDefaults setBool:YES forKey:@"didSeeSpecialType3"];
            break;
        default:
            break;
    }    
    return didSee;    
}

- (void)setHighScore {
    switch (selectedGameMode) {
        case 0:
            if (currentScore > [userDefaults integerForKey:@"highScorePrimary"]) [userDefaults setInteger:currentScore forKey:@"highScorePrimary"];
            break;
        case 1:
            if (currentScore > [userDefaults integerForKey:@"highScoreAction"]) [userDefaults setInteger:currentScore forKey:@"highScoreAction"];
            break;
        case 2:
            if (currentScore > [userDefaults integerForKey:@"highScoreInfinity"]) [userDefaults setInteger:currentScore forKey:@"highScoreInfinity"];
            break;
    }
}

- (int)getHighScore {
    switch (selectedGameMode) {
        case 0:
            return [userDefaults integerForKey:@"highScorePrimary"];
            break;
        case 1:
            return [userDefaults integerForKey:@"highScoreAction"];
            break;
        case 2:
            return [userDefaults integerForKey:@"highScoreInfinity"];
            break;
        default:
            return 0;
            break;
    }
}

- (void)setTopTenScoresForGameMode:(int)thisGameMode {
    NSArray *topTenScores;
    switch (thisGameMode) {
        case 0:
            topTenScores = [userDefaults arrayForKey:@"topTenScoresPrimary"];
            break;
        case 1:
            topTenScores = [userDefaults arrayForKey:@"topTenScoresAction"];
            break;
        case 2:
            topTenScores = [userDefaults arrayForKey:@"topTenScoresInfinity"];
            break;
        default:
            break;
    }
    int topScores[10];
    for (int i = 0; i < 10; i++) {
        topScores[i] = [[topTenScores objectAtIndex:i] intValue];
    }
    if (topScores[9] < currentScore) {
        topScores[9] = currentScore;
        for (int i = 0; i < 9; i++) {
            for (int j = i+1; j < 10; j++) {
                if (topScores[i] < topScores[j]) {
                    int k = topScores[i];
                    topScores[i] = topScores[j];
                    topScores[j] = k;
                }
            }
        }
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [array addObject:[NSNumber numberWithInt:topScores[i]]];
    }
    switch (thisGameMode) {
        case 0:
            [userDefaults setObject:array forKey:@"topTenScoresPrimary"];
            break;
        case 1:
            [userDefaults setObject:array forKey:@"topTenScoresAction"];
            break;
        case 2:
            [userDefaults setObject:array forKey:@"topTenScoresInfinity"];
            break;
        default:
            break;
    }
}

- (NSArray *)getTopTenScoresForGameMode:(int)thisGameMode {
    NSArray *topTenScores;
    switch (thisGameMode) {
        case 0:
            topTenScores = [userDefaults arrayForKey:@"topTenScoresPrimary"];
            break;
        case 1:
            topTenScores = [userDefaults arrayForKey:@"topTenScoresAction"];
            break;
        case 2:
            topTenScores = [userDefaults arrayForKey:@"topTenScoresInfinity"];
            break;
        default:
            break;
    }
    return topTenScores;
}

- (void)dealloc {
    [userDefaults release];
    [super dealloc];
}

@end
