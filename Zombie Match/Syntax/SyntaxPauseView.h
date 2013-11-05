//
//  SyntaxPauseView.h
//  Syntax
//
//  Created by Seby Moisei on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface SyntaxPauseView : MSSView {
    UIImageView *matchLogo;
    SyntaxLabel *resumeButton;
    SyntaxLabel *mainMenuButton;
    SyntaxLabel *powerUpButton;
    SyntaxLabel *getFreeAppButton;
    SyntaxLabel *SFXButton;
    SyntaxLabel *musicButton;
    UIImageView *powerUpSquare;
    BOOL isGoingToDissapear;    
}

- (void)animGlitchLetter:(UIView *)thisLetter;

@end

