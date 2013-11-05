//
//  SyntaxInfoPopUp.h
//  Syntax
//
//  Created by Seby Moisei on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface SyntaxInfoPopUp : MSSView {
    UIImageView *background;
    SyntaxLabel *title;
    SyntaxLabel *description;
    NSMutableSet *popUpSet;
    BOOL isRemoving;
}

- (id)initForSymbolWithIndex:(CGPoint)thisIndex andSpecialType:(int)thisType andSet:(NSMutableSet *)thisSet;
- (void)removePopUp;

@end
