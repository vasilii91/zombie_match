//
//  SyntaxMoreView.m
//  Syntax
//
//  Created by Seby Moisei on 9/17/12.
//
//

#import "SyntaxMoreView.h"
#import "ViewController.h"
#import "PlayHavenSDK.h"

@implementation SyntaxMoreView

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        self.alpha = 1;
        

        // Get Free App Button
        getFreeAppButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * freeapplabel = [UIImage imageNamed:@"symbol1.png"];
        getFreeAppButton.frame = CGRectMake(49, 35, 40, 40.0);
        [getFreeAppButton addTarget:viewController action:@selector(getFreeApp) forControlEvents:UIControlEventTouchDown];
        [getFreeAppButton setImage:freeapplabel forState:UIControlStateNormal];
        [self addSubview:getFreeAppButton];
        
        getFreeAppLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(45, 0, 200, 45)];
        getFreeAppLabel.text = @"Get a Free App";
        getFreeAppLabel.center = CGPointMake(70, 85);
        [getFreeAppLabel styleWithSize:25];
        getFreeAppLabel.textAlignment = UITextAlignmentCenter;
        getFreeAppLabel.numberOfLines = 0;
        [self addSubview:getFreeAppLabel];
        
        // Rate App Button
        rateLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * ratelabelimage = [UIImage imageNamed:@"symbol9.png"];
        rateLabelButton.frame = CGRectMake(227, 35, 40, 40);
        [rateLabelButton addTarget:self action:@selector(rate) forControlEvents:UIControlEventTouchDown];
        [rateLabelButton setImage:ratelabelimage forState:UIControlStateNormal];
        [self addSubview:rateLabelButton];
        
        rateLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(100, 0, 200, 45)];
        rateLabel.text = @"Rate on App Store";
        rateLabel.center = CGPointMake(240, 85);
        [rateLabel styleWithSize:25];
        rateLabel.textAlignment = UITextAlignmentCenter;
        rateLabel.numberOfLines = 0;
        [self addSubview:rateLabel];
        
        // Top Scores
        topScoresLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * topscores = [UIImage imageNamed:@"symbol3.png"];
        topScoresLabelButton.frame = CGRectMake(48, 121, 40, 40.0);
        [topScoresLabelButton addTarget:viewController action:@selector(showTopScores) forControlEvents:UIControlEventTouchDown];
        [topScoresLabelButton setImage:topscores forState:UIControlStateNormal];
        [self addSubview:topScoresLabelButton];
        
        topScoresLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(45, 0, 120, 45)];
        topScoresLabel.text = @"Top Scores";
        topScoresLabel.center = CGPointMake(70, 170);
        [topScoresLabel styleWithSize:25];
        topScoresLabel.textAlignment = UITextAlignmentCenter;
        topScoresLabel.numberOfLines = 0;
        [self addSubview:topScoresLabel];
        
        
        // Info
        infoLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * infolabel = [UIImage imageNamed:@"symbol2.png"];
        infoLabelButton.frame = CGRectMake(227, 121, 40, 40.0);
        [infoLabelButton addTarget:viewController action:@selector(showInfoView) forControlEvents:UIControlEventTouchDown];
        [infoLabelButton setImage:infolabel forState:UIControlStateNormal];
        [self addSubview:infoLabelButton];
        
        infoLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(45, 0, 120, 45)];
        infoLabel.text = @"How to Play";
        infoLabel.center = CGPointMake(250, 170);
        [infoLabel styleWithSize:25];
        infoLabel.textAlignment = UITextAlignmentCenter;
        infoLabel.numberOfLines = 0;
        [self addSubview:infoLabel];

        // Share
        shareLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * share = [UIImage imageNamed:@"symbol5.png"];
        shareLabelButton.frame = CGRectMake(48, 300, 40, 40.0);
        [shareLabelButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
        [shareLabelButton setImage:share forState:UIControlStateNormal];
        [self addSubview:shareLabelButton];
        
        shareLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(45, 0, 120, 45)];
        shareLabel.text = @"Tell a Friend";
        shareLabel.center = CGPointMake(70, 360);
        [shareLabel styleWithSize:25];
        shareLabel.textAlignment = UITextAlignmentCenter;
        shareLabel.numberOfLines = 0;
        [self addSubview:shareLabel];
        
        // Email Support
        emailSupportLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * support = [UIImage imageNamed:@"symbol4.png"];
        emailSupportLabelButton.frame = CGRectMake(227, 210, 40, 40.0);
        [emailSupportLabelButton addTarget:self action:@selector(emailSupport) forControlEvents:UIControlEventTouchDown];
        [emailSupportLabelButton setImage:support forState:UIControlStateNormal];
        [self addSubview:emailSupportLabelButton];
        
        emailSupportLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(45, 0, 120, 45)];
        emailSupportLabel.text = @"Email Support";
        emailSupportLabel.center = CGPointMake(245, 260);
        [emailSupportLabel styleWithSize:25];
        emailSupportLabel.textAlignment = UITextAlignmentCenter;
        emailSupportLabel.numberOfLines = 0;
        [self addSubview:emailSupportLabel];
        
        // More Apps
        moreAppsLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * more = [UIImage imageNamed:@"symbol0.png"];
        moreAppsLabelButton.frame = CGRectMake(48, 211, 40, 40.0);
        [moreAppsLabelButton addTarget:viewController action:@selector(moreAppsForFull) forControlEvents:UIControlEventTouchDown];
        [moreAppsLabelButton setImage:more forState:UIControlStateNormal];
        [self addSubview:moreAppsLabelButton];
		
		PHNotificationView *notifView=[[[PHNotificationView alloc] initWithApp:kPlayHavenID
																		secret:kPlayHeavenSecret
																	 placement:@"more_games"] autorelease];
		[moreAppsLabelButton addSubview:notifView];
		notifView.center=CGPointMake(0, 10);
		notifView.tag=playhavenNotificationViewTag;
		[notifView refresh];

        moreAppsLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(90, 0, 120, 90)];
        moreAppsLabel.text = @"More Apps";
        moreAppsLabel.center = CGPointMake(70, 266);
        [moreAppsLabel styleWithSize:25];
        moreAppsLabel.textAlignment = UITextAlignmentCenter;
        moreAppsLabel.numberOfLines = 0;
        [self addSubview:moreAppsLabel];
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {            
            // Buy Ad Free Version
            buyAdFreeVersionButton = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage * buy = [UIImage imageNamed:@"RedXButton.png"];
            buyAdFreeVersionButton.frame = CGRectMake(227, 300, 40, 40.0);
            [buyAdFreeVersionButton addTarget:viewController action:@selector(removeBanner:) forControlEvents:UIControlEventTouchDown];
            [buyAdFreeVersionButton setImage:buy forState:UIControlStateNormal];
            [self addSubview:buyAdFreeVersionButton];
            
            buyAdFreeVersion = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 140, 45)];
            buyAdFreeVersion.text = @"Ad Free Version";
            buyAdFreeVersion.center = CGPointMake(245, 356);
            [buyAdFreeVersion styleWithSize:25];
            buyAdFreeVersion.textAlignment = UITextAlignmentCenter;
            buyAdFreeVersion.numberOfLines = 0;
            [self addSubview:buyAdFreeVersion];
        }
        else {
            shareLabel.center = CGPointMake(160, 360);
            shareLabelButton.frame = CGRectMake(140, 300, 40, 40.0);
        }        
        
        backToMenuButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 22)];
        backToMenuButton.text = @"<< BACK TO MENU";
        backToMenuButton.center = CGPointMake(160, 430);
        [backToMenuButton styleWithSize:25];
        [self addSubview:backToMenuButton];
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:self withAction:^{
           // Don't want anything in here because we don't want it to glitch.
        }];
    }
    else isVisible = NO;
}

- (void)removeAdButton {
    if(buyAdFreeVersion) {
        [buyAdFreeVersion removeFromSuperview];
        buyAdFreeVersion = nil;
    }
    if(buyAdFreeVersionButton) {
        [buyAdFreeVersionButton removeFromSuperview];
        buyAdFreeVersionButton = nil;
    }
    shareLabel.center = CGPointMake(160, 360);
    shareLabelButton.frame = CGRectMake(140, 300, 40, 40.0);
}

- (void)animGlitchLetter:(UIView *)thisLetter {
    // Don't want anything in here because we don't want it to glitch.
}

- (void)rate {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rateLink]];
}

-(void)share {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        [mailController setSubject:@"Check out this cool game..."];
        [mailController setMessageBody:@"Hey, I've been playing this free new match-3 puzzle game that I think you'll love. Careful...it's addictive! http://georiot.co/yAa" isHTML:true];
        mailController.mailComposeDelegate = self;
        [viewController presentModalViewController:mailController animated:FALSE];
    }
}

- (void)emailSupport {
    if ([MFMailComposeViewController canSendMail]) {
        NSString *localeName = [[NSLocale preferredLanguages] objectAtIndex:0];
        NSString *deviceName = [UIDevice currentDevice].model;
        NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        [mailController setToRecipients:[NSArray arrayWithObject:supportEmail]];
        [mailController setSubject:[NSString stringWithFormat:@"Viva Stampede v%@", appVersion]];
        [mailController setMessageBody:[NSString stringWithFormat:@"Message Here. <br/><br/><br/>Locale: %@<br/>Device Model: %@<br/>App Version:%@", localeName, deviceName, appVersion] isHTML:true];
        mailController.mailComposeDelegate = self;
        [viewController presentModalViewController:mailController animated:true];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == backToMenuButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:backToMenuButton withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController showMainView];
                [viewController removeView:self];
            }];
        }];
    }
    
    if ([touch view] == getFreeAppLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:getFreeAppLabel withAction:^{
//            [self fadeOutView:self withAction:^{
                [viewController getFreeApp];
//            }];
        }];
    }
 
    if ([touch view] == rateLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:rateLabel withAction:^{
//            [self touchButton:rateLabel withAction:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rateLink]];
//            }];
        }];
    }
    if ([touch view] == topScoresLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:topScoresLabel withAction:^{
            [viewController showTopScores];
            [viewController removeView:self];
        }];
    }
    if ([touch view] == infoLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:infoLabel withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController showInfoView];
            }];
        }];
    }
    if ([touch view] == shareLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [Flurry logEvent:@"Share App"];
        [self touchButton:shareLabel withAction:^{
            [self touchButton:emailSupportSymbol withAction:^{
                [self share];
            }];
        }];
    }
    if ([touch view] == emailSupportLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:emailSupportLabel withAction:^{
            [self emailSupport];
        }];
    }
    if ([touch view] == moreAppsLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:moreAppsLabel withAction:^{
            [viewController moreAppsForFull];
        }];
    }
    if ([touch view] == buyAdFreeVersion) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:buyAdFreeVersion withAction:^{
            [viewController removeBanner:self];
        }];
    }
}

- (void)removeWithCheck:(id)object {
    if(object) [self removeSubView:object];
}

- (void)dealloc {
//    [self removeWithCheck:backToMenuButton];
//    [self removeWithCheck:infoLabel];
//    [self removeWithCheck:infoLabelButton];
//    [self removeWithCheck:shareLabel];
//    [self removeWithCheck:shareLabelButton];
//    [self removeWithCheck:emailSupportLabel];
//    [self removeWithCheck:emailSupportLabelButton];
//    [self removeWithCheck:topScoresLabel];
//    [self removeWithCheck:topScoresLabelButton];
//    [self removeWithCheck:topScoresSymbol];
//    [self removeWithCheck:rateLabel];
//    [self removeWithCheck:rateLabelButton];
//    [self removeWithCheck:getFreeAppButton];
//    [self removeWithCheck:getFreeAppLabel];
//    if(buyAdFreeVersion) [self removeSubView:buyAdFreeVersion];
//    if(buyAdFreeVersionButton) [self removeSubView:buyAdFreeVersionButton];
    [super dealloc];
}

#pragma MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissModalViewControllerAnimated:YES];
}

@end

