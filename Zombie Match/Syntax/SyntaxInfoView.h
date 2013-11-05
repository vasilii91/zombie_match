//
//  SyntaxInfoView.h
//  Syntax
//
//  Created by Seby Moisei on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"
#import "ChartBoost.h"

@class InfoSlide1;
@class InfoSlide2;
@class InfoSlide3;
@class InfoSlide4;
@class InfoSlide5;
@class InfoSlide6;
@class InfoSlide7;
@class InfoSlide8;
@class InfoSlide9;
@class InfoSlide10;

@interface SyntaxInfoView : MSSView {
    SyntaxLabel *infoButton;
    SyntaxLabel *moreButton;
    UIImageView *infoBackground;
    UIImageView *moreBackground;
    UIImageView *header;
    UIButton *playButton;
    SyntaxLabel *moreTable;
    SyntaxLabel *previousSlideButton;
    SyntaxLabel *nextSlideButton;
    SyntaxLabel *backButton;
    InfoSlide1 *infoSlide1;
    InfoSlide2 *infoSlide2;
    InfoSlide3 *infoSlide3;
    InfoSlide4 *infoSlide4;
    InfoSlide5 *infoSlide5;
    InfoSlide6 *infoSlide6;
    InfoSlide7 *infoSlide7;
    InfoSlide8 *infoSlide8;
    InfoSlide9 *infoSlide9;
    InfoSlide10 *infoSlide10;    
    BOOL isMore;
    int currentSlide;
    BOOL shortened;
    BOOL canGoToPlay;
    SEL gameToGo;
}

@property SEL gameToGo;
@property BOOL shortened;
@property (nonatomic, retain) UIButton *playButton;

- (void)showSlideNumber:(int)thisSlideNumber;
- (void)showMore;

@end
