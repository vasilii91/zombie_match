//
//  ViewController.h
//  Syntax
//
//  Created by Seby Moisei on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "MSSView.h"
#import "StatsManager.h"
#import "ValuesManager.h"
#import "ByteManager.h"
#import "SoundController.h"
#import "MusicController.h"
#import "Flurry.h"
#import <RevMobAds/RevMobAds.h>
#import "Chartboost.h"
#import "FlurryAdDelegate.h"
#import "TapjoyConnect.h"


@class GameCenterManager;
@class RateAndRewardController;
@class SymbolManager;
@class SyntaxIntroView;
@class SyntaxBackgroundView;
@class SyntaxChooseBackgroundView;
@class SyntaxMainView;
@class SyntaxPrimaryView;
@class SyntaxActionView;
@class SyntaxInfinityView;
@class SyntaxEngageView;
@class SyntaxPowerUpView;
@class SyntaxIAPView;
@class SyntaxMoreView;
@class SyntaxInfoView;
@class SyntaxPauseView;
@class SyntaxGameOverView;
@class SyntaxTopScoresView;
@class LocalNotifications;
@class SyntaxBackgroundOverlay;
@class SyntaxLockedBackground;
@class RevMobBannerView;
@class RevMobAds;




@interface ViewController : UIViewController <RevMobAdsDelegate,ChartboostDelegate>

{
    StatsManager *statsManager;
    ValuesManager *valuesManager;
    ByteManager *byteManager;
    GameCenterManager *gameCenterManager;
    RateAndRewardController *rateAndRewardController;
    SoundController *soundController;
    MusicController *musicController;
    SymbolManager *symbolManager;
    float scrWidth;
    float scrHeight;
    SyntaxIntroView *introView;
    SyntaxBackgroundView *backgroundView;
    SyntaxLockedBackground *lockedBackground;
    SyntaxChooseBackgroundView *chooseBackgroundView;
    SyntaxMainView *mainView;
    SyntaxPrimaryView *primaryView;
    SyntaxActionView *actionView;
    SyntaxInfinityView *infinityView;
    SyntaxEngageView *engageView;
    SyntaxPowerUpView *powerUpView;
    SyntaxIAPView *IAPView;
    SyntaxMoreView *moreView;
    SyntaxInfoView *infoView;
    SyntaxPauseView *pauseView;
    SyntaxGameOverView *gameOverView;
    SyntaxTopScoresView *topScoresView;
    Chartboost *cb;
    LocalNotifications *localnotifications;
    SyntaxBackgroundOverlay *backgroundOverlay;
    RevMobBannerView *ad;
    UIButton *backgroundImage1;
    UIButton *backgroundImage2;
    UIButton *backgroundImage3;
    UIButton *backgroundImage4;
    UIButton *backgroundImage5;
    UIButton *backButton;
    UIButton *restoreButton;
    
    int selectedGameMode;
    BOOL isPlayingEngage;
    BOOL isInGame;
    
	UIAlertView				*loadingView;
    NSTimer *timer;

}
@property (nonatomic, retain) SyntaxPowerUpView *powerUpView;
@property (nonatomic, retain) StatsManager *statsManager;
@property (nonatomic, retain) ValuesManager *valuesManager;
@property (nonatomic, retain) ByteManager *byteManager;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property (nonatomic, retain) RateAndRewardController *rateAndRewardController;
@property (nonatomic, retain) SoundController *soundController;
@property (nonatomic, retain) MusicController *musicController;
@property (nonatomic, retain) SymbolManager *symbolManager;
@property (nonatomic, retain) SyntaxMainView *mainView;
@property (nonatomic, retain) SyntaxPrimaryView *primaryView;
@property (nonatomic, retain) SyntaxActionView *actionView;
@property (nonatomic, retain) SyntaxInfinityView *infinityView;
@property (nonatomic, retain) SyntaxEngageView *engageView;
@property (nonatomic, retain) SyntaxPauseView *pauseView;
@property (nonatomic, retain) SyntaxGameOverView *gameOverView;
@property (nonatomic, retain) LocalNotifications *localnotifications;
@property (nonatomic, retain) Chartboost *cb;
@property (nonatomic) BOOL isPlayingEngage;
@property (nonatomic) BOOL isInGame;
@property (nonatomic, strong) UIButton *removeBannerAdButton;
@property(retain, nonatomic) RevMobBannerView *ad;
@property(retain, nonatomic) SyntaxBackgroundOverlay *backgroundOverlay;
@property (retain, nonatomic) UIButton *backgroundImage1;
@property (retain, nonatomic) UIButton *backgroundImage2;
@property (retain, nonatomic) UIButton *backgroundImage3;
@property (retain, nonatomic) UIButton *backgroundImage4;
@property (retain, nonatomic) UIButton *backgroundImage5;
@property (retain, nonatomic) UIButton *backButton;
@property (retain, nonatomic) UIButton *restoreButton;
@property (nonatomic, retain)SyntaxBackgroundView *backgroundView;
@property (nonatomic, retain)SyntaxLockedBackground *lockedBackground;



- (void)showIntroView;
- (void)showMainView;
- (void)showPrimaryView;
- (void)showActionView;
- (void)showInfinityView;
- (void)showEngageView;
- (void)showPowerUpViewInView:(MSSView *)thisView;
- (void)showIAPViewInView:(MSSView *)thisView;
- (void)showMoreView;
- (void)showInfoView;
- (void)showShortenedInfoView;
- (void)showTopScores;

- (void)showchooseBackgroundView;
-(void)chooseBackgroundBackButton;


- (void)pauseGame;
- (void)resumeGame;
- (void)backToMenuFromPause;

- (void)gameOverWithReason:(NSString *)thisReason;
- (void)restartGame;
- (void)backToMenuFromGameOver;

- (void)removeMainView;
- (void)removeView:(UIView *)thisView;

- (void)showFullScreenAd;
- (void)cacheFullScreenAd;
- (void)getFreeApp;

- (void)removeBanner: (id)sender;

- (void)showFlurryBanner;
- (void)hideFlurryBanner;
- (void)showBannerExitButton;
- (void)bottomBanner;

- (void)showbackgroundOVerlay;
- (void)showLockedBackground;
- (void)removeLockedBackground;


-(void)changeBackground1;
-(void)changeBackground2;
-(void)changeBackground3;
-(void)changeBackground4;
-(void)changeBackground5;

- (void)removeAdForever;
- (void)moreAppsForFull;
-(void)logAllViews;


@end

#define playhavenNotificationViewTag 72798