//
//  MSSView.h
//  Waypoint
//
//  Created by Seby Moisei on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class ViewController;

@interface MSSView : UIView {
    ViewController *viewController;
    BOOL isVisible;
    BOOL isButtonBeingTouched;    
}

@property (nonatomic, retain) ViewController *viewController;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller;
- (UIImage *)serveImageNamed:(NSString *)imageName;
- (UIImageView *)serveSubviewNamed:(NSString *)imageName withCenter:(CGPoint)center touchable:(BOOL)isTouchable;
- (void)removeSubView:(UIView *)thisView;

- (void)touchButton:(UIView *)button withAction:(void (^)(void))action;

/////syntax specific
- (void)styleThisLabel:(UILabel *)thisLabel atSize:(float)thisSize;
- (void)fadeInView:(UIView *)thisView withAction:(void (^)(void))action;
- (void)fadeOutView:(UIView *)thisView withAction:(void (^)(void))action;


@end
