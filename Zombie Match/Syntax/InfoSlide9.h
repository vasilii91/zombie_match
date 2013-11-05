//
//  InfoSlide9.h
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface InfoSlide9 : MSSView {
    SyntaxLabel *title;
    SyntaxLabel *slideText;
    SyntaxLabel *PPF;
    SyntaxLabel *wildcard;
    SyntaxLabel *rectifier;
    SyntaxLabel *PPFText;
    SyntaxLabel *wildcardText;
    SyntaxLabel *rectifierText;
    BOOL canRelease;
    UIImageView *tokens;
    UIImageView *clues;
    UIImageView *chameleon;
    UIImageView *platTrap;
}

@property (nonatomic) BOOL canRelease;

- (id)initSlide;;
- (void)checkRelease;

@end

