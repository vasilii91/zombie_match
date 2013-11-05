//
//  ValuesManager.h
//  Syntax
//
//  Created by Seby Moisei on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValuesManager : NSObject <NSURLConnectionDelegate> {
    NSUserDefaults *userDefaults;
    BOOL isNotFirstTime;
    NSURLConnection *plistConnection;
    NSMutableData *plistResponse;
    int kPointsStandardMatch;
    int kPointsDoubleMatch;
    int kPointsShifterMatch;
    int kPoints4Match;
    int kPoints4MatchExplosion;
    int kPoints5Match;
    int kPointsSuperEliminatedSymbol;
    int kPointsLMatch;
    int kPointsCorruptedEliminated;
    int kPointsCascadingMatch;
    int kPointsDeducedWhenUsingPrompt;
    int kPointsDeducedWhenNonMatchMove;
    int kPointsRequiredToCompleteLevels1_5_Primary;
    int kPointsRequiredToCompleteLevels6_10_Primary;
    int kPointsRequiredToCompleteLevels11_15_Primary;
    int kPointsRequiredToCompleteLevels16_ON_Primary;
    int kPointsRequiredToCompleteLevels1_5_Action;
    int kPointsRequiredToCompleteLevels6_10_Action;
    int kPointsRequiredToCompleteLevels11_15_Action;
    int kPointsRequiredToCompleteLevels16_ON_Action;
    int kPointsRequiredToCompleteLevels1_5_Infinity;
    int kPointsRequiredToCompleteLevels6_10_Infinity;
    int kPointsRequiredToCompleteLevels11_15_Infinity;
    int kPointsRequiredToCompleteLevels16_ON_Infinity;
    int kProbabilityOfCorruptedSymbolInLevels1_5;
    int kProbabilityOfShifterSymbolInLevels1_5;
    int kProbabilityOfHiddenSymbolInLevels1_5;
    int kProbabilityOfWildcardSymbolInLevels1_5;
    int kProbabilityOfCorruptedSymbolInLevels6_10;
    int kProbabilityOfShifterSymbolInLevels6_10;
    int kProbabilityOfHiddenSymbolInLevels6_10;
    int kProbabilityOfWildcardSymbolInLevels6_10;
    int kProbabilityOfCorruptedSymbolInLevels11_15;
    int kProbabilityOfShifterSymbolInLevels11_15;
    int kProbabilityOfHiddenSymbolInLevels11_15;
    int kProbabilityOfWildcardSymbolInLevels11_15;
    int kProbabilityOfCorruptedSymbolInLevels16_ON;
    int kProbabilityOfShifterSymbolInLevels16_ON;
    int kProbabilityOfHiddenSymbolInLevels16_ON;
    int kProbabilityOfWildcardSymbolInLevels16_ON;
    int kPointsForByte;   
}

@property (nonatomic) int kPointsStandardMatch;
@property (nonatomic) int kPointsDoubleMatch;
@property (nonatomic) int kPointsShifterMatch;
@property (nonatomic) int kPoints4Match;
@property (nonatomic) int kPoints4MatchExplosion;
@property (nonatomic) int kPoints5Match;
@property (nonatomic) int kPointsSuperEliminatedSymbol;
@property (nonatomic) int kPointsLMatch;
@property (nonatomic) int kPointsCorruptedEliminated;
@property (nonatomic) int kPointsCascadingMatch;
@property (nonatomic) int kPointsDeducedWhenUsingPrompt;
@property (nonatomic) int kPointsDeducedWhenNonMatchMove;
@property (nonatomic) int kPointsRequiredToCompleteLevels1_5_Primary;
@property (nonatomic) int kPointsRequiredToCompleteLevels6_10_Primary;
@property (nonatomic) int kPointsRequiredToCompleteLevels11_15_Primary;
@property (nonatomic) int kPointsRequiredToCompleteLevels16_ON_Primary;
@property (nonatomic) int kPointsRequiredToCompleteLevels1_5_Action;
@property (nonatomic) int kPointsRequiredToCompleteLevels6_10_Action;
@property (nonatomic) int kPointsRequiredToCompleteLevels11_15_Action;
@property (nonatomic) int kPointsRequiredToCompleteLevels16_ON_Action;
@property (nonatomic) int kPointsRequiredToCompleteLevels1_5_Infinity;
@property (nonatomic) int kPointsRequiredToCompleteLevels6_10_Infinity;
@property (nonatomic) int kPointsRequiredToCompleteLevels11_15_Infinity;
@property (nonatomic) int kPointsRequiredToCompleteLevels16_ON_Infinity;
@property (nonatomic) int kProbabilityOfCorruptedSymbolInLevels1_5;
@property (nonatomic) int kProbabilityOfShifterSymbolInLevels1_5;
@property (nonatomic) int kProbabilityOfHiddenSymbolInLevels1_5;
@property (nonatomic) int kProbabilityOfWildcardSymbolInLevels1_5;
@property (nonatomic) int kProbabilityOfCorruptedSymbolInLevels6_10;
@property (nonatomic) int kProbabilityOfShifterSymbolInLevels6_10;
@property (nonatomic) int kProbabilityOfHiddenSymbolInLevels6_10;
@property (nonatomic) int kProbabilityOfWildcardSymbolInLevels6_10;
@property (nonatomic) int kProbabilityOfCorruptedSymbolInLevels11_15;
@property (nonatomic) int kProbabilityOfShifterSymbolInLevels11_15;
@property (nonatomic) int kProbabilityOfHiddenSymbolInLevels11_15;
@property (nonatomic) int kProbabilityOfWildcardSymbolInLevels11_15;
@property (nonatomic) int kProbabilityOfCorruptedSymbolInLevels16_ON;
@property (nonatomic) int kProbabilityOfShifterSymbolInLevels16_ON;
@property (nonatomic) int kProbabilityOfHiddenSymbolInLevels16_ON;
@property (nonatomic) int kProbabilityOfWildcardSymbolInLevels16_ON;
@property (nonatomic) int kPointsForByte;

- (void)firstInitValues;
- (void)initValues;
- (void)initValuesFromServer;
- (void)setValuesFromDictionary:(NSDictionary *)thisDictionary;
- (int)pointsNeededForLevel:(int)thisLevel andGameMode:(int)thisGameMode;
- (int)wildcardProbabilityForLevel:(int)thisLevel;
- (int)shifterProbabilityForLevel:(int)thisLevel;
- (int)corruptedProbabilityForLevel:(int)thisLevel;
- (int)hiddenProbabilityForLevel:(int)thisLevel;


@end

