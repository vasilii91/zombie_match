//
//  SyntaxEngageView.m
//  Syntax
//
//  Created by Seby Moisei on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SyntaxEngageView.h"
#import "GameCenterManager.h"

@implementation SyntaxEngageView

@synthesize serverGameEngine;
@synthesize clientGameEngine;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        [viewController.statsManager clearGameStats];
        
        
        clientGameEngine = [[SyntaxEngineEngageClient alloc] initWithFrame:CGRectMake(255, 90, 222, 222) andViewController:viewController];
        clientGameEngine.alpha = 0;
        [self addSubview:clientGameEngine];
        
        serverGameEngine = [[SyntaxEngineEngageServer alloc] initWithFrame:CGRectMake(3, 90, 222, 222) andViewController:viewController];
        serverGameEngine.alpha = 0;
        [self addSubview:serverGameEngine];
        
        allLabels = [[NSMutableSet alloc] init];
        
        connectingLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 400, 60)];
        connectingLabel.text = @"Connecting...";
        [connectingLabel styleWithSize:40];
        connectingLabel.center = CGPointMake(240, 160);
        connectingLabel.alpha = 0;
        [self addSubview:connectingLabel];
        [allLabels addObject:connectingLabel];
        
        disconnectingLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 400, 60)];
        disconnectingLabel.text = @"Disconnecting...";
        [disconnectingLabel styleWithSize:33];
        disconnectingLabel.center = CGPointMake(240, 160);
        disconnectingLabel.alpha = 0;
        [self addSubview:disconnectingLabel];
        [allLabels addObject:disconnectingLabel];
        
        waitingLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
        waitingLabel.text = @"Disconnecting...";
        [waitingLabel styleWithSize:36];
        waitingLabel.center = CGPointMake(240, 160);
        waitingLabel.alpha = 0;
        waitingLabel.numberOfLines = 3;
        [self addSubview:waitingLabel];
        [allLabels addObject:waitingLabel];
        
        winLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 400, 60)];
        [winLabel styleWithSize:40];
        winLabel.center = CGPointMake(240, 160);
        winLabel.alpha = 0;
        [self addSubview:winLabel];
        [allLabels addObject:winLabel];
        
        backToMainButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(5, 270, 220, 30)];
        backToMainButton.text = @"BACK TO MAIN";
        [backToMainButton styleWithSize:20];
        backToMainButton.textAlignment = UITextAlignmentLeft;
        backToMainButton.alpha = 0;
        [self addSubview:backToMainButton];
        [allLabels addObject:backToMainButton];
        
        playAgainButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(255, 270, 220, 30)];
        playAgainButton.text = @"PLAY AGAIN";
        [playAgainButton styleWithSize:20];
        playAgainButton.textAlignment = UITextAlignmentRight;
        playAgainButton.alpha = 0;
        [self addSubview:playAgainButton];
        [allLabels addObject:playAgainButton];
        
        player1Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(10, 20, 200, 30)];
        [player1Label styleWithSize:18];        
        player1Label.textAlignment = UITextAlignmentLeft;
        player1Label.alpha = 0;
        [self addSubview:player1Label];
        [allLabels addObject:player1Label];
        
        player2Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(270, 20, 200, 30)];
        [player2Label styleWithSize:18];
        [self styleThisLabel:player2Label atSize:18];
        player2Label.textAlignment = UITextAlignmentRight;
        player2Label.alpha = 0;
        [self addSubview:player2Label];
        [allLabels addObject:player2Label];
        
        player1ScoreLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(10, 40, 200, 30)];        
        player1ScoreLabel.text = [NSString stringWithFormat:@"%d",viewController.statsManager.player1Score];
        [player1ScoreLabel styleWithSize:18];
        player1ScoreLabel.textAlignment = UITextAlignmentLeft;
        player1ScoreLabel.alpha = 0;
        [self addSubview:player1ScoreLabel];
        [allLabels addObject:player1ScoreLabel];
        
        player2ScoreLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(270, 40, 200, 30)];        
        player2ScoreLabel.text = [NSString stringWithFormat:@"%d",viewController.statsManager.player2Score];
        [player2ScoreLabel styleWithSize:18];
        player2ScoreLabel.textAlignment = UITextAlignmentRight;
        player2ScoreLabel.alpha = 0;
        [self addSubview:player2ScoreLabel];
        [allLabels addObject:player2ScoreLabel];
        
        leaveMatchButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];        
        leaveMatchButton.text = @"Leave\nMatch";
        [leaveMatchButton styleWithSize:20];       
        leaveMatchButton.numberOfLines = 2;
        leaveMatchButton.center = CGPointMake(240, 40);
        leaveMatchButton.alpha = 0;
        [self addSubview:leaveMatchButton];
        
        progressBarBackground = [[UIImageView alloc] initWithImage:[self serveImageNamed:@"progressBar"]];
        progressBarBackground.frame = CGRectMake(0, 0, 222, 12);
        progressBarBackground.transform = CGAffineTransformMakeRotation(-M_PI_2);
        progressBarBackground.center = CGPointMake(240, 201);
        progressBarBackground.layer.shadowColor = [[UIColor colorWithRed:0.007 green:0.847 blue:1 alpha:1] CGColor];
        progressBarBackground.layer.shadowRadius = 10;
        progressBarBackground.layer.shadowOffset = CGSizeMake(0, 0);
        progressBarBackground.layer.shadowOpacity = 1;
        progressBarBackground.clipsToBounds = YES;
        progressBarBackground.alpha = 0;
        [self addSubview:progressBarBackground];
        
        progressBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 9)];
        progressBar.backgroundColor = [UIColor colorWithRed:0.857 green:0.925 blue:0.917 alpha:1];
        progressBar.center = CGPointMake(-250, 6);
        [progressBarBackground addSubview:progressBar];
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:connectingLabel withAction:^{
            [connectingLabel animGlitchWithDelay:0 andDoRepeat:YES];
            [viewController.gameCenterManager startMatch];
        }];        
    }
    else isVisible = NO;
}


///////////////////////////////

- (void)startMatchWithPlayer1:(NSString *)player1 andPlayer2:(NSString *)player2 {
    viewController.isPlayingEngage = YES;
    
    
    [viewController.musicController fadeToSong:@"MUSIC-02-InTheGame-Mono" andReplay:NO];
    [connectingLabel stopAnimatingLabel];
    [self fadeOutView:connectingLabel withAction:^{
        [self hideEverything];
        [viewController.statsManager clearGameStats];
        player1Label.text = player1;
        player2Label.text = player2;
        player1ScoreLabel.text = [NSString stringWithFormat:@"%d",viewController.statsManager.player1Score];
        player2ScoreLabel.text = [NSString stringWithFormat:@"%d",viewController.statsManager.player2Score];
        serverGameEngine.alpha = 1;
        clientGameEngine.alpha = 1;
        [serverGameEngine populateGameField];
        timer = 0;
        isPlaying = YES;
        [self countdown];
        [self performSelector:@selector(showLabels) withObject:nil afterDelay:0.5];
    }];
}

- (void)matchOver {
    isPlaying = NO;
    [serverGameEngine endGame];
    [self fadeOutView:progressBarBackground withAction:^{
        progressBar.center = CGPointMake(-250, 6);
        if (viewController.statsManager.player1Score >= viewController.statsManager.player2Score) [self endMatchWithWin:YES];
        else [self endMatchWithWin:NO];
    }];
}

- (void)endMatchWithWin:(BOOL)didWin {
    if (didWin) {
        winLabel.text = @"YOU WIN!!!";
        [viewController.musicController fadeToSong:@"LevelUp" andReplay:NO];
        
    }
    else {
        [viewController.musicController fadeToSong:@"GameOver" andReplay:NO];
        winLabel.text = @"YOU LOSE!!!";
    }
    [self fadeInView:winLabel withAction:^{}];
    [self fadeInView:backToMainButton withAction:^{}];
    [self fadeInView:playAgainButton withAction:^{}];
}

- (void)restartMatch {
    [self hideEverything];
    waitingLabel.text = [NSString stringWithFormat:@"Waiting\nfor\n%@", viewController.gameCenterManager.otherPlayer.alias];
    waitingLabel.alpha = 1;
    backToMainButton.alpha = 1;
    [viewController.gameCenterManager restartMatch];
}

- (void)disconnectGame {
    viewController.isPlayingEngage = NO;
    [connectingLabel stopAnimatingLabel];
    connectingLabel.alpha = 0;
    
    [viewController.gameCenterManager disconnect];
    [self hideEverything];
    [connectingLabel removeFromSuperview];
    disconnectingLabel.alpha = 1;
    [self performSelector:@selector(leaveEngage) withObject:nil afterDelay:1];    
}

- (void)leaveEngage {
    [self fadeOutView:self withAction:^{
        [viewController showMainView];
        [viewController removeView:self];
    }];
}

/////////////////////////

- (void)countdown {
    [UIView animateWithDuration:1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear)
                     animations:^{
                         progressBar.center = CGPointMake(-250 + (timer * 222 / 85), 6);                         
                     }
                     completion:^(BOOL finished) {
                         if (isVisible & isPlaying) {
                             if (timer < 85) {
                                 timer++;
                                 [self countdown];
                             }
                             else [self matchOver];               
                         }
                     }];
}

- (void)updatePlayer1Score {
    [player1ScoreLabel animUpdateWithText:[NSString stringWithFormat:@"%d",viewController.statsManager.player1Score]];
}

- (void)updatePlayer2Score {
    [player2ScoreLabel animUpdateWithText:[NSString stringWithFormat:@"%d",viewController.statsManager.player2Score]];
}

- (void)showLabels {
    [self fadeInView:progressBarBackground withAction:^{}];
    [self fadeInView:player1Label withAction:^{}];
    [self fadeInView:player1ScoreLabel withAction:^{}];
    [self fadeInView:player2Label withAction:^{}];
    [self fadeInView:player2ScoreLabel withAction:^{}];
    [self fadeInView:leaveMatchButton withAction:^{}];
}

- (void)hideEverything {
    serverGameEngine.alpha = 0;
    clientGameEngine.alpha = 0;
    progressBarBackground.alpha = 0;
    player1Label.alpha = 0;
    player2Label.alpha = 0;
    player1ScoreLabel.alpha = 0;
    player2ScoreLabel.alpha = 0;
    leaveMatchButton.alpha = 0;
    connectingLabel.alpha = 0;
    disconnectingLabel.alpha = 0;
    waitingLabel.alpha = 0;
    winLabel.alpha = 0;
    backToMainButton.alpha = 0;
    playAgainButton.alpha = 0;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];  
    if ([touch view] == backToMainButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:backToMainButton withAction:^{
            [self disconnectGame];
        }];
    }
    if ([touch view] == playAgainButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:playAgainButton withAction:^{
            [self restartMatch];
        }];
    }
    if ([touch view] == leaveMatchButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:leaveMatchButton withAction:^{
            [self disconnectGame];
        }];
    }
}

- (void)dealloc {
    [allLabels removeAllObjects];
    [allLabels release];
    [self removeSubView:serverGameEngine];
    [self removeSubView:clientGameEngine];
    [self removeSubView:connectingLabel];
    [self removeSubView:disconnectingLabel];
    [self removeSubView:waitingLabel];
    [self removeSubView:winLabel];
    [self removeSubView:backToMainButton];
    [self removeSubView:playAgainButton];
    [self removeSubView:player1Label];
    [self removeSubView:player2Label];
    [self removeSubView:player1ScoreLabel];
    [self removeSubView:player2ScoreLabel];
    [self removeSubView:leaveMatchButton];
    [self removeSubView:progressBar];
    [self removeSubView:progressBarBackground];
    [super dealloc];
}



@end