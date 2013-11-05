//
//  SyntaxMoreView.h
//  Syntax
//
//  Created by Seby Moisei on 9/17/12.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MSSView.h"
#import "SyntaxLabel.h"
#import "Flurry.h"


@interface SyntaxMoreView : MSSView <MFMailComposeViewControllerDelegate> {
    SyntaxLabel *backToMenuButton;
    UIImageView *rateSymbol;
    UIImageView *topScoresSymbol;
    UIImageView *infoSymbol;
    UIImageView *shareSymbol;
    UIImageView *emailSupportSymbol;
    UIImageView *moreAppsSymbol;
    SyntaxLabel *getFreeAppLabel;
    UIButton *getFreeAppButton;
    SyntaxLabel *rateLabel;
    UIButton *rateLabelButton;
    SyntaxLabel *topScoresLabel;
    UIButton *topScoresLabelButton;
    SyntaxLabel *infoLabel;
    UIButton *infoLabelButton;
    SyntaxLabel *shareLabel;
    UIButton *shareLabelButton;
    SyntaxLabel *emailSupportLabel;
    UIButton *emailSupportLabelButton;
    SyntaxLabel *moreAppsLabel;
    UIButton *moreAppsLabelButton;
    SyntaxLabel *buyAdFreeVersion;
    UIButton *buyAdFreeVersionButton;
    BOOL isGoingToDissapear;
}

- (void)animGlitchLetter:(UIView *)thisLetter;
- (void)rate;
- (void)share;
- (void)emailSupport;
- (void)removeAdButton;

@end
