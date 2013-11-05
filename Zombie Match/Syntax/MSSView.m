//
//  MSSView.m
//  Waypoint
//
//  Created by Seby Moisei on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MSSView.h"
#import "ViewController.h"

@implementation MSSView

@synthesize viewController;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewController = controller;
        isVisible = NO;
        isButtonBeingTouched = NO;
    }
    return self;
}

- (UIImage *)serveImageNamed:(NSString *)imageName {
    NSString *suffix;
    if ([[UIScreen mainScreen] scale] == 2.0) suffix = [[NSString alloc] initWithString:@"@2x"];
    else suffix = [[NSString alloc] initWithString:@""];
    UIImage *myImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[imageName stringByAppendingString:suffix] ofType:@"png"]];
    [suffix release];
    return [myImage autorelease];
}

- (UIImageView *)serveSubviewNamed:(NSString *)imageName withCenter:(CGPoint)center touchable:(BOOL)isTouchable {
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:[self serveImageNamed:imageName]];
    myImageView.center = center;
    myImageView.userInteractionEnabled = isTouchable;
    return [myImageView autorelease];
}

- (void)touchButton:(UIView *)button withAction:(void (^)(void))action {
    if (!isButtonBeingTouched) {
        isButtonBeingTouched = YES;       
        [UIView animateWithDuration:0.0333
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             button.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.0333
                                                   delay:0
                                                 options:UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  button.alpha = 1;                        
                                              }
                                              completion:^(BOOL finished) {
                                                  [UIView animateWithDuration:0.0333
                                                                        delay:0
                                                                      options:UIViewAnimationOptionAllowUserInteraction
                                                                   animations:^{
                                                                       button.alpha = 1;
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       [UIView animateWithDuration:0.0333
                                                                                             delay:0
                                                                                           options:UIViewAnimationOptionAllowUserInteraction
                                                                                        animations:^{
                                                                                            button.alpha = 1;                        
                                                                                        }
                                                                                        completion:^(BOOL finished) {
                                                                                            [UIView animateWithDuration:0.0333
                                                                                                                  delay:0
                                                                                                                options:UIViewAnimationOptionAllowUserInteraction
                                                                                                             animations:^{
                                                                                                                 button.alpha = 1;
                                                                                                             }
                                                                                                             completion:^(BOOL finished) {
                                                                                                                 [UIView animateWithDuration:0.0333
                                                                                                                                       delay:0
                                                                                                                                     options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                                  animations:^{
                                                                                                                                      button.alpha = 1;                        
                                                                                                                                  }
                                                                                                                                  completion:^(BOOL finished) {
                                                                                                                                      isButtonBeingTouched = NO;
                                                                                                                                      action();
                                                                                                                                  }];
                                                                                                             }];
                                                                                        }]; 
                                                                   }]; 
                                              }]; 
                         }];    
        }
}

- (void)removeSubView:(UIView *)thisView {
    if(thisView)
        if(thisView.superview) {
            [thisView removeFromSuperview];
//            [thisView release];
        }
}

- (void)styleThisLabel:(UILabel *)thisLabel atSize:(float)thisSize{
    thisLabel.font = [UIFont fontWithName:@"Dimbo" size:thisSize];
    thisLabel.backgroundColor = [UIColor clearColor];
    thisLabel.textColor = [UIColor colorWithRed:0.857 green:0.925 blue:0.917 alpha:1];
    thisLabel.textAlignment = UITextAlignmentCenter;
    thisLabel.layer.shadowColor = [[UIColor colorWithRed:0.007 green:0.847 blue:1 alpha:1] CGColor];
    thisLabel.layer.shadowRadius = thisSize / 4;
    thisLabel.layer.shadowOffset = CGSizeMake(0, 0);
    thisLabel.layer.shadowOpacity = 1;
    thisLabel.layer.shouldRasterize = YES;
    thisLabel.userInteractionEnabled = YES;
    thisLabel.clipsToBounds = NO;
}

- (void)fadeInView:(UIView *)thisView withAction:(void (^)(void))action {
    float x = thisView.center.x;
    float y = thisView.center.y;
    [UIView animateWithDuration:0.0333
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         thisView.alpha = 1;                        
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.0333
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              thisView.alpha = 1;
                                          }
                                          completion:^(BOOL finished) {
                                              thisView.center = CGPointMake(x + arc4random() % 2 - 1, y + arc4random() % 2 - 1);
                                              [UIView animateWithDuration:0.0333
                                                                    delay:0
                                                                  options:UIViewAnimationOptionCurveLinear
                                                               animations:^{
                                                                   thisView.alpha = 1;                        
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:0.0333
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionCurveLinear
                                                                                    animations:^{
                                                                                        thisView.alpha = 1;
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        thisView.center = CGPointMake(x + arc4random() % 2 - 1, y + arc4random() % 2 - 1);
                                                                                        [UIView animateWithDuration:0.0333
                                                                                                              delay:0
                                                                                                            options:UIViewAnimationOptionCurveLinear
                                                                                                         animations:^{
                                                                                                             thisView.alpha = 1;                        
                                                                                                         }
                                                                                                         completion:^(BOOL finished) {
                                                                                                             [UIView animateWithDuration:0.0333
                                                                                                                                   delay:0
                                                                                                                                 options:UIViewAnimationOptionCurveLinear
                                                                                                                              animations:^{
                                                                                                                                  thisView.alpha = 1;
                                                                                                                              }
                                                                                                                              completion:^(BOOL finished) {
                                                                                                                                  thisView.center = CGPointMake(x, y);
                                                                                                                                  [UIView animateWithDuration:0.0333
                                                                                                                                                        delay:0
                                                                                                                                                      options:UIViewAnimationOptionCurveLinear
                                                                                                                                                   animations:^{
                                                                                                                                                       thisView.alpha = 1;                        
                                                                                                                                                   }
                                                                                                                                                   completion:^(BOOL finished) {
                                                                                                                                                       action();
                                                                                                                                                   }]; 
                                                                                                                              }]; 
                                                                                                         }]; 
                                                                                    }]; 
                                                               }]; 
                                          }]; 
                     }];            
}


- (void)fadeOutView:(UIView *)thisView withAction:(void (^)(void))action {
    float x = thisView.center.x;
    float y = thisView.center.y;
    [UIView animateWithDuration:0.0333
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         thisView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         thisView.center = CGPointMake(x + arc4random() % 2 - 1, y + arc4random() % 2 - 1);
                         [UIView animateWithDuration:0.0333
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              thisView.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.0333
                                                                    delay:0
                                                                  options:UIViewAnimationOptionCurveLinear
                                                               animations:^{
                                                                   thisView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   thisView.center = CGPointMake(x + arc4random() % 2 - 1, y + arc4random() % 2 - 1);
                                                                   [UIView animateWithDuration:0.0333
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionCurveLinear
                                                                                    animations:^{
                                                                                        thisView.alpha = 0;
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        [UIView animateWithDuration:0.0333
                                                                                                              delay:0
                                                                                                            options:UIViewAnimationOptionCurveLinear
                                                                                                         animations:^{
                                                                                                             thisView.alpha = 0;
                                                                                                         }
                                                                                                         completion:^(BOOL finished) {
                                                                                                             thisView.center = CGPointMake(x + arc4random() % 2 - 1, y + arc4random() % 2 - 1);
                                                                                                             [UIView animateWithDuration:0.0333
                                                                                                                                   delay:0
                                                                                                                                 options:UIViewAnimationOptionCurveLinear
                                                                                                                              animations:^{
                                                                                                                                  thisView.alpha = 0;
                                                                                                                              }
                                                                                                                              completion:^(BOOL finished) {
                                                                                                                                  [UIView animateWithDuration:0.0333
                                                                                                                                                        delay:0
                                                                                                                                                      options:UIViewAnimationOptionCurveLinear
                                                                                                                                                   animations:^{
                                                                                                                                                       thisView.alpha = 0;
                                                                                                                                                   }
                                                                                                                                                   completion:^(BOOL finished) {
                                                                                                                                                       thisView.center = CGPointMake(x, y);
                                                                                                                                                       action();
                                                                                                                                                   }]; 

                                                                                                                              }]; 
                                                                                                         }]; 
                                                                                    }]; 
                                                               }]; 
                                          }]; 
                     }];
}

- (void)dealloc {
    [viewController release];
    [super dealloc];
}

@end
