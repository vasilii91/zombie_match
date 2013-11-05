//
//  SyntaxLabel.h
//  Syntax
//
//  Created by Seby Moisei on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SyntaxLabel : UILabel {
    BOOL canAnimate;
    float size;
}

- (void)styleWithSize:(float)thisSize;
- (void)shadowSizeRatio:(float)thisRatio;
- (void)animGlitchWithDelay:(float)thisDelay andDoRepeat:(BOOL)doRepeat;
- (void)animGlitchWithAction:(void (^)(void))action;
- (void)animUpdateWithText:(NSString *)thisString;
- (void)stopAnimatingLabel;

@end
