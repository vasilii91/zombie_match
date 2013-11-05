//
//  SyntaxEngineAction.m
//  Syntax
//
//  Created by Seby Moisei on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxEnginePrimary.h"
#import "SyntaxActionView.h"

@implementation SyntaxEngineAction

@synthesize gameGrid;
@synthesize firstTouchedSymbol;
@synthesize canTouch, canShowStuck;
@synthesize isWaitingForLevel, stuckMessage;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame];
    if (self) {
        isVisible = NO;
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        isShockwave = NO;
        isCascading = NO;
        isDoubleMatch = NO;
        viewController = controller;
        symbolManager = [viewController.symbolManager retain];
        [self clearPoints];
        noOfCascadingMatches = 0;
        
        gameGrid = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) [gameGrid addObject:[NSMutableArray array]];
        
        symbolsToRemove = [[NSMutableSet alloc] init];
        symbolsToMove = [[NSMutableSet alloc] init];
        symbolsToSkip = [[NSMutableSet alloc] init];
        firstTouchedSymbol = nil;
        [self populateGameField];
        
        canShowStuck = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshStuckTimer) name:@"refreshStuckTimerAction" object:nil];
        [self refreshStuckTimer];
        stuckMessageCounter = 0;
    }
    return self;
}

- (void)refreshStuckTimer {
    if(timerUntilStuck) {
        [timerUntilStuck invalidate];
        timerUntilStuck = nil;
    }
    [self hideStuckMessage];
    timerUntilStuck = [NSTimer scheduledTimerWithTimeInterval:13.0
                                                       target:self
                                                     selector:@selector(showStuckMessage)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)refreshTimerToRemoveStuck {
    if(timerToRemoveStuck) {
        [timerToRemoveStuck invalidate];
        timerToRemoveStuck = nil;
    }
    timerToRemoveStuck = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                          target:self
                                                        selector:@selector(hideStuckMessage)
                                                        userInfo:nil
                                                         repeats:NO];
}

- (void)showStuckMessage {
    stuckMessageCounter++;
    if(stuckMessageCounter == 3) return;
    if(!stuckMessage) {
        self.stuckMessage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 311, 100)];
        UIImageView *stuckLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stuckpopup.png"]];
        UIImageView *stuckPoint1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stuckarrow.png"]];
        UIImageView *stuckPoint2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stuckarrow.png"]];
        UIImageView *stuckPoint3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stuckarrow.png"]];
        
        [stuckMessage addSubview:stuckLabel];
        [stuckLabel setCenter:CGPointMake(160, 330)];
        [stuckLabel release];
        
        [stuckPoint1 setCenter:CGPointMake(118, 380)];
        [stuckPoint1 setTag:7];
        [stuckMessage addSubview:stuckPoint1];
        [stuckPoint1 release];
        
        [stuckPoint2 setCenter:CGPointMake(180, 380)];
        [stuckPoint2 setTag:7];
        [stuckMessage addSubview:stuckPoint2];
        [stuckPoint2 release];
        
        [stuckPoint3 setCenter:CGPointMake(240, 380)];
        [stuckPoint3 setTag:7];
        [stuckMessage addSubview:stuckPoint3];
        [stuckPoint3 release];
        
        [self.superview addSubview:stuckMessage];
        stuckMessage.alpha = 0;
        [stuckMessage release];
        
        [UIView beginAnimations:@"fade in" context:nil];
        [UIView setAnimationDuration:0.3];
        stuckMessage.alpha = 1;
        [UIView commitAnimations];
        for(UIView *subView in stuckMessage.subviews)
            if(subView.tag == 7)
                [self makeArrowsJump:subView];
    }
    else {
        [UIView beginAnimations:@"fade in" context:nil];
        [UIView setAnimationDuration:0.3];
        stuckMessage.alpha = 1;
        [UIView commitAnimations];
    }
    [self refreshTimerToRemoveStuck];
}

- (void)makeArrowsJump:(UIView *)subView {
    [UIView animateWithDuration:0.5
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                     animations:^{
                         subView.center = CGPointMake(subView.center.x, subView.center.y + 10);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:0
                                             options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                                          animations:^{
                                              subView.center = CGPointMake(subView.center.x, subView.center.y - 10);
                                          }
                                          completion:^(BOOL finished) {
                                              [self makeArrowsJump:subView];
                                          }];
                     }];
}

- (void)hideStuckMessage {
    if(timerToRemoveStuck) {
        [timerToRemoveStuck invalidate];
        timerToRemoveStuck = nil;
    }
    if(stuckMessage) {
        [UIView beginAnimations:@"fade out" context:nil];
        [UIView setAnimationDuration:0.3];
        stuckMessage.alpha = 0.0;
        [UIView commitAnimations];
    }
}

#pragma GRID MANAGEMENT //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (void)reshuffle {
    [viewController.soundController playSound:@"HiddenSymbolMorph"];
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *symbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (!symbol.isKeepable) {
                [symbolManager animHideSymbol:symbol WithDelay:0];
                SyntaxSymbol *symbolToReplace = [symbolManager randomSymbolWithMaxType:7];
                symbolToReplace.isIndex = CGPointMake(i, j);
                symbolToReplace.center = [self CGPointFromIndex:symbolToReplace.isIndex];
                [[gameGrid objectAtIndex:i] replaceObjectAtIndex:j withObject:symbolToReplace];
                [self checkIfSymbolNotMakingPattern:symbolToReplace];
                symbolToReplace.alpha = 0.001;
                [self addSubview:symbolToReplace];
            }
        }
    }
    [self glitch];
}

- (void)populateGameField {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *symbol = [symbolManager randomSymbolWithMaxType:7];
            symbol.isIndex = CGPointMake(i, j);
            symbol.center = [self CGPointFromIndex:symbol.isIndex];
            [[gameGrid objectAtIndex:i] addObject:symbol];
            [self checkIfSymbolNotMakingPattern:symbol];
            symbol.alpha = 0.001;
            [self addSubview:symbol];            
        }      
    }
    canTouch = YES;
}

- (void)populateGameFieldForNextLevel {
    [symbolsToRemove removeAllObjects];
    [symbolsToSkip removeAllObjects];
    [symbolsToMove removeAllObjects];
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *symbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (symbol.isKeepable) {
                symbol.alpha = 0.001;
                [self addSubview:symbol];
                [symbol retain];
            }
            else {
                SyntaxSymbol *symbolToReplace = [symbolManager randomSymbolWithMaxType:7];
                symbolToReplace.isIndex = CGPointMake(i, j);
                symbolToReplace.center = [self CGPointFromIndex:symbolToReplace.isIndex];
                [[gameGrid objectAtIndex:i] replaceObjectAtIndex:j withObject:symbolToReplace];
                [self checkIfSymbolNotMakingPattern:symbolToReplace];
                symbolToReplace.alpha = 0.001;
                [self addSubview:symbolToReplace];                    
            }
        }
    }
    [self glitch];
    [symbolManager performSelector:@selector(refreshGrid:) withObject:gameGrid afterDelay:1];
    canTouch = YES;
}

- (void)checkIfSymbolNotMakingPattern:(SyntaxSymbol *)thisSymbol {
    int x = thisSymbol.isIndex.x;
    int y = thisSymbol.isIndex.y;
    int typeToSkip = thisSymbol.isOfType;
    BOOL hasToChange = NO;
    SyntaxSymbol *symbolToCheck;
    if (x > 1) {
        symbolToCheck = [[gameGrid objectAtIndex:x - 1] objectAtIndex:y];
        if (symbolToCheck.isOfType == typeToSkip) {
            symbolToCheck = [[gameGrid objectAtIndex:x - 2] objectAtIndex:y];
            if (symbolToCheck.isOfType == typeToSkip) hasToChange = YES;
        }        
    }
    if (y > 1) {
        symbolToCheck = [[gameGrid objectAtIndex:x] objectAtIndex:y - 1];
        if (symbolToCheck.isOfType == typeToSkip) {
            symbolToCheck = [[gameGrid objectAtIndex:x] objectAtIndex:y - 2];
            if (symbolToCheck.isOfType == typeToSkip) hasToChange = YES;
        }        
    }
    if (hasToChange) {
        int newType = (arc4random() % 7);
        while (newType == typeToSkip) {
            newType = (arc4random() % 7);
        }
        [symbolManager shiftSymbol:thisSymbol toType:newType];
    }
}

- (void)selectSymbol:(SyntaxSymbol *)thisSymbol {
    if (firstTouchedSymbol == nil) {
        [viewController.soundController playSound:@"SymbolSelect_A"];
        if (thisSymbol.isOfType == 10) {
            [viewController.soundController playSound:@"HiddenSymbolMorph"];
            [symbolManager revealHiddenSymbol:thisSymbol];
            [self searchPatterns];
        }
        else {
            firstTouchedSymbol = [thisSymbol retain];
            [symbolManager selectSymbol:thisSymbol];
        }
    }
    else {
        [viewController.soundController playSound:@"SymbolSelect_B"];
        [symbolManager deselectSymbol:firstTouchedSymbol];
        if (firstTouchedSymbol.isOfType == 7) {
            firstTouchedSymbol.isKeepable = NO;
            [symbolManager shiftSymbol:firstTouchedSymbol toType:thisSymbol.isOfType];
            [self searchPatterns];                
        }
        else if ([self symbol:thisSymbol.isIndex isNeighbourToSymbol:firstTouchedSymbol.isIndex]) {
            if (!(firstTouchedSymbol.isOfType == 11)) [self swapSymbol:thisSymbol withSymbol:firstTouchedSymbol];
            else {
                [symbolsToRemove addObject:firstTouchedSymbol];
                firstTouchedSymbol.isSuperEliminated = YES;
                [self eliminateAllSymbolsOfType:thisSymbol.isOfType];                    
            }
        }           
        [firstTouchedSymbol release];
        firstTouchedSymbol = nil;
    }       
}

- (BOOL)symbol:(CGPoint)firstIndex isNeighbourToSymbol:(CGPoint)secondIndex {
    BOOL isNeighbour = NO;
    if ((abs((firstIndex.x - secondIndex.x)) == 1) & (firstIndex.y == secondIndex.y)) isNeighbour = YES;
    else if ((abs((firstIndex.y - secondIndex.y)) == 1) & (firstIndex.x == secondIndex.x)) isNeighbour = YES;
    return isNeighbour;
}

- (void)swapSymbol:(SyntaxSymbol *)firstSymbol withSymbol:(SyntaxSymbol *)secondSymbol {
    canTouch = NO;
    
    NSMutableArray *firstSymbolRow = [gameGrid objectAtIndex:firstSymbol.isIndex.x];
    NSMutableArray *secondSymbolRow = [gameGrid objectAtIndex:secondSymbol.isIndex.x];
    [firstSymbolRow replaceObjectAtIndex:firstSymbol.isIndex.y withObject:secondSymbol];
    [secondSymbolRow replaceObjectAtIndex:secondSymbol.isIndex.y withObject:firstSymbol];
    
    CGPoint temp = firstSymbol.isIndex;
    firstSymbol.isIndex = secondSymbol.isIndex;
    secondSymbol.isIndex = temp;
    
    [firstTouchedSymbol release];
    firstTouchedSymbol = nil;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         firstSymbol.center = [self CGPointFromIndex:firstSymbol.isIndex];
                         firstSymbol.alpha = 1;
                         secondSymbol.center = [self CGPointFromIndex:secondSymbol.isIndex];
                         secondSymbol.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         isMoveValid = NO;
                         isDoubleMatch = YES;
                         [self searchPatterns];                         
                         if (!isMoveValid) [self swapBackSymbol:firstSymbol withSymbol:secondSymbol];
                         else [self shiftShifters];
                     }];  
}

- (void)swapBackSymbol:(SyntaxSymbol *)firstSymbol withSymbol:(SyntaxSymbol *)secondSymbol {
    canTouch = NO;
    [viewController.soundController playSound:@"NoMatch"];
    
    NSMutableArray *firstSymbolRow = [gameGrid objectAtIndex:firstSymbol.isIndex.x];
    NSMutableArray *secondSymbolRow = [gameGrid objectAtIndex:secondSymbol.isIndex.x];
    [firstSymbolRow replaceObjectAtIndex:firstSymbol.isIndex.y withObject:secondSymbol];
    [secondSymbolRow replaceObjectAtIndex:secondSymbol.isIndex.y withObject:firstSymbol];
    
    CGPoint temp = firstSymbol.isIndex;
    firstSymbol.isIndex = secondSymbol.isIndex;
    secondSymbol.isIndex = temp;
    
    [firstTouchedSymbol release];
    firstTouchedSymbol = nil;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         firstSymbol.center = [self CGPointFromIndex:firstSymbol.isIndex];
                         firstSymbol.alpha = 1;
                         secondSymbol.center = [self CGPointFromIndex:secondSymbol.isIndex];
                         secondSymbol.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         canTouch = YES;                         
                     }];      
}

- (void)eliminateNeightboursOfSymbolAtIndex:(CGPoint)thisIndex {
    int m;
    int n;
    for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
            m = thisIndex.x + i;
            n = thisIndex.y + j;
            if ((m > -1) & (m < 8) & (n > -1) & (n < 8)) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:m] objectAtIndex:n];
                if (symbolToAdd.isOfType > 6) [symbolsToSkip addObject:symbolToAdd];
                if (!([symbolsToRemove containsObject:symbolToAdd]) & (![symbolsToSkip containsObject:symbolToAdd])) {
                    [symbolsToRemove addObject:symbolToAdd];
                    symbolToAdd.isToExplode = YES;
                }
            }
        }
    }    
}

- (void)eliminateAllSymbolsOfType:(int)thisType {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *symbolToCheck = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (symbolToCheck.isOfType == thisType) {
                symbolToCheck.isSuperEliminated = YES;
                [symbolsToRemove addObject:symbolToCheck];
                noOfSuperEliminated++;
            }
        }
    }
    [self eraseSymbols]; 
}

- (void)eliminateAllSymbolsInLineWithSymbolAtIndex:(CGPoint)thisIndex {
    for (int i = 0; i < 8; i++) {
        SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:i] objectAtIndex:thisIndex.y];
        if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];    
    }
    for (int j = 0; j < 8; j++) {
        SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisIndex.x] objectAtIndex:j];
        if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                        
    }    
}

- (void)eraseSymbols {
    canTouch = NO;
    if (isShockwave) {
        [self shockWaveFromCenter:shockwaveCentre];
        shockwaveCentre = CGPointMake(-1, -1);
    }
    
    didSuperEliminate = NO;
    
    for (SyntaxSymbol *thisSymbol in symbolsToRemove) {
        if (![symbolsToSkip containsObject:thisSymbol]) {
            [[gameGrid objectAtIndex:thisSymbol.isIndex.x] removeObject:thisSymbol];
            if (thisSymbol.isShifter) noOfShifterMatches++;
            if (thisSymbol.isOfType == 9) noOfCorruptedCleared++;
            if (thisSymbol.isToExplode) [symbolManager animExplodeSymbol:thisSymbol WithDelay:(float) ((arc4random() % 5) / 10.0)];
            else if (thisSymbol.isLShapeCorner )[symbolManager animLShapeOnSymbol:thisSymbol andView:self];
            else if (thisSymbol.isSuperEliminated) {
                [symbolManager animSuperEliminateSymbol:thisSymbol];
                didSuperEliminate = YES;
            }
            else [symbolManager animHideSymbol:thisSymbol WithDelay:0];            
        }
    }    
    [symbolsToRemove removeAllObjects];
    [symbolsToSkip removeAllObjects];
    
    if (isCascading) noOfCascadingMatches++;
    
    if (noOfNormalMatches > 0) [viewController.soundController playSound:@"SymbolElimination"];
    if (noOfMatchesOf4 > 0) [viewController.soundController playSound:@"4Match"];
    if (noOfMatchesOf4Explosion > 0) [viewController.soundController playSound:@"4Match_Explosion"];
    if (noOfMatchesOf5 > 0) [viewController.soundController playSound:@"5Match"];
    if (noOfLShapedMatches > 0) [viewController.soundController playSound:@"LMatch"];
    if (noOfSuperEliminated > 0) [viewController.soundController playSound:@"SuperSymbolElimination"];
    
    pointsToAdd = noOfNormalMatches * viewController.valuesManager.kPointsStandardMatch +
    noOfMatchesOf4 * viewController.valuesManager.kPoints4Match +
    noOfMatchesOf4Explosion * viewController.valuesManager.kPoints4MatchExplosion +
    noOfMatchesOf5 * viewController.valuesManager.kPoints5Match +
    noOfLShapedMatches * viewController.valuesManager.kPointsLMatch +
    noOfSuperEliminated * viewController.valuesManager.kPointsSuperEliminatedSymbol +
    noOfShifterMatches * viewController.valuesManager.kPointsShifterMatch +
    noOfCorruptedCleared * viewController.valuesManager.kPointsCorruptedEliminated +
    noOfCascadingMatches * viewController.valuesManager.kPointsCascadingMatch +
    noOfDoubleMatches * viewController.valuesManager.kPointsDoubleMatch;
    
    [viewController.actionView addPoints:pointsToAdd];
    [self clearPoints];
    
    isCascading = YES;
    
    [self refillGameField];
}

- (void)refillGameField {
    for (int i = 0; i < 8; i++) {
        int m = [[gameGrid objectAtIndex:i] count];
        if (m < 8) {
            for (int j = 0; j < 8 - m; j++) {
                SyntaxSymbol *newSymbol = [symbolManager randomSymbolWithMaxType:7];
                newSymbol.center = [self CGPointFromIndex:CGPointMake(i, 8+j)];
                newSymbol.isIndex = CGPointMake(i, 8+j);
                [self addSubview:newSymbol];
                [[gameGrid objectAtIndex:i] addObject:newSymbol];                
            }
        }
    }
    [self repositionAllSymbols];
}

- (void)repositionAllSymbols {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (!(thisSymbol.isIndex.y == j)) {
                thisSymbol.dropSize = thisSymbol.isIndex.y - j;
                thisSymbol.isIndex = CGPointMake(i, j);
                [symbolsToMove addObject:thisSymbol];            
            }            
        }
    }
    float a;
    if (didSuperEliminate) a = 1.15;
    else a = 0.15;
    int k = 0;
    int l = 0;
    float delay;
    float time;
    BOOL didFindSpot;
    for (int i = 0; i < 8; i++) {
        k = 0;
        didFindSpot = NO;
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if ([symbolsToMove containsObject:thisSymbol]) {
                if (!didFindSpot) l++;
                didFindSpot = YES;
                time = sqrtf(0.05 * thisSymbol.dropSize);
                delay = k * 0.1 + l * 0.05 + a;
                [UIView animateWithDuration:time
                                      delay:delay
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     thisSymbol.center = [self CGPointFromIndex:thisSymbol.isIndex];
                                 }
                                 completion:^(BOOL finished) {
                                     [symbolsToMove removeObject:thisSymbol];
                                     [self checkIfAllSymbolsRepositioned];
                                 }];                
                k++;
            }
        }
    }
}

- (void)checkIfAllSymbolsRepositioned {
    if ([symbolsToMove count] == 0) [self searchPatterns];
}

- (void)shiftShifters {
    int k;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (thisSymbol.isShifter) {
                k = arc4random() % 2;
                if (k == 0) [symbolManager shiftSymbol:thisSymbol toType:arc4random() % 7];
            }
        }
    }
}

- (void)rectify {
    [symbolManager rectifyCorruptedSymbol:firstTouchedSymbol];
    [self selectSymbol:firstTouchedSymbol];
    [self performSelector:@selector(searchPatterns) withObject:nil afterDelay:1.6];
}

- (void)buyWildcard {
    [symbolManager turnToWildcardSymbol:firstTouchedSymbol];
    [self selectSymbol:firstTouchedSymbol];    
}

#pragma PATTERN SEARCHING //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (void)searchPatterns {
    
    ///L-shaped pattern
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *searchedSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (searchedSymbol.isOfType < 7) if (![symbolsToRemove containsObject:searchedSymbol]) [self searchPatternLShapeForSymbol:searchedSymbol];
        }
    }
    
    ///horizontal patterns
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *searchedSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (searchedSymbol.isOfType < 7) if (![symbolsToRemove containsObject:searchedSymbol]) [self searchPatternHorizontalForSymbol:searchedSymbol];
        }
    } 
    
    ///vertical patterns
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 6; j++) {
            SyntaxSymbol *searchedSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (searchedSymbol.isOfType < 7) if (![symbolsToRemove containsObject:searchedSymbol]) [self searchPatternVerticalForSymbol:searchedSymbol];            
        }
    }
    
    if ([symbolsToRemove count] > 0) {
        isMoveValid = YES;
        if ((isDoubleMatch) & ([symbolsToRemove count] > 5)) noOfDoubleMatches++;
        [self eraseSymbols];
    }
    else {
        if (viewController.actionView.isGameOver) {
            [viewController.actionView proposeReshuffle];
        }
        else {            
            isCascading = NO;
            noOfCascadingMatches = 0;
            [self checkScore];
            [viewController.actionView checkForInfoPopUps];
            canTouch = YES;
        }
    }
    isDoubleMatch = NO;
}

- (void)searchPatternLShapeForSymbol:(SyntaxSymbol *)thisSymbol {
    int x = thisSymbol.isIndex.x;
    int y = thisSymbol.isIndex.y;
    BOOL hasHorizontal = NO;
    BOOL hasVertical = NO;
    
    if (x > 1) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x - 1] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            nextSymbol = [[gameGrid objectAtIndex:x - 2] objectAtIndex:y];
            if (thisSymbol.isOfType == nextSymbol.isOfType) hasHorizontal = YES;
        }
    }
    if (x < 6) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x + 1] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            nextSymbol = [[gameGrid objectAtIndex:x + 2] objectAtIndex:y];
            if (thisSymbol.isOfType == nextSymbol.isOfType) hasHorizontal = YES;
        }
    }
    if (y > 1) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y - 1];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y - 2];
            if (thisSymbol.isOfType == nextSymbol.isOfType) hasVertical = YES;
        }
    }
    if (y < 6) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y + 1];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y + 2];
            if (thisSymbol.isOfType == nextSymbol.isOfType) hasVertical = YES;
        }
    }
    
    if (hasHorizontal & hasVertical) {
        thisSymbol.isLShapeCorner = YES;
        noOfLShapedMatches++;
        [self eliminateAllSymbolsInLineWithSymbolAtIndex:thisSymbol.isIndex];        
    }
}

- (void)searchPatternHorizontalForSymbol:(SyntaxSymbol *)thisSymbol {
    int x = thisSymbol.isIndex.x + 1;
    int y = thisSymbol.isIndex.y;
    int matched = 1;
    BOOL canBreak = NO;
    BOOL canEliminateNeighbours = NO;
    
    if (thisSymbol.isExplosive) canEliminateNeighbours = YES;
    
    while (x < 8) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            matched++;
            if (nextSymbol.isExplosive) canEliminateNeighbours = YES;
        }
        else canBreak = YES;       
        x++;
        if (canBreak) break;        
    }
    
    x = thisSymbol.isIndex.x;
    switch (matched) {
        case 5:
            noOfMatchesOf5++;
            for (int i = 0; i < matched; i++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x + i] objectAtIndex:thisSymbol.isIndex.y];
                if (i == 0) {
                    [symbolsToSkip addObject:symbolToAdd];
                    [symbolManager turnToSuperSymbol:symbolToAdd];
                }
                else {
                    if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                    
                }                
            }
            break;
        case 4:
            noOfMatchesOf4++;
            for (int i = 0; i < matched; i++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x + i] objectAtIndex:thisSymbol.isIndex.y];
                if (i == 0) {
                    [symbolsToSkip addObject:symbolToAdd];
                    [symbolManager turnToExplosiveSymbol:symbolToAdd];
                }
                else {
                    if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                    
                }                
            }
            break;
        case 3:
            noOfNormalMatches++;
            for (int i = 0; i < matched; i++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x + i] objectAtIndex:thisSymbol.isIndex.y];
                if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];
            }
            break;            
        default:
            break;
    }
    if (canEliminateNeighbours & (matched > 2)) {
        noOfMatchesOf4Explosion++;
        for (int i = 0; i < matched; i++) {
            SyntaxSymbol *symbolToCheck = [[gameGrid objectAtIndex:thisSymbol.isIndex.x + i] objectAtIndex:thisSymbol.isIndex.y];
            symbolToCheck.isToExplode = YES;
            [self eliminateNeightboursOfSymbolAtIndex:symbolToCheck.isIndex];
        }        
        isShockwave = YES;
        shockwaveCentre = CGPointMake(x, y); 
    }
}

- (void)searchPatternVerticalForSymbol:(SyntaxSymbol *)thisSymbol {
    int x = thisSymbol.isIndex.x;
    int y = thisSymbol.isIndex.y + 1;
    int matched = 1;
    BOOL canBreak = NO;
    BOOL canEliminateNeighbours = NO;
    
    if (thisSymbol.isExplosive) canEliminateNeighbours = YES;
    
    while (y < 8) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            matched++;
            if (nextSymbol.isExplosive) canEliminateNeighbours = YES;
        }
        else canBreak = YES;       
        y++;
        if (canBreak) break;        
    }
    
    y = thisSymbol.isIndex.y;
    switch (matched) {
        case 5:
            noOfMatchesOf5++;
            for (int j = 0; j < matched; j++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x] objectAtIndex:thisSymbol.isIndex.y + j];
                if (j == 0) {
                    [symbolsToSkip addObject:symbolToAdd];
                    [symbolManager turnToSuperSymbol:symbolToAdd];
                }
                else {
                    if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                    
                }                
            }
            break;
        case 4:
            noOfMatchesOf4++;
            for (int j = 0; j < matched; j++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x] objectAtIndex:thisSymbol.isIndex.y + j];
                if (j == 0) {
                    [symbolsToSkip addObject:symbolToAdd];
                    [symbolManager turnToExplosiveSymbol:symbolToAdd]; 
                }
                else {
                    if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                    
                }                
            }
            break;
        case 3:
            noOfNormalMatches++;
            for (int j = 0; j < matched; j++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x] objectAtIndex:thisSymbol.isIndex.y + j];
                if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];
            }
            break;            
        default:
            break;
    }
    if (canEliminateNeighbours & (matched > 2)) {
        noOfMatchesOf4Explosion++;
        for (int j = 0; j < matched; j++) {
            SyntaxSymbol *symbolToCheck = [[gameGrid objectAtIndex:thisSymbol.isIndex.x] objectAtIndex:thisSymbol.isIndex.y + j];
            symbolToCheck.isToExplode = YES;
            [self eliminateNeightboursOfSymbolAtIndex:symbolToCheck.isIndex];
        } 
        isShockwave = YES;
        shockwaveCentre = CGPointMake(x, y); 
    }
}

#pragma HINT SYSTEM //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (BOOL)didFindHint {
    CGPoint hintPos = [self getHint];
    if (hintPos.x > -1) {
        SyntaxSymbol *hintSymbol = [[gameGrid objectAtIndex:hintPos.x] objectAtIndex:hintPos.y];
        [symbolManager animFlashSymbol:hintSymbol];
        return  YES;
    }
    else return NO;
}

- (CGPoint)getHint {
    BOOL possiblePatternFount = NO;
    BOOL foundSpecialSymbol = NO;
    CGPoint hint = CGPointMake(-1, -1);
    CGPoint specialPos = CGPointMake(-1, -1);
    hintGrid = [gameGrid copy];
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (!possiblePatternFount) {
                SyntaxSymbol *symbolToTest = [[[hintGrid objectAtIndex:i] objectAtIndex:j] retain];
                if ((symbolToTest.isOfType == 7) | (symbolToTest.isOfType == 11) | (symbolToTest.isOfType == 10)) {
                    foundSpecialSymbol = YES;
                    specialPos = CGPointMake(i, j);
                }
                else {
                    if (i > 0) {
                        [self moveSymbol:symbolToTest inDirection:CGPointMake(-1, 0)];
                        possiblePatternFount = [self possiblePatternFoundForSymbol:symbolToTest];
                        [self moveSymbol:symbolToTest inDirection:CGPointMake(1, 0)];
                        if (possiblePatternFount) hint = CGPointMake(i, j);
                    }
                    if (i < 7) {
                        [self moveSymbol:symbolToTest inDirection:CGPointMake(1, 0)];
                        possiblePatternFount = [self possiblePatternFoundForSymbol:symbolToTest];
                        [self moveSymbol:symbolToTest inDirection:CGPointMake(-1, 0)];
                        if (possiblePatternFount) hint = CGPointMake(i, j);
                    }
                    if (j > 0) {
                        [self moveSymbol:symbolToTest inDirection:CGPointMake(0, -1)];
                        possiblePatternFount = [self possiblePatternFoundForSymbol:symbolToTest];
                        [self moveSymbol:symbolToTest inDirection:CGPointMake(0, 1)];
                        if (possiblePatternFount) hint = CGPointMake(i, j);
                    }
                    if (j < 7) {
                        [self moveSymbol:symbolToTest inDirection:CGPointMake(0, 1)];
                        possiblePatternFount = [self possiblePatternFoundForSymbol:symbolToTest];
                        [self moveSymbol:symbolToTest inDirection:CGPointMake(0, -1)];
                        if (possiblePatternFount) hint = CGPointMake(i, j);
                    }
                }
                [symbolToTest release];
            }
        }
    }
    [hintGrid release];
    if (possiblePatternFount) return hint;
    else if (foundSpecialSymbol) return specialPos;
    else return hint;
}

- (void)moveSymbol:(SyntaxSymbol*)thisSymbol inDirection:(CGPoint)thisDirection {
    CGPoint thisIndex = thisSymbol.isIndex;
    SyntaxSymbol *firstSymbol = thisSymbol;
    SyntaxSymbol *secondSymbol = [[hintGrid objectAtIndex:thisIndex.x + thisDirection.x] objectAtIndex:thisIndex.y + thisDirection.y];
    
    NSMutableArray *firstSymbolRow = [hintGrid objectAtIndex:firstSymbol.isIndex.x];
    NSMutableArray *secondSymbolRow = [hintGrid objectAtIndex:secondSymbol.isIndex.x];
    
    [firstSymbolRow replaceObjectAtIndex:firstSymbol.isIndex.y withObject:secondSymbol];
    [secondSymbolRow replaceObjectAtIndex:secondSymbol.isIndex.y withObject:firstSymbol];
    
    CGPoint temp = firstSymbol.isIndex;
    firstSymbol.isIndex = secondSymbol.isIndex;
    secondSymbol.isIndex = temp;
}

- (BOOL)possiblePatternFoundForSymbol:(SyntaxSymbol *)thisSymbol {
    if (thisSymbol.isOfType == 9) return NO;
    CGPoint thisIndex = thisSymbol.isIndex;
    BOOL canBreak = NO;
    int x = thisIndex.x;
    int y = thisIndex.y;
    int matchL = 0;
    int matchR = 0;
    int matchD = 0;
    int matchU = 0;
    
    int matchH;
    int matchV;
    
    while (x > 0) {
        SyntaxSymbol *nextSymbol = [[hintGrid objectAtIndex:x - 1] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            matchL++;
        }
        else canBreak = YES;       
        x--;
        if (canBreak) break;        
    }
    canBreak = NO;
    x = thisIndex.x;
    
    while (x < 7) {
        SyntaxSymbol *nextSymbol = [[hintGrid objectAtIndex:x + 1] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            matchR++;
        }
        else canBreak = YES;       
        x++;
        if (canBreak) break;        
    }
    canBreak = NO;
    x = thisIndex.x;
    
    while (y > 0) {
        SyntaxSymbol *nextSymbol = [[hintGrid objectAtIndex:x] objectAtIndex:y - 1];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            matchD++;
        }
        else canBreak = YES;       
        y--;
        if (canBreak) break;        
    }
    canBreak = NO;
    y = thisIndex.y;
    
    while (y < 7) {
        SyntaxSymbol *nextSymbol = [[hintGrid objectAtIndex:x] objectAtIndex:y + 1];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            matchU++;
        }
        else canBreak = YES;       
        y++;
        if (canBreak) break;        
    }
    
    matchH = matchL + matchR + 1;
    matchV = matchD + matchU + 1; 
    
    if ((matchH > 2) || (matchV > 2)) return YES;
    else return NO;    
}

#pragma ANIMATIONS AND OTHERS //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex {
    return CGPointMake(20 + (thisIndex.x * 40), 320 - (20 + (thisIndex.y * 40)));
}

- (void)glitch {
    SyntaxSymbol *symbolToGlitch;
    float delay;
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            symbolToGlitch = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            delay = sqrtf(i*i + j*j) / 15;
            [symbolManager animGlitchSymbol:symbolToGlitch withDelay:delay];
        }      
    }    
}

- (void)shockWaveFromCenter:(CGPoint)thisCenter {
    isShockwave = NO;
    
    SyntaxSymbol *symbolToGlitch;
    float delay;
    float m = thisCenter.x;
    float n = thisCenter.y;
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            symbolToGlitch = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (![symbolsToRemove containsObject:symbolToGlitch]) {
                delay = sqrtf((i - m)*(i - m) + (j - n)*(j - n)) / 15;
                [symbolManager animGlitchSymbol:symbolToGlitch withDelay:delay];
            }            
        }      
    }        
}

- (void)clearPoints {
    noOfNormalMatches = 0;
    noOfDoubleMatches = 0;
    noOfShifterMatches = 0;
    noOfMatchesOf4 = 0;
    noOfMatchesOf4Explosion = 0;
    noOfMatchesOf5 = 0;
    noOfSuperEliminated = 0;
    noOfLShapedMatches = 0;
    noOfCorruptedCleared = 0;
}

- (void)checkScore {
    if (viewController.statsManager.currentLevelScore >= viewController.statsManager.pointsToCompleteLevel) [viewController.actionView showLevelComplete];
}

- (void)resetGame {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *symbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            [symbolManager animHideSymbol:symbol WithDelay:0];
        }
        [[gameGrid objectAtIndex:i] removeAllObjects];
    }
    [symbolsToRemove removeAllObjects];
    [symbolsToSkip removeAllObjects];
    [symbolsToMove removeAllObjects];
    [self populateGameField];    
}

- (void)clearGame {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *symbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            [symbolManager animHideSymbol:symbol WithDelay:(float) ((arc4random() % 100) / 100.0)];
        }
    }
    [symbolsToRemove removeAllObjects];
    [symbolsToSkip removeAllObjects];
    [symbolsToMove removeAllObjects];
}

////////////////
//////////////////////////////////////////////////---> Input & App Specific <---///////////////////////////////////////////////////
///////////////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [viewController.actionView checkIfPowerUpsNeedToGlow];
    [self refreshStuckTimer];
    if (isWaitingForLevel) {
        [viewController.actionView countdown];
        isWaitingForLevel = NO;
    }
    if (canTouch) {
        UITouch *touch = [touches anyObject];
        if ([[touch view] isKindOfClass:[SyntaxSymbol class]]) {
            SyntaxSymbol *thisSymbol = (SyntaxSymbol *)[touch view];      
            [self selectSymbol:thisSymbol];
        }            
    }         
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (canTouch) {
        UITouch *touch = [touches anyObject];
        if ([[touch view] isKindOfClass:[SyntaxSymbol class]]) {
            SyntaxSymbol *thisSymbol = (SyntaxSymbol *)[touch view];
            if (thisSymbol == firstTouchedSymbol) {
                CGPoint location = [touch locationInView:self];
                float dx = thisSymbol.center.x - location.x;
                float dy = thisSymbol.center.y - location.y;
                if ((abs(dx) > 20) | (abs(dy) > 20)) {
                    CGPoint direction;
                    if (abs(dx) > abs(dy)) {
                        if (dx > 0) direction = CGPointMake(-1, 0);
                        else direction = CGPointMake(1, 0);
                    }
                    else {
                        if (dy > 0) direction = CGPointMake(0, 1);
                        else direction = CGPointMake(0, -1);            
                    }
                    CGPoint posibleIndex = CGPointMake(thisSymbol.isIndex.x + direction.x, thisSymbol.isIndex.y + direction.y);
                    if ((posibleIndex.x > -1) & (posibleIndex.x < 8) & (posibleIndex.y > -1) & (posibleIndex.y < 8)) {
                        SyntaxSymbol *otherSymbol = [[gameGrid objectAtIndex:posibleIndex.x] objectAtIndex:posibleIndex.y];
                        if ([self symbol:thisSymbol.isIndex isNeighbourToSymbol:otherSymbol.isIndex]) {
                            [self swapSymbol:thisSymbol withSymbol:otherSymbol];
                            [symbolManager deselectSymbol:thisSymbol];
                        }
                    }
                }            
            }
        }        
    }
}

- (void)dealloc {
    NSLog(@"action engine released");
    self.stuckMessage = nil;
    [timerUntilStuck invalidate];
    [timerToRemoveStuck invalidate];
    [viewController release];
    [symbolManager release];
    [symbolsToRemove removeAllObjects]; [symbolsToRemove release];
    [symbolsToMove removeAllObjects]; [symbolsToMove release];
    [symbolsToSkip removeAllObjects]; [symbolsToSkip release];
    for (NSMutableArray *col in gameGrid) {
        for (SyntaxSymbol *symbol in col) {
            [symbolManager animHideSymbol:symbol WithDelay:0];
        }
        [col removeAllObjects];
    }
    [gameGrid removeAllObjects]; [gameGrid release];
    if (firstTouchedSymbol != nil) [firstTouchedSymbol release];
    [super dealloc];
}

@end

