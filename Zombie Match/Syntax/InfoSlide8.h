//
//  InfoSlide8.h
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface InfoSlide8 : MSSView {
    SyntaxLabel *title;
    UIImageView *byte;
    SyntaxLabel *byteText;
    BOOL canRelease;
}

@property (nonatomic) BOOL canRelease;

- (id)initSlide;;
- (void)checkRelease;

@end

