//
//  ViewController.m
//  Syntax
//
//  Created by Seby Moisei on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GameCenterManager.h"
#import "RateAndRewardController.h"
#import "SymbolManager.h"
#import "SyntaxIntroView.h"
#import "SyntaxBackgroundView.h"
#import "SyntaxMainView.h"
#import "SyntaxPrimaryView.h"
#import "SyntaxActionView.h"
#import "SyntaxInfinityView.h"
#import "SyntaxEngageView.h"
#import "SyntaxPowerUpView.h"
#import "SyntaxIAPView.h"
#import "SyntaxInfoView.h"
#import "SyntaxMoreView.h"
#import "SyntaxPauseView.h"
#import "SyntaxGameOverView.h"
#import "SyntaxTopScoresView.h"
#import "AppDelegate.h"
#import <RevMobAds/RevMobAds.h>
#import <UIKit/UIKit.h>
#import "LocalNotifications.h"
#import "SyntaxChooseBackgroundView.h"
#import "SyntaxBackgroundOverlay.h"
#import "SyntaxLockedBackground.h"


@implementation ViewController
@synthesize statsManager, powerUpView;
@synthesize valuesManager;
@synthesize byteManager;
@synthesize gameCenterManager;
@synthesize rateAndRewardController;
@synthesize soundController;
@synthesize musicController;
@synthesize symbolManager;
@synthesize mainView;
@synthesize primaryView;
@synthesize actionView;
@synthesize infinityView;
@synthesize engageView;
@synthesize pauseView;
@synthesize gameOverView;
@synthesize isPlayingEngage;
@synthesize cb;
@synthesize isInGame;
@synthesize removeBannerAdButton = _removeBannerAdButton;
@synthesize ad;
@synthesize localnotifications;
@synthesize backgroundOverlay;
@synthesize backgroundImage1;
@synthesize backgroundImage2;
@synthesize backgroundImage3;
@synthesize backgroundImage4;
@synthesize backgroundImage5;
@synthesize backButton, restoreButton;
@synthesize backgroundView;
@synthesize lockedBackground;

- (void)loadView {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backGroundIapCancelled) name:kMoreBackgroundIAPCancelled object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLockedBackground) name:kMoreBackgroundIAPBought object:nil];

    
    statsManager = [[StatsManager alloc] init];
    valuesManager = [[ValuesManager alloc] init];
    byteManager = [[ByteManager alloc] init];
    gameCenterManager = [[GameCenterManager alloc] initWithViewController:self];
    rateAndRewardController = [[RateAndRewardController alloc] initWithViewController:self];
    localnotifications = [[LocalNotifications alloc] initWithViewController:self];
    soundController = [[SoundController alloc] init];
    musicController = [[MusicController alloc] init];
    
 
    scrWidth = 320;
    // You might have to adjust this depending on the iphone 4 vs 5. Currently, at 430, Banners work but more button doesnt. At 568, more works but not ads.
    // Seems to work at 500. Lets not rock the boat.
    if (IS_IPHONE_5) {
        scrHeight = 568;
    } else {
        scrHeight = 480;
    }
    
    UIView *rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
    rootView.backgroundColor = [UIColor redColor];
    self.view = [rootView autorelease];
    
    symbolManager = [[SymbolManager alloc] initWithViewController:self];
        
    if (IS_IPHONE_5) {
        backgroundView = [[SyntaxBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 568)];
        backgroundView.image = [UIImage imageNamed:@"iphone5background5.jpg"];
        
    } else {
        backgroundView = [[SyntaxBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 480)];
        backgroundView.image = [UIImage imageNamed:@"iapbackground3.jpg"];
        }
    
    backgroundView.opaque = YES;
    [self.view addSubview:backgroundView];
    
    [self showIntroView];
    
    [symbolManager performSelector:@selector(preload) withObject:nil afterDelay:0.1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)backGroundIapCancelled {
    
// Get rid of all the views in the IAP Backgrounds
    
    [chooseBackgroundView removeFromSuperview];
    [lockedBackground removeFromSuperview];
    [backgroundOverlay removeFromSuperview];
    ////2nd add the mainview :)
    [self showMainView];
}

- (void)showIntroView {
    introView = [[SyntaxIntroView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self];
    [self.view addSubview:introView];
}

- (void)showMainView {
    mainView = [[SyntaxMainView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self];
    [self.view addSubview:mainView];
    moreView = nil;
    //UPON RETURN TO MAIN     
}

- (void)showchooseBackgroundView {
    if (IS_IPHONE_5) {
         chooseBackgroundView = [[SyntaxChooseBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 568)];
    } else {
        chooseBackgroundView = [[SyntaxChooseBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 480)];
    }
    [self.view addSubview:chooseBackgroundView];
//    isInGame = YES;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_ADD_BACKGROUNDS]) {
        [self showLockedBackground];
        [self showbackgroundOVerlay];
    }
}

- (void)showLockedBackground{
    if (IS_IPHONE_5) {
        lockedBackground = [[SyntaxLockedBackground alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 568)];
        lockedBackground.image = [UIImage imageNamed:@"iapbackgroundpreview.jpg"];
        
    }
    else {
        lockedBackground = [[SyntaxLockedBackground alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 480)];
        lockedBackground.image = [UIImage imageNamed:@"iapbackgroundpreview_4s.jpg"];
    }
    [self.view addSubview:lockedBackground];
}

- (void)removeLockedBackground {
//    [self showMainView];
    [mainView fadeOutView:mainView withAction:^{
        [self removeView:chooseBackgroundView];
        [self removeView:lockedBackground];
        [self showchooseBackgroundView];
    }];
}

#pragma backgrounds
//Back Button
- (void)chooseBackgroundBackButton {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_ADD_BACKGROUNDS]) {
        ////    for(UIView *view in self.view.subviews)
        //        [self removeView:view];
        if(chooseBackgroundView)
            [self removeView:chooseBackgroundView];
        if(backgroundOverlay) {
//            if([[[SKPaymentQueue defaultQueue] transactions] count] > 0)
//                for(SKPaymentTransaction *tr in [[SKPaymentQueue defaultQueue] transactions])
//                    [[SKPaymentQueue defaultQueue] finishTransaction:tr];
            [self removeView:backgroundOverlay];
        }
        if(lockedBackground)
            [self removeView:lockedBackground];
        [self showMainView];
    } else {
        if(chooseBackgroundView)
            [self removeView:chooseBackgroundView];
        [self showMainView];
    }
}

//Arabian Nights
- (void)changeBackground1{
    backgroundView = [[SyntaxBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
    backgroundView.opaque = YES;
    if (IS_IPHONE_5) {
        backgroundView.image = [UIImage imageNamed:@"iphone5background2.jpg"];
        
    } else {
         backgroundView.image = [UIImage imageNamed:@"iapbackground1.jpg"];
    }
    [self.view addSubview:backgroundView];
    [self showMainView];
    [self removeView:chooseBackgroundView];
}
// The outback
- (void)changeBackground2{
    backgroundView = [[SyntaxBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
    backgroundView.opaque = YES;
    if (IS_IPHONE_5) {
        backgroundView.image = [UIImage imageNamed:@"iphone5background3.jpg"];
        
    } else {
        backgroundView.image = [UIImage imageNamed:@"iapbackground2.jpg"];
    }

    [self.view addSubview:backgroundView];
    [self showMainView];
    [self removeView:chooseBackgroundView];
}

// The Grassy Knoll
- (void)changeBackground3{
    backgroundView = [[SyntaxBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
    backgroundView.opaque = YES;
    if (IS_IPHONE_5) {
        backgroundView.image = [UIImage imageNamed:@"iphone5background1.jpg"];
        
    } else {
        backgroundView.image = [UIImage imageNamed:@"background.jpg"];
    }
    [self.view addSubview:backgroundView];
    [self showMainView];
    [self removeView:chooseBackgroundView];
}

// The City
- (void)changeBackground4{
    backgroundView = [[SyntaxBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
    backgroundView.opaque = YES;
    if (IS_IPHONE_5) {
        backgroundView.image = [UIImage imageNamed:@"iphone5background5.jpg"];
        
    } else {
        backgroundView.image = [UIImage imageNamed:@"iapbackground3.jpg"];
    }
    [self.view addSubview:backgroundView];
    [self showMainView];
    [self removeView:chooseBackgroundView];
}

// Outer Space
- (void)changeBackground5{
    backgroundView = [[SyntaxBackgroundView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
    backgroundView.opaque = YES;
    if (IS_IPHONE_5) {
        backgroundView.image = [UIImage imageNamed:@"iphone5background4.jpg"];
        
    } else {
        backgroundView.image = [UIImage imageNamed:@"iapbackground4.jpg"];
    }
    [self.view addSubview:backgroundView];
    [self showMainView];
    [self removeView:chooseBackgroundView];
}

- (void)showbackgroundOVerlay {
//    isInGame = YES;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_ADD_BACKGROUNDS]) {
        if (IS_IPHONE_5) {
            CGRect frame = CGRectMake(0, 100, scrWidth, 400);
            backgroundOverlay = [[SyntaxBackgroundOverlay alloc]initWithFrame:frame];
            [self.view addSubview:backgroundOverlay];
            
        } else {
            CGRect frame = CGRectMake(0, 100, scrWidth, 350);
            backgroundOverlay = [[SyntaxBackgroundOverlay alloc]initWithFrame:frame];
            [self.view addSubview:backgroundOverlay];
        }
    }
}


- (void)showPrimaryView {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTimeLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstTimeLaunched"];
        [self showShortenedInfoView];
        infoView.gameToGo = @selector(showPrimaryView);
        return;
    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {
        [self bottomBanner];
    }
    [Flurry logEvent:@"Primary Mode Play"];
    
    statsManager.selectedGameMode = 0;
    primaryView = [[SyntaxPrimaryView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 500) andViewController:self];
    [self.view addSubview:primaryView];
    isInGame = YES;
}

- (void)showActionView {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTimeLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstTimeLaunched"];
        [self showShortenedInfoView];
        infoView.gameToGo = @selector(showActionView);
        return;
    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {
        [self bottomBanner];
    }
    [Flurry logEvent:@"Action Mode Play"];
    
    statsManager.selectedGameMode = 1;
    actionView = [[SyntaxActionView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 500) andViewController:self];
    [self.view addSubview:actionView];
    isInGame = YES;
}

- (void)showInfinityView {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTimeLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstTimeLaunched"];
        [self showShortenedInfoView];
        infoView.gameToGo = @selector(showInfinityView);
        return;
    }
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {
        [self bottomBanner];
    }
     [Flurry logEvent:@"Infinity Mode Play"];
    
    statsManager.selectedGameMode = 2;
    infinityView = [[SyntaxInfinityView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 500) andViewController:self];
    [self.view addSubview:infinityView];
    isInGame = YES;
}

- (void)showEngageView {
    [self hideFlurryBanner];
    [Flurry logEvent:@"Engage Mode"];
    
    statsManager.selectedGameMode = 3;
    engageView = [[SyntaxEngageView alloc] initWithFrame:CGRectMake(-80, 80, scrHeight, scrWidth) andViewController:self];
    [self.view addSubview:engageView];
}

- (void)showPowerUpViewInView:(MSSView *)thisView {
    [Flurry logEvent:@"PowerUp View"];
    
    self.powerUpView = [[SyntaxPowerUpView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self andMotherView:thisView];
    [self.view addSubview:powerUpView];
}


- (void)showIAPViewInView:(MSSView *)thisView {
    [Flurry logEvent:@"IAP View Visit"];
    
    IAPView = [[SyntaxIAPView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self andMotherView:thisView];
    [self.view addSubview:IAPView];
}

- (void)showMoreView {
    [Flurry logEvent:@"More View Visit"];
    
    moreView = [[SyntaxMoreView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self];
    [self.view addSubview:moreView];
}

- (void)showInfoView {    
    [Flurry logEvent:@"Info Page"];
    
    infoView = [[SyntaxInfoView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self];
    [self.view addSubview:infoView];
    [self removeView:moreView];
    moreView = nil;
}

- (void)showShortenedInfoView {
    [Flurry logEvent:@"Info Page"];
    
    infoView = [[SyntaxInfoView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self];
    [infoView setShortened:YES];
    [self.view addSubview:infoView];
    [infoView release];
}


- (void)showTopScores {
    topScoresView = [[SyntaxTopScoresView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self];
    [self.view addSubview:topScoresView];
    [self removeView:moreView];
    moreView = nil;
}

- (void)pauseGame {
    pauseView = [[SyntaxPauseView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self];
    [self.view addSubview:pauseView];
}

- (void)resumeGame {
    switch (statsManager.selectedGameMode) {
        case 0:
            [primaryView resume];
            break;
        case 1:
            [actionView resume];
            break;
        case 2:
            [infinityView resume];
            break;            
        default:
            break;
    }
    [self removeView:pauseView];    
}

- (void)backToMenuFromPause {
    isInGame = NO;
    [statsManager setTopTenScoresForGameMode:statsManager.selectedGameMode];
        
    switch (statsManager.selectedGameMode) {
        case 0:
            [primaryView.gameEngine.layer removeAllAnimations];
            [primaryView removeFromSuperview];
            self.primaryView = nil;
            break;
        case 1:
            [actionView.gameEngine.layer removeAllAnimations];
            [actionView removeFromSuperview];
            self.actionView = nil;
            break;
        case 2:
            [infinityView.gameEngine.layer removeAllAnimations];
            [infinityView removeFromSuperview];
            self.infinityView = nil;
            break;
        default:
            break;
    }
    [self removeView:pauseView];
    [self showMainView];
    [self hideFlurryBanner];
}

- (void)gameOverWithReason:(NSString *)thisReason {
    [statsManager setTopTenScoresForGameMode:statsManager.selectedGameMode];
    gameOverView = [[SyntaxGameOverView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight) andViewController:self andReason:thisReason];
    [self.view addSubview:gameOverView];    
}

- (void)restartGame {
    switch (statsManager.selectedGameMode) {
        case 0:
            [primaryView restart];
            [Flurry logEvent:@"Primary Mode Restart"];
            break;
        case 1:
            [actionView restart];
            [Flurry logEvent:@"Action Mode Restart"];
            break;
        case 2:
            //
            break;            
        default:
            break;
    }
    [self removeView:gameOverView];
}

- (void)backToMenuFromGameOver {
    isInGame = NO;
    switch (statsManager.selectedGameMode) {
        case 0:
            [self removeView:primaryView];
            break;
        case 1:
            [self removeView:actionView];
            break;
        case 2:
            [self removeView:infinityView];
            break;            
        default:
            break;
    }
    [self removeView:gameOverView];
    [self showMainView];
    // Show interstitial on return to Main Menu
    [self hideFlurryBanner];
}

- (void)removeView:(UIView *)thisView {
    if(thisView)
        if(thisView.superview) {
            [thisView removeFromSuperview];
            [thisView release];
        }
}

- (void)removeMainView {
    [mainView removeFromSuperview];
    [mainView release];
}

-(void)logAllViews {
	NSMutableString *logStr=[NSMutableString string];
	[self logView:self.view withTabs:@"" toString:logStr];
	NSLog(@"Printing view hierarchy:\\r%@",logStr);
}

-(void)logView:(UIView*)view withTabs:(NSString*)tabs toString:(NSMutableString*)logStr {
	[logStr appendFormat:@"%@%@\\r",tabs,view];
	NSString *childTabs=[tabs stringByAppendingString:@"\\t"];
	for (UIView *child in view.subviews)
		[self logView:child withTabs:childTabs toString:logStr];
}

#pragma mark - Ad Delegate Methods

- (void)showFullScreenAd {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {
       RevMobFullscreen* ads = [[RevMobAds session] fullscreen];
        ads.delegate = self;
        [ads showAd];
    }
    
}
- (void)revmobAdDidReceive {
    NSLog(@"[RevMob Sample App] Ad loaded.");
}

- (void)revmobAdDidFailWithError:(NSError *)error {
    NSLog(@"[RevMob Sample App] Ad failed: %@", error);
}

- (void)revmobAdDisplayed {
    NSLog(@"[RevMob Sample App] Ad displayed.");
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    PHPublisherContentRequest *request = [PHPublisherContentRequest requestForApp:kPlayHavenID secret:kPlayHeavenSecret
                                                                        placement:@"main_menu" delegate:delegate];
    request.showsOverlayImmediately = YES; //optional, see next.
    [request send];
    
}

- (void)revmobUserClosedTheAd
{
    NSLog(@"[RevMob Sample App] User clicked in the close button.");
    
    if ([timer isValid]) {
        [timer invalidate];
        timer=nil;
    }
    timer=[NSTimer scheduledTimerWithTimeInterval:100 target:self selector:@selector(ShowAdd) userInfo:nil repeats:YES];
    cb = [Chartboost sharedChartboost];
    cb.appId = ChartBoost_ID;
    cb.delegate=self;
    cb.appSignature = ChartBosst_Sign;
    //[cb cacheMoreApps];
    [cb startSession];
    [cb showInterstitial];
    
}

-(void)ShowAdd
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {
    RevMobFullscreen* ads = [[RevMobAds session] fullscreen];
    ads.delegate = self;
    [ads showAd];
     [cb showInterstitial];   
    }
    else{
        if ([timer isValid]) {
            [timer invalidate];
            timer=nil;
        }
    }
}
// Called when an interstitial has been received, before it is presented on screen
// Return NO if showing an interstitial is currently inappropriate, for example if the user has entered the main game mode
- (BOOL)shouldDisplayInterstitial:(NSString *)location {
    if ((isInGame = YES)) {
        return NO;
    } else {
        return YES;
    }
}

// If Chartboost fails to load Interstitial, use Revmob instead.
- (void)didFailToLoadInterstitial{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {
       // [[RevMobAds session] showFullscreen];
    }
}

- (void)cacheFullScreenAd {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {

    //[[Chartboost sharedChartboost] cacheInterstitial];
//    [RevMobAds loadFullscreenAd];
    }
}

- (void)getFreeApp {
    [Flurry logEvent:@"Get Free App"];
    [cb showMoreApps];
    [[RevMobAds session] showPopup];
}

- (void)moreAppsForFull {
    [Flurry logEvent:@"More Apps"];
//	[[Chartboost sharedChartboost] showMoreApps]; //old way
	PHPublisherContentRequest *request = [PHPublisherContentRequest requestForApp:kPlayHavenID
																		   secret:kPlayHeavenSecret
																		placement:@"more_games"
																		 delegate:(id)self];
	request.showsOverlayImmediately = YES; //optional, see next.
	[request send];
}

-(void)request:(PHPublisherContentRequest*)request contentDidDismissWithType:(NSString *)type {
	//refreshing all the PlayHaven notification views here
	NSMutableArray *processedViews=[NSMutableArray arrayWithCapacity:3];
	PHNotificationView *notifView=(id)[self.view viewWithTag:playhavenNotificationViewTag];
	//while there is some notification view, refresh it and drop its tag
	while (notifView) {
		if ([notifView isKindOfClass:[PHNotificationView class]])
			[notifView refresh];
		notifView.tag=0;
		[processedViews addObject:notifView];
		notifView=(id)[self.view viewWithTag:playhavenNotificationViewTag];
	}
	//raise all the dropped tags
	for (UIView *processedView in processedViews)
		processedView.tag=playhavenNotificationViewTag;
	[processedViews removeAllObjects];
}

- (void)removeBanner:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate purchase:IAP_FULL_VERSION];
}

- (void)showBannerExitButton{
    // create REMOVE BANNER Ad button
    self.removeBannerAdButton = [UIButton buttonWithType: UIButtonTypeCustom];
    UIImage *closeImage = [UIImage imageNamed: @"RedXButton.png"];
    self.removeBannerAdButton.frame = CGRectMake(0, 0, 30, 30); //CGRectMake(0, 0, closeImage.size.width, closeImage.size.height);
    [self.removeBannerAdButton setImage: closeImage forState: UIControlStateNormal];
    [self.removeBannerAdButton addTarget: self action: @selector(removeBanner:) forControlEvents: UIControlEventTouchUpInside];
    
    if ( nil == self.removeBannerAdButton.superview ) {
        if (IS_IPHONE_5) {
            self.removeBannerAdButton.center = CGPointMake(290, 500);
            
        } else {
            self.removeBannerAdButton.center = CGPointMake(290, 455);
            
        }
        [self.view addSubview: self.removeBannerAdButton];
    }
}

#define flurrySpaceName @"Zombie Match"
- (void)showFlurryBanner{
    [FlurryAds fetchAndDisplayAdForSpace:flurrySpaceName view:self.view size:BANNER_BOTTOM];
    [FlurryAds setAdDelegate:self];
}

- (void)removeAdForever {
    [self hideFlurryBanner];
    if(moreView) {
        [moreView removeAdButton];
    }
}

- (void)hideFlurryBanner {
    [FlurryAds removeAdFromSpace:flurrySpaceName];
    [FlurryAds setAdDelegate:nil];
    [self.removeBannerAdButton removeFromSuperview];
}


- (void)bottomBanner {
    [self showBannerExitButton];
    [self showFlurryBanner];
}

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMoreBackgroundIAPCancelled object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMoreBackgroundIAPBought object:nil];

    //Shut down revmob backup
    [self.ad removeFromSuperview];
    ad = nil;
    [super dealloc];
    [self.removeBannerAdButton removeFromSuperview];
    [backgroundImage1 release];
    [backgroundImage2 release];
    [backgroundImage3 release];
    [backgroundImage4 release];
    [backgroundImage5 release];
}


@end
