//
//  InfoSlide3.h
//  Syntax
//
//  Created by Seby Moisei on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"
#import "SyntaxSymbol.h"

@class SymbolManager;

@interface InfoSlide3 : MSSView {
    SymbolManager *symbolManager;
    SyntaxLabel *title;
    SyntaxLabel *slidetext;
    NSMutableSet *allSymbols;
    SyntaxSymbol *symbolToMakeSuper;
    SyntaxSymbol *symbolA;
    SyntaxSymbol *symbolB;
    BOOL canRelease;
}

@property (nonatomic) BOOL canRelease;

- (id)initSlide;;
- (void)initSymbols;
- (void)step1;
- (void)step2;
- (void)step3;
- (void)step4;
- (void)step5;
- (void)step6;
- (void)step7;
- (void)step8;
- (void)releaseSymbols;
- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex;

@end

