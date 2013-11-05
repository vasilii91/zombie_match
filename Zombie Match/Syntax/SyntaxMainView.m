//
//  SyntaxMainView.m
//  Syntax
//
//  Created by Seby Moisei on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SyntaxMainView.h"
#import "ViewController.h"
#import "GameCenterManager.h"
#import "PlayHavenSDK.h"

@implementation SyntaxMainView
@synthesize zookeeperImage;
@synthesize morebackgroundsButton;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
  
        isGoingToDissapear = NO;
        self.alpha = 0;
        if (IS_IPHONE_5) {
            matchLogo = [[self serveSubviewNamed:@"zookeeper_logo" withCenter:CGPointMake(160, 87) touchable:NO] retain];
            [self addSubview:matchLogo];
        } else {
            matchLogo = [[self serveSubviewNamed:@"zookeeper_logo" withCenter:CGPointMake(160, 80) touchable:NO] retain];
            [self addSubview:matchLogo];
        }
//Primary
        primaryButton = [UIButton buttonWithType:UIButtonTypeCustom];      
        UIImage *primary = [UIImage imageNamed:@"mainmenu1.png"];
        [primaryButton addTarget:self action:@selector(maintoLevels) forControlEvents:UIControlEventTouchDown];
        if (IS_IPHONE_5) {
            primaryButton.frame = CGRectMake(33, 155, 230, 57);
        } else {
                primaryButton.frame = CGRectMake(33, 137, 230, 57);
        }
        [primaryButton setImage:primary forState:UIControlStateNormal];
        [self addSubview:primaryButton];
    
        
// Action
        actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *action = [UIImage imageNamed:@"mainmenu2.png"];
        [actionButton addTarget:self action:@selector(maintoTime) forControlEvents:UIControlEventTouchDown];
        if (IS_IPHONE_5) {
            actionButton.frame = CGRectMake(35, 215, 212, 55);
        } else {
            actionButton.frame = CGRectMake(35, 192, 212, 55);
        }
        [actionButton setImage:action forState:UIControlStateNormal];
        [self addSubview:actionButton];
    
// Endless
        infinityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *infinity = [UIImage imageNamed:@"mainmenu3.png"];
        [infinityButton addTarget:self action:@selector(maintoEndless) forControlEvents:UIControlEventTouchDown];
        if (IS_IPHONE_5) {
            infinityButton.frame = CGRectMake(31, 270, 250, 55);
        } else {
            infinityButton.frame = CGRectMake(31, 244, 250, 55);
        }
        [infinityButton setImage:infinity forState:UIControlStateNormal];
        [self addSubview:infinityButton];
        
// Multiplayer
    //    engageButton = [UIButton buttonWithType:UIButtonTypeCustom];
      //  UIImage *engage = [UIImage imageNamed:@"mainmenu7.png"];
       // [engageButton addTarget:self action:@selector(maintoMultiplayer) forControlEvents:UIControlEventTouchDown];
       // if (IS_IPHONE_5) {
         //   engageButton.frame = CGRectMake(69, 296, 195, 90);
       // } else {
        //    engageButton.frame = CGRectMake(69, 266, 195, 90);
        //}
        //[engageButton setImage:engage forState:UIControlStateNormal];
        //[self addSubview:engageButton];
        
// Store
        powerUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *powerup = [UIImage imageNamed:@"mainmenu4.png"];
        [powerUpButton addTarget:self action:@selector(maintoStore) forControlEvents:UIControlEventTouchDown];
        if (IS_IPHONE_5) {
            powerUpButton.frame = CGRectMake(64, 318, 185, 75);
        } else {
            powerUpButton.frame = CGRectMake(64, 293, 185, 75);
        }
        [powerUpButton setImage:powerup forState:UIControlStateNormal];
        [self addSubview:powerUpButton];
        
// Get a Free App
        getFreeAppButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *freeapp = [UIImage imageNamed:@"mainmenu5.png"];
        [getFreeAppButton addTarget:self action:@selector(getFreeApp) forControlEvents:UIControlEventTouchDown];
        if (IS_IPHONE_5) {
            getFreeAppButton.frame = CGRectMake(13, 389, 300, 54);
        } else {
            getFreeAppButton.frame = CGRectMake(13, 360, 300, 54);
        }
        [getFreeAppButton setImage:freeapp forState:UIControlStateNormal];
        [self addSubview:getFreeAppButton];
               

// More
        moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *more = [UIImage imageNamed:@"mainmenu6.png"];
        [moreButton addTarget:self action:@selector(maintoMore) forControlEvents:UIControlEventTouchDown];
        if (IS_IPHONE_5) {
            moreButton.frame = CGRectMake(187, 453, 118, 46);
        } else {
            moreButton.frame = CGRectMake(187, 414, 118, 46);
        }
        [moreButton setImage:more forState:UIControlStateNormal];
        [self addSubview:moreButton];
		
//        RevMobFullscreen* ads = [[RevMobAds session] fullscreen];
//        ads.delegate = self;
//        [ads showAd];
//		PHNotificationView *notifView=[[[PHNotificationView alloc] initWithApp:kPlayHavenID
//																		secret:kPlayHeavenSecret
//																	 placement:@"more_games"] autorelease];
//		[moreButton addSubview:notifView];
//		notifView.center=CGPointMake(16, 16);
//		notifView.tag=playhavenNotificationViewTag;
//		[notifView refresh];
		
        howToButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *howTo = [UIImage imageNamed:@"newhowtoplay.png"];
        [howToButton addTarget:self action:@selector(howToPlay) forControlEvents:UIControlEventTouchDown];
        if (IS_IPHONE_5) {
            howToButton.frame = CGRectMake(30, 453, 118, 46);
        } else {
            howToButton.frame = CGRectMake(30, 414, 118, 46);
        }
        [howToButton setImage:howTo forState:UIControlStateNormal];
        [self addSubview:howToButton];
        
// Zookeeper Image
        if (IS_IPHONE_5) {
            zookeeperImage = [[self serveSubviewNamed:@"zookeep" withCenter:CGPointMake(47, 365) touchable:NO] retain];
        } else {
            zookeeperImage = [[self serveSubviewNamed:@"zookeep" withCenter:CGPointMake(47, 344) touchable:NO] retain];
        }
        [self addSubview:zookeeperImage];
        
// Choose Backgroun Button
        morebackgroundsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *morebackgroundsImage = [UIImage imageNamed:@"choose_background.png"];
        [morebackgroundsButton addTarget:self action:@selector(maintomoreBackgrounds) forControlEvents:UIControlEventTouchDown];
        if (IS_IPHONE_5) {
             morebackgroundsButton.frame = CGRectMake(220, 190, 97.0, 85.0);
        } else {
             morebackgroundsButton.frame = CGRectMake(220, 167, 97.0, 85.0);
        }
        [morebackgroundsButton setImage:morebackgroundsImage forState:UIControlStateNormal];
        [self addSubview:morebackgroundsButton];
    }
    return self;
}

- (void)revmobAdDidReceive {
    NSLog(@"[RevMob Sample App] Ad loaded.");
}

- (void)revmobAdDidFailWithError:(NSError *)error {
    NSLog(@"[RevMob Sample App] Ad failed: %@", error);
}

- (void)revmobAdDisplayed {
    NSLog(@"[RevMob Sample App] Ad displayed.");
}

- (void)revmobUserClosedTheAd
{
    PHNotificationView *notifView=[[[PHNotificationView alloc] initWithApp:kPlayHavenID
                                                                    secret:kPlayHeavenSecret
                                                                 placement:@"more_games"] autorelease];
    [moreButton addSubview:notifView];
    notifView.center=CGPointMake(16, 16);
    notifView.tag=playhavenNotificationViewTag;
    [notifView refresh];

}
-(void)maintoLevels{
    [self fadeOutView:self withAction:^{
        [viewController showPrimaryView];
    }];
}

-(void)maintoTime{
    [self fadeOutView:self withAction:^{
        [viewController showActionView];
    }];
}

-(void)maintoEndless{
    [self fadeOutView:self withAction:^{
        [viewController showInfinityView];
    }];
}

-(void)maintoMultiplayer{
    [self fadeOutView:self withAction:^{
        [viewController showEngageView];
    }];
}

-(void)maintomoreBackgrounds{
    [self fadeOutView:self withAction:^{
        [viewController showchooseBackgroundView];
    }];
}

-(void)maintoStore{
    [self fadeOutView:self withAction:^{
        [viewController showPowerUpViewInView:self];
    }];
}

- (void)getFreeApp{
    [viewController getFreeApp];
}

-(void)maintoMore{
    [self fadeOutView:self withAction:^{
        [viewController showMoreView];
    }];
}

- (void)howToPlay {
    [self fadeOutView:self withAction:^{
        [viewController showShortenedInfoView];
    }];
}


- (void)didMoveToSuperview {
    [viewController hideFlurryBanner];
    if (!isVisible) {
        isVisible = YES;
        [viewController.musicController fadeToSong:@"MainTitles(Syntax)" andReplay:YES];
        [self fadeInView:self withAction:^{
        }];        
    }
    else isVisible = NO;
}


- (void)dealloc {
    [self removeSubView:matchLogo];
    [self removeSubView:primaryButton];
    [self removeSubView:actionButton];
    [self removeSubView:infinityButton];
    [self removeSubView:engageButton];
    [self removeSubView:powerUpButton];
    [self removeSubView:getFreeAppButton];
    [self removeSubView:moreButton];
    [self removeSubView:zookeeperImage];
    [self removeSubView:morebackgroundsButton];
    [super dealloc];
}

@end
