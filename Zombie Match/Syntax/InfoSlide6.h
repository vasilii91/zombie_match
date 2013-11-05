//
//  InfoSlide6.h
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"
#import "SyntaxSymbol.h"

@class SymbolManager;

@interface InfoSlide6 : MSSView {
    SymbolManager *symbolManager;
    SyntaxLabel *title;
    SyntaxLabel *slidetext;
    NSMutableSet *allSymbols;
    SyntaxSymbol *symbolA;
    SyntaxSymbol *symbolB;
    SyntaxLabel *promptButton;
    BOOL canRelease;
}

@property (nonatomic) BOOL canRelease;

- (id)initSlide;;
- (void)initSymbols;
- (void)step1;
- (void)step2;
- (void)releaseSymbols;
- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex;

@end
