//
//  AppDelegate.m
//  Syntax
//
//  Created by Seby Moisei on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "GameCenterManager.h"
#import "RateAndRewardController.h"
#import "LocalNotifications.h"
#import <StoreKit/StoreKit.h>
#import "ByteManager.h"
#import "SyntaxPrimaryView.h"
#import "SyntaxActionView.h"
#import "SyntaxInfinityView.h"
#import "PlayHavenSDK.h"
//#import "PushNotificationManager.h"
#import "TapjoyConnect.h"

// because of jokes array
@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize observer;

- (void)dealloc {
    [observer release];
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef USE_TESTFLIGHT
	//[TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
	//[TestFlight takeOff:TestFlight_ID];
#endif
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
  

    // Flurry Banner
    [FlurryAds initialize:_window.rootViewController];
    [[PHPublisherOpenRequest requestForApp:kPlayHavenID secret:kPlayHeavenSecret] send];
    [PHAPIRequest setOptOutStatus:YES];
    [RevMobAds startSessionWithAppID:RevMobID];
   // [[RevMobAds session] setTestingMode:RevMobAdsTestingModeWithAds];
    
    [Flurry startSession:Flurry_ID];
        
    //[Flurry event:@"SynMaFree App Started"];
    [Flurry logEvent:@"App Started"];
	
	[TapjoyConnect requestTapjoyConnect:TapJoy_ID secretKey:TapJoySecret];
//    cb = [Chartboost sharedChartboost];
//    cb.appId = ChartBoost_ID;
//    cb.delegate=self;
//    cb.appSignature = ChartBosst_Sign;
//    //[cb cacheMoreApps];
//    [cb startSession];
//    [cb showInterstitial];
    
    UILocalNotification *localNotif = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {       
        [_viewController.byteManager addBytes:500];
    }
    
    [_viewController showFullScreenAd];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(warnAboutLastMove) name:@"lastMove" object:nil];
    
	observer = [[StoreObserver alloc] init];
    observer.delegate = self;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
//    [observer requestProductData];
    
    return YES;
}

-(void)ShowChart
{
    
    //[cb showInterstitial];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [_viewController.gameCenterManager disconnect];
    
    [_viewController.rateAndRewardController countPlaythrough];
    
    [_viewController.rateAndRewardController refreshReward];
    
    [_viewController.localnotifications loadNotificationsJokes];
    [_viewController.localnotifications randomJoke];
    [_viewController.localnotifications scheduleNotifications];
 
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[PHPublisherOpenRequest requestForApp:kPlayHavenID secret:kPlayHeavenSecret] send];
    if(!loadingView) [_viewController showFullScreenAd];
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
        
    [_viewController.valuesManager initValuesFromServer];
    
    [_viewController.rateAndRewardController checkAndAskToRate];
    
    [_viewController.rateAndRewardController clearReward];
    
    if (_viewController.isInGame) {
        switch (_viewController.statsManager.selectedGameMode) {
            case 0:
                [_viewController.primaryView updateBytes];
                break;
            case 1:
                [_viewController.actionView updateBytes];
                break;
            case 2:
                [_viewController.infinityView updateBytes];
                break;            
            default:
                break;
        }
    }
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [_viewController.gameCenterManager disconnect];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    if (_viewController.isInGame) [_viewController.statsManager setTopTenScoresForGameMode:_viewController.statsManager.selectedGameMode];
}


#pragma mark - Local Notifications

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [_viewController.byteManager addBytes:500];
    if (_viewController.isInGame) {
        switch (_viewController.statsManager.selectedGameMode) {
            case 0:
                [_viewController.primaryView updateBytes];
                break;
            case 1:
                [_viewController.actionView updateBytes];
                break;
            case 2:
                [_viewController.infinityView updateBytes];
                break;            
            default:
                break;
        }
    }
}

//-(void)onPushAccepted:(PushNotificationManager*)pushManager withNotification:(NSDictionary*)pushNotification {
//    NSLog(@"Push notification received");
//}

#pragma mark -
#pragma mark In App Purchase

- (void)transactionDidError:(NSError*)error {
    [[NSNotificationCenter defaultCenter] postNotification:
     [NSNotification notificationWithName:@"enableTapToBuyBacks" object:nil]];
	[loadingView dismissWithClickedButtonIndex:0 animated:NO];
    
    if(error != nil) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}
 
- (void) transactionDidFinish:(NSString*)transactionIdentifier {
    [[NSNotificationCenter defaultCenter] postNotification:
     [NSNotification notificationWithName:@"enableTapToBuyBacks" object:nil]];
	[loadingView dismissWithClickedButtonIndex:0 animated:NO];
}

- (void) purchase:(NSString *)purchase_id {
	if (![SKPaymentQueue canMakePayments]) {
		UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
															message:@"inApp purchase Disabled"
														   delegate:self
												  cancelButtonTitle:@"Ok"
												  otherButtonTitles:nil];
		[alertView show];
		[alertView release];
		
		return;
	}
	
	SKPayment *payment = [SKPayment paymentWithProductIdentifier:purchase_id];
	[[SKPaymentQueue defaultQueue] addPayment:payment];
    
	loadingView = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:nil
                                   otherButtonTitles:nil];
	
	UIActivityIndicatorView *actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	actInd.frame = CGRectMake(128.0f, 45.0f, 25.0f, 25.0f);
	[loadingView addSubview:actInd];
	[actInd startAnimating];
	[actInd release];
    
	UILabel *l = [[UILabel alloc]init];
	l.frame = CGRectMake(100, -25, 210, 100);
	l.text = @"Please wait...";
	l.font = [UIFont fontWithName:@"Helvetica" size:16];
	l.textColor = [UIColor whiteColor];
	l.shadowColor = [UIColor blackColor];
	l.shadowOffset = CGSizeMake(1.0, 1.0);
	l.backgroundColor = [UIColor clearColor];
	[loadingView addSubview:l];
	[l release];
    
	[loadingView show];
    [loadingView release];
}

- (void) restorePurchases {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
    loadingView = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:nil
                                   otherButtonTitles:nil];
	
	UIActivityIndicatorView *actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	actInd.frame = CGRectMake(128.0f, 45.0f, 25.0f, 25.0f);
	[loadingView addSubview:actInd];
	[actInd startAnimating];
	[actInd release];
    
	UILabel *l = [[UILabel alloc]init];
	l.frame = CGRectMake(100, -25, 210, 100);
	l.text = @"Please wait...";
	l.font = [UIFont fontWithName:@"Helvetica" size:16];
	l.textColor = [UIColor whiteColor];
	l.shadowColor = [UIColor blackColor];
	l.shadowOffset = CGSizeMake(1.0, 1.0);
	l.backgroundColor = [UIColor clearColor];
	[loadingView addSubview:l];
	[l release];
    
	[loadingView show];
    [loadingView release];
}


- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"[ IN APP PURCHASE] request error: %@", [error localizedDescription]);
}

- (void)requestProductData
{
}

- (void) transactionDidError
{
    [[NSNotificationCenter defaultCenter] postNotification:
        [NSNotification notificationWithName:@"enableTapToBuyBacks" object:nil]];
	[loadingView dismissWithClickedButtonIndex:0 animated:NO];
    loadingView = nil;
}

- (void) cancelLoadingAlert
{
    [[NSNotificationCenter defaultCenter] postNotification:
        [NSNotification notificationWithName:@"enableTapToBuyBacks" object:nil]];
	[loadingView dismissWithClickedButtonIndex:0 animated:NO];
    loadingView = nil;
}

- (void)addBytes:(int)bytes {
    [_viewController.byteManager addBytes:bytes];
}

- (void)unlockBackgrounds {
    [_viewController showMainView];
//    [_viewController removeView:_viewController.lockedBackground];
//    [_viewController removeView:_viewController.backgroundOverlay];
}

- (void)sendResponse:(SKProductsResponse *)response {
    _viewController.byteManager.allIAP = response.products;
    _viewController.byteManager.request = nil;
    [_viewController.byteManager.IAPView showIAP];
}

- (void)removeBGBuyScreens {
    [_viewController removeLockedBackground];
}

- (void)hideFlurryBanner {
    [_viewController removeAdForever];
}

-(void)requestWillGetContent:(PHPublisherContentRequest *)request {

}

-(void)requestDidGetContent:(PHPublisherContentRequest *)request{

}

-(void)request:(PHPublisherContentRequest *)request contentWillDisplay:(PHContent *)content {
    
}

- (void)warnAboutLastMove {
    
}


@end
