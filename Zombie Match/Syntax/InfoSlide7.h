//
//  InfoSlide7.h
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"
#import "SymbolManager.h"
#import "SyntaxSymbol.h"

@interface InfoSlide7 : MSSView {
    SyntaxLabel *title;
    SymbolManager *symbolManager;
    SyntaxSymbol *wildcard;
    SyntaxSymbol *corrupted;
    SyntaxSymbol *shifter;
    SyntaxSymbol *hidden;
    SyntaxLabel *wildcardText;
    SyntaxLabel *corruptedText;
    SyntaxLabel *shifterText;
    SyntaxLabel *hiddenText;
    BOOL canRelease;
}

@property (nonatomic) BOOL canRelease;

- (id)initSlide;;
- (void)checkRelease;

@end

