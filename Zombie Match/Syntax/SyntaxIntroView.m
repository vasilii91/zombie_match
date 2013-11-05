//
//  SyntaxIntroView.m
//  Syntax
//
//  Created by Seby Moisei on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxIntroView.h"
#import "ViewController.h"

@implementation SyntaxIntroView

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller{
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        if (IS_IPHONE_5) {
            background = [[self serveSubviewNamed:@"iphone5introBackground" withCenter:CGPointMake(160, 284) touchable:NO] retain];
        } else {
        background = [[self serveSubviewNamed:@"introBackground" withCenter:CGPointMake(160, 240) touchable:NO] retain];
        }
        [self addSubview:background];
        logo = [[self serveSubviewNamed:@"" withCenter:CGPointMake(160, 240) touchable:NO] retain];
        [self addSubview:logo];
        readyToGo = NO;
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [self glitch];
        [self performSelector:@selector(endTimer) withObject:nil afterDelay:2];
    }
    else isVisible = NO;
}

- (void)glitch {
    int rand = arc4random() % 5;
    float delay = (float) rand / 10;
    CGPoint pos = CGPointMake(160 + arc4random() % 4 - 2, 240 + arc4random() % 4 - 2);
    [UIView animateWithDuration:0.0333
                          delay:delay
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         logo.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         logo.center = pos;
                         [UIView animateWithDuration:0.0333
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              logo.alpha = 1;
                                          }
                                          completion:^(BOOL finished) {
                                              if (readyToGo) {
                                                  [viewController showMainView];
                                                  [self fadeOutView:self withAction:^{
                                                      [viewController removeView:self];
                                                      
                                                  }];                                                  
                                              }
                                              else [self glitch];
                                          }];
                     }];    
}

- (void)endTimer {
    readyToGo = YES;    
}

- (void)dealloc {
    [self removeSubView:background];
    [self removeSubView:logo];
    [super dealloc];
}

@end
