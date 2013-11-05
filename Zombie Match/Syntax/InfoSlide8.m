//
//  InfoSlide8.m
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoSlide8.h"

@implementation InfoSlide8

@synthesize canRelease;

- (id)initSlide {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 384) andViewController:nil];
    if (self) {
        canRelease = NO;
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        title = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        title.text = @"Tokens";
        title.center = CGPointMake(160, 60);
        [title styleWithSize:30];
        [self addSubview:title];
        
        byte = [[self serveSubviewNamed:@"byteSymbol" withCenter:CGPointMake(160, 120) touchable:NO] retain];
        [self addSubview:byte];        
        
        byteText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        byteText.text = @"Collect Tokens and redeem them for Power Up’s! The more points you score, the more Tokens you collect.";
        byteText.center = CGPointMake(160, 180);
        [byteText styleWithSize:22];
        byteText.numberOfLines = 0;
        [self addSubview:byteText];
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
    [self removeSubView:byte];
    [self removeSubView:byteText];
    [super dealloc];
}

@end
