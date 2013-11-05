//
//  SyntaxMainView.h
//  Syntax
//
//  Created by Seby Moisei on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"
#import <RevMobAds/RevMobAds.h>
@interface SyntaxMainView : MSSView<RevMobAdsDelegate> {
    UIImageView *matchLogo;
    UIButton *primaryButton;
    UIButton *actionButton;
    UIButton *infinityButton;
    UIButton *engageButton;
    UIButton *powerUpButton;
    UIButton *getFreeAppButton;
    UIButton *moreButton;
    UIButton *howToButton;
    BOOL isGoingToDissapear;
    UIImageView *zookeeperImage;
    UIButton *morebackgroundsButton;
}

@property (retain, nonatomic) UIImageView *zookeeperImage;
@property (retain, nonatomic) UIButton *morebackgroundsButton;

- (void)maintoLevels;
- (void)maintoTime;
- (void)maintoEndless;
- (void)maintoMultiplayer;
- (void)maintoStore;
- (void)getFreeApp;
- (void)maintomoreBackgrounds;
- (void)maintoMore;


@end