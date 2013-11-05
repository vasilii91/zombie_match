//
//  SyntaxLabel.m
//  Syntax
//
//  Created by Seby Moisei on 1/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxLabel.h"

@implementation SyntaxLabel

- (void)styleWithSize:(float)thisSize {
    size = thisSize;
    self.font = [UIFont fontWithName:@"Dimbo" size:thisSize];
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor colorWithRed:0.857 green:0.925 blue:0.917 alpha:1];
    self.textAlignment = UITextAlignmentCenter;
    self.layer.shadowColor = [[UIColor colorWithRed:0.007 green:0.847 blue:1 alpha:1] CGColor];
    self.layer.shouldRasterize = YES;
    self.userInteractionEnabled = YES;
    self.clipsToBounds = NO;
    canAnimate = YES;
}

- (void)shadowSizeRatio:(float)thisRatio {
    self.layer.shadowRadius = size / thisRatio;
}

- (void)animGlitchWithDelay:(float)thisDelay andDoRepeat:(BOOL)doRepeat {    
    if (canAnimate) {
        float x = self.center.x;
        float y = self.center.y;
        int shakeBounds = size / 11;
        [UIView animateWithDuration:0.0333
                              delay:thisDelay
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.alpha = 0;                        
                         }
                         completion:^(BOOL finished) {
                             self.center = CGPointMake(x + arc4random() % shakeBounds - (shakeBounds / 2), y + arc4random() % shakeBounds - (shakeBounds / 2));
                             [UIView animateWithDuration:0.0333
                                                   delay:0
                                                 options:UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  self.alpha = 1;                        
                                              }
                                              completion:^(BOOL finished) {
                                                  [UIView animateWithDuration:0.0333
                                                                        delay:0
                                                                      options:UIViewAnimationOptionAllowUserInteraction
                                                                   animations:^{
                                                                       self.alpha = 0;                        
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       self.center = CGPointMake(x, y);
                                                                       [UIView animateWithDuration:0.0333
                                                                                             delay:0
                                                                                           options:UIViewAnimationOptionAllowUserInteraction
                                                                                        animations:^{
                                                                                            self.alpha = 1;                        
                                                                                        }
                                                                                        completion:^(BOOL finished) {
                                                                                            if (canAnimate & doRepeat) [self animGlitchWithDelay:(arc4random()% 20) / 10 andDoRepeat:doRepeat];
                                                                                        }]; 
                                                                   }]; 
                                              }]; 
                         }];            
    }    
}

- (void)animGlitchWithAction:(void (^)(void))action {
    float x = self.center.x;
    float y = self.center.y;
    int shakeBounds = size / 11;
    
    if (canAnimate) {
        [UIView animateWithDuration:0.0333
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.alpha = 0;                        
                         }
                         completion:^(BOOL finished) {
                             self.center = CGPointMake(x + arc4random() % shakeBounds - (shakeBounds / 2), y + arc4random() % shakeBounds - (shakeBounds / 2));
                             [UIView animateWithDuration:0.0333
                                                   delay:0
                                                 options:UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  self.alpha = 1;                        
                                              }
                                              completion:^(BOOL finished) {
                                                  [UIView animateWithDuration:0.0333
                                                                        delay:0
                                                                      options:UIViewAnimationOptionAllowUserInteraction
                                                                   animations:^{
                                                                       self.alpha = 0;                        
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       self.center = CGPointMake(x + arc4random() % shakeBounds - (shakeBounds / 2), y + arc4random() % shakeBounds - (shakeBounds / 2));
                                                                       [UIView animateWithDuration:0.0333
                                                                                             delay:0
                                                                                           options:UIViewAnimationOptionAllowUserInteraction
                                                                                        animations:^{
                                                                                            self.alpha = 1;                        
                                                                                        }
                                                                                        completion:^(BOOL finished) {
                                                                                            [UIView animateWithDuration:0.0333
                                                                                                                  delay:0
                                                                                                                options:UIViewAnimationOptionAllowUserInteraction
                                                                                                             animations:^{
                                                                                                                 self.alpha = 0;                        
                                                                                                             }
                                                                                                             completion:^(BOOL finished) {
                                                                                                                 self.center = CGPointMake(x + arc4random() % shakeBounds - (shakeBounds / 2), y + arc4random() % shakeBounds - (shakeBounds / 2));
                                                                                                                 [UIView animateWithDuration:0.0333
                                                                                                                                       delay:0
                                                                                                                                     options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                                  animations:^{
                                                                                                                                      self.alpha = 1;                        
                                                                                                                                  }
                                                                                                                                  completion:^(BOOL finished) {
                                                                                                                                      [UIView animateWithDuration:0.0333
                                                                                                                                                            delay:0
                                                                                                                                                          options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                                                       animations:^{
                                                                                                                                                           self.alpha = 0;                        
                                                                                                                                                       }
                                                                                                                                                       completion:^(BOOL finished) {
                                                                                                                                                           self.center = CGPointMake(x, y);
                                                                                                                                                           [UIView animateWithDuration:0.0333
                                                                                                                                                                                 delay:0
                                                                                                                                                                               options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                                                                            animations:^{
                                                                                                                                                                                self.alpha = 1;                        
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
                         }];            
    }        
}



- (void)animUpdateWithText:(NSString *)thisString {
    [UIView animateWithDuration:0.
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                                               
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                                                      
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.
                                                                    delay:0
                                                                  options:UIViewAnimationOptionAllowUserInteraction
                                                               animations:^{
                                                                                          
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:0.
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionAllowUserInteraction
                                                                                    animations:^{
                                                                                                              
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        [UIView animateWithDuration:0.
                                                                                                              delay:0
                                                                                                            options:UIViewAnimationOptionAllowUserInteraction
                                                                                                         animations:^{
                                                                                                                                     
                                                                                                         }
                                                                                                         completion:^(BOOL finished) {
                                                                                                             [UIView animateWithDuration:0.
                                                                                                                                   delay:0
                                                                                                                                 options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                              animations:^{
                                                                                                                                                          
                                                                                                                              }
                                                                                                                              completion:^(BOOL finished) {
                                                                                                                                  [UIView animateWithDuration:0.
                                                                                                                                                        delay:0
                                                                                                                                                      options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                                                   animations:^{
                                                                                                                                                                              
                                                                                                                                                   }
                                                                                                                                                   completion:^(BOOL finished) {
                                                                                                                                                       self.text = thisString;
                                                                                                                                                       [UIView animateWithDuration:0.
                                                                                                                                                                             delay:0
                                                                                                                                                                           options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                                                                        animations:^{
                                                                                                                                                                                                   
                                                                                                                                                                        }
                                                                                                                                                                        completion:^(BOOL finished) {
                                                                                                                                                                            //
                                                                                                                                                                        }]; 
                                                                                                                                                   }];     

                                                                                                                              }]; 
                                                                                                         }];     
                                                                                    }]; 
                                                               }]; 
                                          }]; 
                     }];     
}

- (void)stopAnimatingLabel {
    canAnimate = NO;
}

- (void)dealloc {
    canAnimate = NO;
    [super dealloc];
}

@end
