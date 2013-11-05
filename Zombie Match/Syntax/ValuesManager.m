//
//  ValuesManager.m
//  Syntax
//
//  Created by Seby Moisei on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ValuesManager.h"

@implementation ValuesManager

@synthesize kPointsStandardMatch;
@synthesize kPointsDoubleMatch;
@synthesize kPointsShifterMatch;
@synthesize kPoints4Match;
@synthesize kPoints4MatchExplosion;
@synthesize kPoints5Match;
@synthesize kPointsSuperEliminatedSymbol;
@synthesize kPointsLMatch;
@synthesize kPointsCorruptedEliminated;
@synthesize kPointsCascadingMatch;
@synthesize kPointsDeducedWhenUsingPrompt;
@synthesize kPointsDeducedWhenNonMatchMove;
@synthesize kPointsRequiredToCompleteLevels1_5_Primary;
@synthesize kPointsRequiredToCompleteLevels6_10_Primary;
@synthesize kPointsRequiredToCompleteLevels11_15_Primary;
@synthesize kPointsRequiredToCompleteLevels16_ON_Primary;
@synthesize kPointsRequiredToCompleteLevels1_5_Action;
@synthesize kPointsRequiredToCompleteLevels6_10_Action;
@synthesize kPointsRequiredToCompleteLevels11_15_Action;
@synthesize kPointsRequiredToCompleteLevels16_ON_Action;
@synthesize kPointsRequiredToCompleteLevels1_5_Infinity;
@synthesize kPointsRequiredToCompleteLevels6_10_Infinity;
@synthesize kPointsRequiredToCompleteLevels11_15_Infinity;
@synthesize kPointsRequiredToCompleteLevels16_ON_Infinity;
@synthesize kProbabilityOfCorruptedSymbolInLevels1_5;
@synthesize kProbabilityOfShifterSymbolInLevels1_5;
@synthesize kProbabilityOfHiddenSymbolInLevels1_5;
@synthesize kProbabilityOfWildcardSymbolInLevels1_5;
@synthesize kProbabilityOfCorruptedSymbolInLevels6_10;
@synthesize kProbabilityOfShifterSymbolInLevels6_10;
@synthesize kProbabilityOfHiddenSymbolInLevels6_10;
@synthesize kProbabilityOfWildcardSymbolInLevels6_10;
@synthesize kProbabilityOfCorruptedSymbolInLevels11_15;
@synthesize kProbabilityOfShifterSymbolInLevels11_15;
@synthesize kProbabilityOfHiddenSymbolInLevels11_15;
@synthesize kProbabilityOfWildcardSymbolInLevels11_15;
@synthesize kProbabilityOfCorruptedSymbolInLevels16_ON;
@synthesize kProbabilityOfShifterSymbolInLevels16_ON;
@synthesize kProbabilityOfHiddenSymbolInLevels16_ON;
@synthesize kProbabilityOfWildcardSymbolInLevels16_ON;
@synthesize kPointsForByte;

- (id)init {
	if ((self = [super init])) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        isNotFirstTime = [[userDefaults valueForKey:@"isNotFirstTime"] boolValue];
        if (isNotFirstTime) [self initValues];
        else [self firstInitValues];
    }
	return self;
}

- (void)firstInitValues {
    isNotFirstTime = YES;
    [userDefaults setBool:isNotFirstTime forKey:@"isNotFirstTime"];
    [userDefaults setInteger:2 forKey:@"wildcards"];
    [userDefaults setInteger:2 forKey:@"rectifiers"];
    [userDefaults setInteger:2 forKey:@"prompts"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"syntaxValues" ofType:@"plist"];
    NSDictionary *syntaxValues = [[NSDictionary alloc] initWithContentsOfFile:path];
    [self setValuesFromDictionary:syntaxValues];
    [userDefaults setObject:syntaxValues forKey:@"syntaxValues"];
    [syntaxValues release];
    [self initValues];    
}

- (void)initValues {
    NSDictionary *syntaxValues = (NSDictionary *)[userDefaults dictionaryForKey:@"syntaxValues"];
    [self setValuesFromDictionary:syntaxValues];
    [self initValuesFromServer];
}

- (void)initValuesFromServer {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://jonstinson.com/backdoor/curiousideafiles/syntax/plistfiles/syntaxValues.plist"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60];    
    plistConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];    
}

- (void)setValuesFromDictionary:(NSDictionary *)thisDictionary {
    if (thisDictionary != nil) {
        kPointsStandardMatch = [[thisDictionary valueForKey:@"kPointsStandardMatch"] intValue];
        kPointsDoubleMatch = [[thisDictionary valueForKey:@"kPointsDoubleMatch"] intValue];
        kPointsShifterMatch = [[thisDictionary valueForKey:@"kPointsShifterMatch"] intValue];
        kPoints4Match = [[thisDictionary valueForKey:@"kPoints4Match"] intValue];
        kPoints4MatchExplosion = [[thisDictionary valueForKey:@"kPoints4MatchExplosion"] intValue];
        kPoints5Match = [[thisDictionary valueForKey:@"kPoints5Match"] intValue];
        kPointsSuperEliminatedSymbol = [[thisDictionary valueForKey:@"kPointsSuperEliminatedSymbol"] intValue];
        kPointsLMatch = [[thisDictionary valueForKey:@"kPointsLMatch"] intValue];
        kPointsCorruptedEliminated = [[thisDictionary valueForKey:@"kPointsCorruptedEliminated"] intValue];
        kPointsCascadingMatch = [[thisDictionary valueForKey:@"kPointsCascadingMatch"] intValue];
        kPointsDeducedWhenUsingPrompt = [[thisDictionary valueForKey:@"kPointsDeducedWhenUsingPrompt"] intValue];
        kPointsDeducedWhenNonMatchMove = [[thisDictionary valueForKey:@"kPointsDeducedWhenNonMatchMove"] intValue];
        kPointsRequiredToCompleteLevels1_5_Primary = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels1_5_Primary"] intValue];
        kPointsRequiredToCompleteLevels6_10_Primary = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels6_10_Primary"] intValue];
        kPointsRequiredToCompleteLevels11_15_Primary = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels11_15_Primary"] intValue];
        kPointsRequiredToCompleteLevels16_ON_Primary = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels16_ON_Primary"] intValue];
        kPointsRequiredToCompleteLevels1_5_Action = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels1_5_Action"] intValue];
        kPointsRequiredToCompleteLevels6_10_Action = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels6_10_Action"] intValue];
        kPointsRequiredToCompleteLevels11_15_Action = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels11_15_Action"] intValue];
        kPointsRequiredToCompleteLevels16_ON_Action = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels16_ON_Action"] intValue];
        kPointsRequiredToCompleteLevels1_5_Infinity = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels1_5_Infinity"] intValue];
        kPointsRequiredToCompleteLevels6_10_Infinity = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels6_10_Infinity"] intValue];
        kPointsRequiredToCompleteLevels11_15_Infinity = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels11_15_Infinity"] intValue];
        kPointsRequiredToCompleteLevels16_ON_Infinity = [[thisDictionary valueForKey:@"kPointsRequiredToCompleteLevels16_ON_Infinity"] intValue];
        kProbabilityOfCorruptedSymbolInLevels1_5 = [[thisDictionary valueForKey:@"kProbabilityOfCorruptedSymbolInLevels1_5"] intValue];
        kProbabilityOfShifterSymbolInLevels1_5 = [[thisDictionary valueForKey:@"kProbabilityOfShifterSymbolInLevels1_5"] intValue];
        kProbabilityOfHiddenSymbolInLevels1_5 = [[thisDictionary valueForKey:@"kProbabilityOfHiddenSymbolInLevels1_5"] intValue];
        kProbabilityOfWildcardSymbolInLevels1_5 = [[thisDictionary valueForKey:@"kProbabilityOfWildcardSymbolInLevels1_5"] intValue];
        kProbabilityOfCorruptedSymbolInLevels6_10 = [[thisDictionary valueForKey:@"kProbabilityOfCorruptedSymbolInLevels6_10"] intValue];
        kProbabilityOfShifterSymbolInLevels6_10 = [[thisDictionary valueForKey:@"kProbabilityOfShifterSymbolInLevels6_10"] intValue];
        kProbabilityOfHiddenSymbolInLevels6_10 = [[thisDictionary valueForKey:@"kProbabilityOfHiddenSymbolInLevels6_10"] intValue];
        kProbabilityOfWildcardSymbolInLevels6_10 = [[thisDictionary valueForKey:@"kProbabilityOfWildcardSymbolInLevels6_10"] intValue];
        kProbabilityOfCorruptedSymbolInLevels11_15 = [[thisDictionary valueForKey:@"kProbabilityOfCorruptedSymbolInLevels11_15"] intValue];
        kProbabilityOfShifterSymbolInLevels11_15 = [[thisDictionary valueForKey:@"kProbabilityOfShifterSymbolInLevels11_15"] intValue];
        kProbabilityOfHiddenSymbolInLevels11_15 = [[thisDictionary valueForKey:@"kProbabilityOfHiddenSymbolInLevels11_15"] intValue];
        kProbabilityOfWildcardSymbolInLevels11_15 = [[thisDictionary valueForKey:@"kProbabilityOfWildcardSymbolInLevels11_15"] intValue];
        kProbabilityOfCorruptedSymbolInLevels16_ON = [[thisDictionary valueForKey:@"kProbabilityOfCorruptedSymbolInLevels16_ON"] intValue];
        kProbabilityOfShifterSymbolInLevels16_ON = [[thisDictionary valueForKey:@"kProbabilityOfShifterSymbolInLevels16_ON"] intValue];
        kProbabilityOfHiddenSymbolInLevels16_ON = [[thisDictionary valueForKey:@"kProbabilityOfHiddenSymbolInLevels16_ON"] intValue];
        kProbabilityOfWildcardSymbolInLevels16_ON = [[thisDictionary valueForKey:@"kProbabilityOfWildcardSymbolInLevels16_ON"] intValue];
        kPointsForByte = [[thisDictionary valueForKey:@"kPointsForByte"] intValue];        
    }    
}

- (int)pointsNeededForLevel:(int)thisLevel andGameMode:(int)thisGameMode {
    int points = 0;
    switch (thisGameMode) {
        case 0:
            if (thisLevel < 6) points = 4000; //kPointsRequiredToCompleteLevels1_5_Primary;
            else if (thisLevel < 11) points = kPointsRequiredToCompleteLevels6_10_Primary;
            else if (thisLevel < 16) points = kPointsRequiredToCompleteLevels11_15_Primary;
            else points = kPointsRequiredToCompleteLevels16_ON_Primary;
            break;
        case 1:
            if (thisLevel < 6) points = 3000; //kPointsRequiredToCompleteLevels1_5_Action;
            else if (thisLevel < 11) points = kPointsRequiredToCompleteLevels6_10_Action;
            else if (thisLevel < 16) points = kPointsRequiredToCompleteLevels11_15_Action;
            else points = kPointsRequiredToCompleteLevels16_ON_Action;
            break;
        case 2:
            if (thisLevel < 6) points = 6000; //kPointsRequiredToCompleteLevels1_5_Infinity;
            else if (thisLevel < 11) points = kPointsRequiredToCompleteLevels6_10_Infinity;
            else if (thisLevel < 16) points = kPointsRequiredToCompleteLevels11_15_Infinity;
            else points = kPointsRequiredToCompleteLevels16_ON_Infinity;
            break;
    }
    return points;
}

- (int)wildcardProbabilityForLevel:(int)thisLevel {
    int probability;
    
    if (thisLevel < 6) probability = kProbabilityOfWildcardSymbolInLevels1_5;
    else if (thisLevel < 11) probability = kProbabilityOfWildcardSymbolInLevels6_10;
    else if (thisLevel < 16) probability = kProbabilityOfWildcardSymbolInLevels11_15;
    else probability = kProbabilityOfWildcardSymbolInLevels16_ON;
    
    return probability;    
}

- (int)shifterProbabilityForLevel:(int)thisLevel {
    int probability;
    
    if (thisLevel < 6) probability = kProbabilityOfShifterSymbolInLevels1_5;
    else if (thisLevel < 11) probability = kProbabilityOfShifterSymbolInLevels6_10;
    else if (thisLevel < 16) probability = kProbabilityOfShifterSymbolInLevels11_15;
    else probability = kProbabilityOfShifterSymbolInLevels16_ON;
    
    return probability;    
}

- (int)corruptedProbabilityForLevel:(int)thisLevel {
    int probability;
    
    if (thisLevel < 6) probability = kProbabilityOfCorruptedSymbolInLevels1_5;
    else if (thisLevel < 11) probability = kProbabilityOfCorruptedSymbolInLevels6_10;
    else if (thisLevel < 16) probability = kProbabilityOfCorruptedSymbolInLevels11_15;
    else probability = kProbabilityOfCorruptedSymbolInLevels16_ON;
    
    return probability;    
}

- (int)hiddenProbabilityForLevel:(int)thisLevel {
    int probability;
    
    if (thisLevel < 6) probability = kProbabilityOfHiddenSymbolInLevels1_5;
    else if (thisLevel < 11) probability = kProbabilityOfHiddenSymbolInLevels6_10;
    else if (thisLevel < 16) probability = kProbabilityOfHiddenSymbolInLevels11_15;
    else probability = kProbabilityOfHiddenSymbolInLevels16_ON;
    
    return probability;    
}


- (void)dealloc {
    [userDefaults release];
    [super dealloc];
}

#pragma NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    plistResponse = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [plistResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *dict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistResponse
                                                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                                                    format:&format
                                                                          errorDescription:&errorDesc];
    [self setValuesFromDictionary:dict];
    [plistResponse release];   
    [connection release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {    
    [plistResponse release];
    [connection release];
}

@end

