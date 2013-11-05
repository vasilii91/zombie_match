//
//  RateAndRewardController.m
//  Syntax
//
//  Created by Seby Moisei on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RateAndRewardController.h"

@implementation RateAndRewardController

- (id)initWithViewController:(ViewController *)controller {
	if ((self = [super init])) {
        viewController = [controller retain];        
    }
	return self;
}

- (void)refreshReward {
    [self clearReward];
    
    NSLog(@"refreshing reward");    
    UIApplication *app = [[UIApplication sharedApplication] retain];
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:604800];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSHourCalendarUnit) fromDate:fireDate];
    NSInteger hour = [dateComponents hour];
    
    NSLog(@"%d", hour);
    
    UILocalNotification *notification = [[[UILocalNotification alloc] init] autorelease];
    if (notification) {
        notification.fireDate = fireDate;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        if ((hour > 8) & (hour < 22)) notification.soundName = @"SFX-LMatch.caf";
        else notification.soundName = nil;
        notification.alertBody = @"Whoa, killer! You just scored 500 free Tokens. Come play Zombies Matches and power up now!";
        notification.alertAction = @"Get 'em!";
        notification.applicationIconBadgeNumber = 500;
        [app scheduleLocalNotification:notification];
    }
}

- (void)clearReward {
    NSLog(@"clearing reward");
    UIApplication *app = [[UIApplication sharedApplication] retain];
    
    app.applicationIconBadgeNumber = 0;
    
    NSArray *oldNotifications = [app scheduledLocalNotifications];    
    if ([oldNotifications count] > 0) [app cancelAllLocalNotifications];    
}

- (void)checkAndAskToRate {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL userDidRate = [userDefaults boolForKey:@"userDidRate"];
    
    if (!userDidRate) {
        int numberOfPlays = [userDefaults integerForKey:@"numberOfPlays"];
        if (numberOfPlays > 6) {
            [userDefaults setInteger:0 forKey:@"numberOfPlays"];
            askForImpression = [[UIAlertView alloc] initWithTitle:@"Zombies Matches"
                                                          message:@"Are you enjoying Zombies Matches?"
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"I have a problem.", @"I really like it!", nil];
            [[askForImpression autorelease] show];
        }
    }    
}

- (void)countPlaythrough {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int numberOfPlays = [userDefaults integerForKey:@"numberOfPlays"] + 1;
    [userDefaults setInteger:numberOfPlays forKey:@"numberOfPlays"];
}

- (void)dealloc {
    [viewController release];
    [super dealloc];
}

#pragma UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == askForImpression) {
        if (buttonIndex == 1) {
            askForReview = [[UIAlertView alloc] initWithTitle:@"Zombies Matches"
                                                      message:@"Thank You \ue057.Please rate and review Zombies Matches in the App Store."
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"Maybe Later", @"Rate Viva", nil];
            [[askForReview autorelease] show];
        }
        else {
            askForEMail = [[UIAlertView alloc] initWithTitle:@"Viva Stampede"
                                                     message:@"So sorry you seem to be experiencing a problem with Zombies Matches. We're an independent developer, and it's very important to us that we release quality games that you enjoy playing. Please tap the button below to send an email directly to our support team so we can work with you to fix the issue."
                                                    delegate:self
                                           cancelButtonTitle:nil
                                           otherButtonTitles:@"OK", nil]; 
            [[askForEMail autorelease] show];
        }        
    }
    else if (alertView == askForReview) {
        if (buttonIndex == 1) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setBool:YES forKey:@"userDidRate"];
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:rateLink]];
        }
        
    }
    else if (alertView == askForEMail) {
        if ([MFMailComposeViewController canSendMail]) {
            NSString *localeName = [[NSLocale preferredLanguages] objectAtIndex:0];
            NSString *deviceName = [UIDevice currentDevice].model;
            NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
            [mailController setToRecipients:[NSArray arrayWithObject:supportEmail]];
            [mailController setSubject:@"Viva Stampede v1.0/etc..."];
            [mailController setMessageBody:[NSString stringWithFormat:@"Please describe your problem in as much detail as possible. <br/><br/><br/>Locale: %@<br/>Device Model: %@<br/>App Version:%@", localeName, deviceName, appVersion] isHTML:true];
            mailController.mailComposeDelegate = self;
            [viewController presentModalViewController:mailController animated:true];   
        }        
    }
}

#pragma MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissModalViewControllerAnimated:YES];
}

@end
