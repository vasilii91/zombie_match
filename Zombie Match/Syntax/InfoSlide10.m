//
//  InfoSlide10.m
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoSlide10.h"

@implementation InfoSlide10

@synthesize canRelease;

- (id)initSlide {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 384) andViewController:nil];
    if (self) {
        canRelease = NO;
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        title = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        title.text = @"Zombie Match";
        title.center = CGPointMake(160, 60);
        [title styleWithSize:35];
        [self addSubview:title];
        
        slideText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        slideText.text = @"Thanks for downloading Zombie Matches and supporting our game studio. We hope you enjoy playing the game, and we also hope that you'll share it with your friends!\n\nWe’re always open to feedback, so if you have a suggestion on how we can improve our games or just want to say hi, visit us on Facebook: http://facebook.com/ilovebravebilly\n\nWe'd really appreciate it if you left a 5-star rating and gave the game a positive review on iTunes. Cheers!";
        slideText.center = CGPointMake(160, 180);
        [slideText styleWithSize:15];
        slideText.numberOfLines = 0;
        [self addSubview:slideText];
        
        creditsText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 290, 150)];
        creditsText.text = @"Zombie Matches was created by Brave Billy L.L.P";
        creditsText.center = CGPointMake(160, 300);
        [creditsText styleWithSize:15];
        creditsText.textColor = [UIColor colorWithRed:0.949 green:0.835 blue:0.533 alpha:1];;
        creditsText.layer.shadowColor = [[UIColor colorWithRed:0.949 green:0.835 blue:0.533 alpha:1] CGColor];
        [self addSubview:creditsText];
        
        }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:self withAction:^{
            [self checkRelease];
        }];
    }
    else isVisible = NO;
}

- (void)checkRelease {
    if (!canRelease) [self performSelector:@selector(checkRelease) withObject:nil afterDelay:1];
    else {
        [self removeFromSuperview];
        [self release];
    }
}

- (void)dealloc {
    NSLog(@"slide released");
    [self removeSubView:title];
    [self removeSubView:slideText];
    [self removeSubView:creditsText];
    [super dealloc];
}

@end