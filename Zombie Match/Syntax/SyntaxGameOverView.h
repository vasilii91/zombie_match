//
//  SyntaxGameOverView.h
//  Syntax
//
//  Created by Seby Moisei on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface SyntaxGameOverView : MSSView {
    SyntaxLabel *gameOverLabel;
    SyntaxLabel *gameOverReasonLabel;
    SyntaxLabel *scoreLabel;
    SyntaxLabel *highScoreLabel;
    SyntaxLabel *bytesLabel;
    UIImageView *bytesIcon;
    UIImageView *powerUpSquare;
    UIButton *getFreeAppButton;
    SyntaxLabel *playAgainButton;
    SyntaxLabel *mainMenuButton;
    UIImageView *backgroundView;
    UIButton *powerUpStore;
}

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller andReason:(NSString *)thisReason;
- (void)animGlitchView:(UIView *)thisView;

@end
