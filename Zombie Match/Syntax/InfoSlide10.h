//
//  InfoSlide10.h
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface InfoSlide10 : MSSView {
    SyntaxLabel *title;
    SyntaxLabel *slideText;
    SyntaxLabel *creditsText;
    BOOL canRelease;
}

@property (nonatomic) BOOL canRelease;

- (id)initSlide;;
- (void)checkRelease;

@end
