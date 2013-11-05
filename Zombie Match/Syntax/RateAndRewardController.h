//
//  RateAndRewardController.h
//  Syntax
//
//  Created by Seby Moisei on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "ViewController.h"


@interface RateAndRewardController : NSObject <UIAlertViewDelegate, MFMailComposeViewControllerDelegate> {
    ViewController *viewController;
    UIAlertView *askForImpression;
    UIAlertView *askForReview;
    UIAlertView *askForEMail;
}

- (id)initWithViewController:(ViewController *)controller;
- (void)refreshReward;
- (void)clearReward;
- (void)checkAndAskToRate;
- (void)countPlaythrough;

@end
