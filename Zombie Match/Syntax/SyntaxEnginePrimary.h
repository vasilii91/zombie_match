//
//  SyntaxEnginePrimary.h
//  Syntax
//
//  Created by Seby Moisei on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SyntaxSymbol.h"
#import "SymbolManager.h"

@interface SyntaxEnginePrimary : UIView {
    BOOL isVisible;
    BOOL canTouch;
    ViewController *viewController;
    SymbolManager *symbolManager;    
    NSMutableArray *gameGrid;
    NSMutableArray *hintGrid;
    NSMutableSet *symbolsToRemove;
    NSMutableSet *symbolsToMove;
    NSMutableSet *symbolsToSkip;
    BOOL isShockwave;
    BOOL isCascading;
    BOOL isDoubleMatch;
    BOOL isMoveValid;
    BOOL didSuperEliminate;
    CGPoint shockwaveCentre;
    SyntaxSymbol *firstTouchedSymbol;
    int noOfNormalMatches; 
    int noOfDoubleMatches;
    int noOfShifterMatches; 
    int noOfMatchesOf4; 
    int noOfMatchesOf4Explosion; 
    int noOfMatchesOf5; 
    int noOfSuperEliminated; 
    int noOfLShapedMatches; 
    int noOfCorruptedCleared; 
    int noOfCascadingMatches;
    int pointsToAdd;
    
    NSTimer *timerUntilStuck;
    NSTimer *timerToRemoveStuck;
    UIImageView *stuckMessage;
    BOOL canShowStuck;
    int stuckMessageCounter;
}

@property (nonatomic, retain) UIImageView *stuckMessage;
@property BOOL canShowStuck;
@property (nonatomic, retain) NSMutableArray *gameGrid;
@property (nonatomic, retain) SyntaxSymbol *firstTouchedSymbol;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller;

- (void)populateGameField;
- (void)populateGameFieldForNextLevel;
- (void)checkIfSymbolNotMakingPattern:(SyntaxSymbol *)thisSymbol;
- (void)selectSymbol:(UIView *)thisSymbol;
- (BOOL)symbol:(CGPoint)firstIndex isNeighbourToSymbol:(CGPoint)secondIndex;
- (void)swapSymbol:(SyntaxSymbol *)firstSymbol withSymbol:(SyntaxSymbol *)secondSymbol;
- (void)swapBackSymbol:(SyntaxSymbol *)firstSymbol withSymbol:(SyntaxSymbol *)secondSymbol;
- (void)eliminateNeightboursOfSymbolAtIndex:(CGPoint)thisIndex;
- (void)eliminateAllSymbolsOfType:(int)thisType;
- (void)eliminateAllSymbolsInLineWithSymbolAtIndex:(CGPoint)thisIndex;
- (void)eraseSymbols;
- (void)refillGameField;
- (void)repositionAllSymbols;
- (void)checkIfAllSymbolsRepositioned;
- (void)shiftShifters;
- (void)rectify;
- (void)buyWildcard;
- (void)reshuffle;

- (void)searchPatterns;
- (void)searchPatternLShapeForSymbol:(SyntaxSymbol *)thisSymbol;
- (void)searchPatternHorizontalForSymbol:(SyntaxSymbol *)thisSymbol;
- (void)searchPatternVerticalForSymbol:(SyntaxSymbol *)thisSymbol;

- (BOOL)didFindHint;
- (CGPoint)getHint;
- (void)moveSymbol:(SyntaxSymbol*)thisSymbol inDirection:(CGPoint)thisDirection;
- (BOOL)possiblePatternFoundForSymbol:(SyntaxSymbol *)thisSymbol;


- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex;
- (void)glitch;
- (void)shockWaveFromCenter:(CGPoint)thisCenter;
- (void)clearPoints;
- (void)checkScore;
- (void)resetGame;
- (void)clearGame;

@end
