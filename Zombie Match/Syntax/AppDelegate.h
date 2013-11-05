//
//  AppDelegate.h
//  Syntax
//
//  Created by Seby Moisei on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "FlurryAds.h"
#import "ChartBoost.h"
#import <RevMobAds/RevMobAds.h>
#import "StoreObserver.h"
#import "PlayHavenSDK.h"
#import "TapjoyConnect.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, StoreObserverProtocol, UIAlertViewDelegate, PHPublisherContentRequestDelegate,ChartboostDelegate> {
    StoreObserver           *observer;
	UIAlertView				*loadingView;
    Chartboost *cb;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (nonatomic, retain) StoreObserver *observer;

- (void)restorePurchases;
- (void)purchase:(NSString *)purchase_id;
- (void)addBytes:(int)bytes;

-(void)transactionDidFinish:(NSString*)transactionIdentifier;
-(void)transactionDidError:(NSError*)error;
-(void)cancelLoadingAlert;
- (void)requestProductData;
- (void)unlockBackgrounds;
- (void)sendResponse:(SKProductsResponse *)response;
- (void)removeBGBuyScreens;
- (void)hideFlurryBanner;
-(void)ShowChart;

@end    
