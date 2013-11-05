//
//  InfoSlide5.m
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoSlide5.h"

@implementation InfoSlide5

@synthesize canRelease;

- (id)initSlide {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 384) andViewController:nil];
    if (self) {
        canRelease = NO;
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        title = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        title.text = @"Game Modes";
        title.center = CGPointMake(160, 60);
        [title styleWithSize:25];
        [self addSubview:title];
                
        primaryText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 310, 70)];
        primaryText.text = @"Levels: Switch any 2 zombies to create a match of 3. If the switch does not create a match, the zombies will go back to their original positions. The number of moves you have is limited, so choose wisely!";
        primaryText.center = CGPointMake(160, 120);
        [primaryText styleWithSize:14];
        primaryText.textAlignment = UITextAlignmentCenter;
        primaryText.textColor = [UIColor colorWithRed:0.7 green:0.9 blue:0.0 alpha:1];
        primaryText.numberOfLines = 6;
        [self addSubview:primaryText];
        
        actionText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 310, 70)];
        actionText.text = @"Timed: You only have 90 seconds to complete each level! As with 'Levels', switch any 2 zombies to create a match of 3. If the switch does not create a match, the zombies will go back to their original positions.";
        actionText.center = CGPointMake(160, 210);
        [actionText styleWithSize:14];
        actionText.textAlignment = UITextAlignmentCenter;
        actionText.textColor = [UIColor colorWithRed:0.0 green:0.7 blue:1.0 alpha:1];
        actionText.numberOfLines = 6;
        [self addSubview:actionText];
        
        infinityText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 310, 70)];
        infinityText.text = @"Endless: In this mode, there is no timer, and you have unlimited moves. Switch any 2 zombies to create a match of 3. You can switch non-matching zombies, but do so at your own risk!";
        infinityText.center = CGPointMake(160, 300);
        [infinityText styleWithSize:14];
        infinityText.textAlignment = UITextAlignmentCenter;
        infinityText.textColor = [UIColor colorWithRed:1.0 green:0.85 blue:0.0 alpha:1];
        infinityText.numberOfLines = 6;
        [self addSubview:infinityText];
        
//        engageText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
//        engageText.text = @"Multiplayer: Thanks to Apple's Game Center, you can compete head-to-head with your friends on a 6x6 screen. The player with the highest score at the end of each 90-second round wins.";
//        engageText.center = CGPointMake(160, 315);
//        [engageText styleWithSize:13];
//        engageText.textAlignment = UITextAlignmentCenter;
//        engageText.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1];
//        engageText.numberOfLines = 6;
//        [self addSubview:engageText];

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
    [self removeSubView:primaryTitle];
    [self removeSubView:actionTitle];
    [self removeSubView:infinityTitle];
    [self removeSubView:engageTitle];
    [self removeSubView:primaryText];
    [self removeSubView:actionText];
    [self removeSubView:infinityText];
//    [self removeSubView:engageText];
    [super dealloc];
}

@end

