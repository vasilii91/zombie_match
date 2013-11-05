//
//  SyntaxEngineEngageServer.h
//  Syntax
//
//  Created by Seby Moisei on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyntaxSymbol.h"
#import "ViewController.h"
#import "SymbolManager.h"
#import "SyntaxEngagePacket.h"

@interface SyntaxEngineEngageServer : UIView {
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
    BOOL isGameOver;
    BOOL didClear;
    CGPoint shockwaveCentre;
    SyntaxSymbol *firstTouchedSymbol;
    int noOfNormalMatches; 
    int noOfDoubleMatches;
    int noOfMatchesOf4; 
    int noOfMatchesOf4Explosion; 
    int noOfMatchesOf5; 
    int noOfSuperEliminated; 
    int noOfLShapedMatches; 
    int noOfCascadingMatches;
    int pointsToAdd;
}

@property (nonatomic, retain) ViewController *viewController;
@property (nonatomic, retain) NSMutableArray *gameGrid;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller;

- (void)populateGameField;
- (void)checkIfSymbolNotMakingPattern:(SyntaxSymbol *)thisSymbol;
- (void)selectSymbol:(UIView *)thisSymbol;
- (BOOL)symbol:(CGPoint)firstIndex isNeighbourToSymbol:(CGPoint)secondIndex;
- (void)swapSymbol:(SyntaxSymbol *)firstSymbol withSymbol:(SyntaxSymbol *)secondSymbol;
- (void)swapBackSymbol:(SyntaxSymbol *)firstSymbol withSymbol:(SyntaxSymbol *)secondSymbol;
- (void)eliminateNeightboursOfSymbolAtIndex:(CGPoint)thisIndex;
- (void)eliminateAllSymbolsOfType:(int)thisType;
- (void)eliminateAllSymbolsInLineWithSymbolAtIndex:(CGPoint)thisIndex;
- (void)eraseSymbols;
- (void)checkIfAllSymbolsRepositioned;

- (void)searchPatterns;
- (void)searchPatternLShapeForSymbol:(SyntaxSymbol *)thisSymbol;
- (void)searchPatternHorizontalForSymbol:(SyntaxSymbol *)thisSymbol;
- (void)searchPatternVerticalForSymbol:(SyntaxSymbol *)thisSymbol;

- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex;
- (void)glitch;
- (void)shockWaveFromCenter:(CGPoint)thisCenter;
- (void)clearPoints;
- (void)clearGame;
- (void)endGame;

@end
