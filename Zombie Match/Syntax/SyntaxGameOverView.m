//
//  SyntaxGameOverView.m
//  Syntax
//
//  Created by Seby Moisei on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxGameOverView.h"
#import "ViewController.h"

@implementation SyntaxGameOverView

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller andReason:(NSString *)thisReason {
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
//        self.alpha = 0;
        
        int scrWidth = 320;
        int scrHeight = 480;
        NSString *devPrefix = @"iphone_";
        int iPhone4Offset = 22;
        if(IS_IPHONE_5) {
            devPrefix = @"iphone5_";
            scrHeight = 568;
            iPhone4Offset = 0;
        }
        
        NSString *backName;
        if([thisReason isEqualToString:@"Out of time"])
            backName = @"newgameover_notime.jpg";
        else backName = @"newgameover_nomatch.jpg";
        
        backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
        backgroundView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", devPrefix, backName]];
        [self addSubview:backgroundView];
        [backgroundView release];
        
//        gameOverLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];        
//        gameOverLabel.text = @"GAME OVER!";
//        gameOverLabel.center = CGPointMake(160, 70);
//        [gameOverLabel styleWithSize:45];
//        gameOverLabel.textColor = [UIColor colorWithRed:0.949 green:0.835 blue:0.533 alpha:1];
//        gameOverLabel.layer.shadowColor = [[UIColor colorWithRed:0.949 green:0.835 blue:0.533 alpha:1] CGColor];
//        [self addSubview:gameOverLabel];
        
//        gameOverReasonLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
//        gameOverReasonLabel.text = thisReason;
//        gameOverReasonLabel.center = CGPointMake(160, 105);
//        [gameOverReasonLabel styleWithSize:30];
//        [self addSubview:gameOverReasonLabel];
        
        scoreLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %d", viewController.statsManager.currentScore];
        scoreLabel.center = CGPointMake(160, 248 - iPhone4Offset);
        [scoreLabel styleWithSize:45];
        [self addSubview:scoreLabel];
        
        highScoreLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];        
        highScoreLabel.text = [NSString stringWithFormat:@"High Score: %d", [viewController.statsManager getHighScore]];
        highScoreLabel.center = CGPointMake(160, 282 - iPhone4Offset);
        [highScoreLabel styleWithSize:23];
        [self addSubview:highScoreLabel];
        
        bytesLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];        
        bytesLabel.text = [NSString stringWithFormat:@"TOKENS: %d", viewController.byteManager.bytes];
        bytesLabel.center = CGPointMake(160, 336 - iPhone4Offset);
        [bytesLabel styleWithSize:40];
        bytesLabel.numberOfLines = 2;
        bytesLabel.textColor = [UIColor colorWithRed:1 green:0.7 blue:0 alpha:1];
        bytesLabel.layer.shadowColor = [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] CGColor];
        [self addSubview:bytesLabel];
        
        getFreeAppButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 131, 45)];
        [getFreeAppButton addTarget:self action:@selector(getFreeGameHandler) forControlEvents:UIControlEventTouchUpInside];
        getFreeAppButton.center = CGPointMake(160, (IS_IPHONE_5)?450:430);
        [self addSubview:getFreeAppButton];
        
        powerUpStore = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        powerUpStore.center = CGPointMake(160, 352);
        [powerUpStore addTarget:self action:@selector(goToStoreHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:powerUpStore];
        [powerUpStore release];
        
        playAgainButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];        
//        playAgainButton.text = @"PLAY AGAIN";
        playAgainButton.center = CGPointMake(50, (IS_IPHONE_5)?450:430);
        [playAgainButton styleWithSize:25];
        [self addSubview:playAgainButton];
        
        mainMenuButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];        
//        mainMenuButton.text = @"MAIN MENU";
        mainMenuButton.center = CGPointMake(260, (IS_IPHONE_5)?450:430);
        [mainMenuButton styleWithSize:25];
        [self addSubview:mainMenuButton];
    }
    return self;
}

- (void)didMoveToSuperview {
    bytesLabel.text = [NSString stringWithFormat:@"TOKENS: %d", viewController.byteManager.bytes];
    if (!isVisible) {
        isVisible = YES;
        [viewController.musicController fadeToSong:@"GameOver" andReplay:NO];
        [self fadeInView:self withAction:^{
            
        }];
    }
    else isVisible = NO;    
}

- (void)goToStoreHandler {
    [viewController.soundController playSound:@"GeneralMenuButton"];
    [viewController showPowerUpViewInView:self];
}

- (void)getFreeGameHandler {
    [viewController.soundController playSound:@"GeneralMenuButton"];
    [viewController getFreeApp];
}

- (void)periodicGlitch {
    if (isVisible) {
        [mainMenuButton animGlitchWithDelay:0 andDoRepeat:NO];
        [playAgainButton animGlitchWithDelay:0 andDoRepeat:NO];
//        [getFreeAppButton animGlitchWithDelay:0.1 andDoRepeat:NO];
        [bytesLabel animGlitchWithDelay:0.2 andDoRepeat:NO];
        [highScoreLabel animGlitchWithDelay:0.3 andDoRepeat:NO];
        [scoreLabel animGlitchWithDelay:0.4 andDoRepeat:NO];
        [gameOverReasonLabel animGlitchWithDelay:0.5 andDoRepeat:NO];
        if (isVisible) [self performSelector:@selector(periodicGlitch) withObject:nil afterDelay:arc4random() % 5 + 5];
    }    
}

- (void)animGlitchView:(UIView *)thisView {
    float delay = arc4random() % 20 / 10;
    float x = thisView.center.x;
    float y = thisView.center.y;
    
    if (isVisible) {
        [UIView animateWithDuration:0.0333
                              delay:delay
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             thisView.alpha = 0.1;                        
                         }
                         completion:^(BOOL finished) {
                             thisView.center = CGPointMake(x + arc4random() % 2 - 1, y + arc4random() % 2 - 1);
                             [UIView animateWithDuration:0.0333
                                                   delay:0
                                                 options:UIViewAnimationOptionAllowUserInteraction
                                              animations:^{
                                                  thisView.alpha = 1;                        
                                              }
                                              completion:^(BOOL finished) {
                                                  [UIView animateWithDuration:0.0333
                                                                        delay:0
                                                                      options:UIViewAnimationOptionAllowUserInteraction
                                                                   animations:^{
                                                                       thisView.alpha = 0.1;                        
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       thisView.center = CGPointMake(x, y);
                                                                       [UIView animateWithDuration:0.0333
                                                                                             delay:0
                                                                                           options:UIViewAnimationOptionAllowUserInteraction
                                                                                        animations:^{
                                                                                            thisView.alpha = 1;                        
                                                                                        }
                                                                                        completion:^(BOOL finished) {
                                                                                            if (isVisible) [self animGlitchView:thisView];
                                                                                        }]; 
                                                                   }]; 
                                              }]; 
                         }];            
    }    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == bytesLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:bytesLabel withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController showPowerUpViewInView:self];                
            }];
        }];
    }
    if ([touch view] == getFreeAppButton) {
    }
    if ([touch view] == playAgainButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:playAgainButton withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController restartGame];                
            }];
        }];
    }
    if ([touch view] == mainMenuButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:mainMenuButton withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController backToMenuFromGameOver];                
            }];
        }];
    }
}


- (void)dealloc {
    [self removeSubView:gameOverLabel];
    [self removeSubView:gameOverReasonLabel];
    [self removeSubView:scoreLabel];
    [self removeSubView:highScoreLabel];
    [self removeSubView:bytesIcon];
    [self removeSubView:bytesLabel];
    [self removeSubView:powerUpSquare];
    [self removeSubView:getFreeAppButton];
    [self removeSubView:playAgainButton];
    [self removeSubView:mainMenuButton];
    [super dealloc];
}

@end
