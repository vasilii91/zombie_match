//
//  SymbolManager.h
//  Syntax
//
//  Created by Seby Moisei on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "SyntaxSymbol.h"
#import "MSSView.h"

@interface SymbolManager : NSObject {
    ViewController *viewController;
    CGRect normalFrame;
    CGRect engageFrame;
    CGRect explosionFrame;
    MSSView *helperView;
    NSArray *hiddenSymbolAnimationFrames;
    NSArray *superSymbolMorphFrames;
    NSArray *rectifySymbolMorphFrames;
    NSArray *explodingSymbolFrames;
    NSArray *LShapeFrames;
    int wildcardProbability;
    int shifterProbability;
    int corruptedProbability;
    int hiddenProbability;
}

@property (nonatomic, retain) ViewController *viewController;
@property (nonatomic, retain) SyntaxSymbol *thenewSymbol;

- (id)initWithViewController:(ViewController *)controller;
- (void)preload;
- (SyntaxSymbol *)randomSymbolWithMaxType:(int)maxTypes;
- (SyntaxSymbol *)symbolWithType:(int)thisType;
- (void)selectSymbol:(SyntaxSymbol *)thisSymbol;
- (void)deselectSymbol:(SyntaxSymbol *)thisSymbol;
- (void)turnToExplosiveSymbol:(SyntaxSymbol *)thisSymbol;
- (void)turnToSuperSymbol:(SyntaxSymbol *)thisSymbol;
- (void)turnToWildcardSymbol:(SyntaxSymbol *)thisSymbol;
- (void)rectifyCorruptedSymbol:(SyntaxSymbol *)thisSymbol;
- (void)shiftSymbol:(SyntaxSymbol *)thisSymbol toType:(int)thisType;
- (void)revealHiddenSymbol:(SyntaxSymbol *)thisSymbol;

- (void)animHideSymbol:(SyntaxSymbol *)thisSymbol WithDelay:(float)thisDelay;
- (void)animGlowSymbol:(SyntaxSymbol *)thisSymbol;
- (void)animExplodeSymbol:(SyntaxSymbol *)thisSymbol WithDelay:(float)thisDelay;
- (void)animShiftToSuperSymbol:(SyntaxSymbol *)thisSymbol;
- (void)animSuperSymbol:(SyntaxSymbol *)thisSymbol;
- (void)animSuperEliminateSymbol:(SyntaxSymbol *)thisSymbol;
- (void)animRectifySymbol:(SyntaxSymbol *)thisSymbol;
- (void)animShifterSymbol:(SyntaxSymbol *)thisSymbol;
- (void)animGlitchSymbol:(SyntaxSymbol *)thisSymbol withDelay:(float)thisDelay;
- (void)animFlashSymbol:(SyntaxSymbol *)thisSymbol;
- (void)animLShapeOnSymbol:(SyntaxSymbol *)thisSymbol andView:(UIView *)thisView;


- (void)refreshGrid:(NSMutableArray *)thisGrid;
- (void)cleanSymbol:(SyntaxSymbol *)thisSymbol;
- (void)updateProbabilities;
- (void)zeroProbabilities;



@end
