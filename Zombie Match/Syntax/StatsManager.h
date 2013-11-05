//
//  StatsManager.h
//  Syntax
//
//  Created by Seby Moisei on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatsManager : NSObject {
    NSUserDefaults *userDefaults;
    int selectedGameMode;
    int currentLevel;
    int currentScore;
    int currentLevelScore;
    int pointsToCompleteLevel;
    int player1Score;
    int player2Score;
}

@property (nonatomic) int selectedGameMode;
@property (nonatomic) int currentLevel;
@property (nonatomic) int currentScore;
@property (nonatomic) int currentLevelScore;
@property (nonatomic) int pointsToCompleteLevel;
@property (nonatomic) int player1Score;
@property (nonatomic) int player2Score;

- (void)clearGameStats;
- (BOOL)didSeePopUpForSpecialType:(int)thisType;
- (void)setHighScore;
- (int)getHighScore;
- (void)setTopTenScoresForGameMode:(int)thisGameMode;
- (NSArray *)getTopTenScoresForGameMode:(int)thisGameMode;

@end
