//
//  SyntaxGameView.m
//  Syntax
//
//  Created by Seby Moisei on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SyntaxInfinityView.h"
#import "SyntaxSymbol.h"
#import "SymbolManager.h"
#import "PlayHavenSDK.h"
#import "ByteManager.h"
#import "AppDelegate.h"

typedef enum {
    kPurchNil = 0,
    kPurchPlat,
    kPurchChamel,
    kPurchClue
} kPurchases;

@implementation SyntaxInfinityView

@synthesize gameEngine;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(givePrizeForPurchase) name:@"givePrizeForPurchase" object:nil];
        [viewController.statsManager clearGameStats];
        [viewController.symbolManager zeroProbabilities];
        viewController.statsManager.pointsToCompleteLevel = [viewController.valuesManager pointsNeededForLevel:viewController.statsManager.currentLevel andGameMode:viewController.statsManager.selectedGameMode];
        
        [viewController.musicController fadeToSongFromLevel:viewController.statsManager.currentLevel];
        
        self.gameEngine = [[SyntaxEngineInfinity alloc] initWithFrame:CGRectMake(0, 70, 320, 320) andViewController:viewController];
        [self addSubview:gameEngine];
        
        progressBarBackground = [[self serveSubviewNamed:@"progressBar" withCenter:CGPointMake(160, 27) touchable:NO] retain];
        //progressBarBackground.layer.shadowColor = [[UIColor colorWithRed:0.007 green:0.847 blue:1 alpha:1] CGColor];
        progressBarBackground.layer.shadowRadius = 10;
        progressBarBackground.layer.shadowOffset = CGSizeMake(0, 0);
        progressBarBackground.layer.shadowOpacity = 1;
        progressBarBackground.layer.shouldRasterize = YES;
        progressBarBackground.clipsToBounds = YES;
        progressBarBackground.alpha = 0;
        [self addSubview:progressBarBackground];
        
        
        // Endless Mode
        endlessMode = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 28)];
        endlessMode.text = @"ENDLESS MODE";
        endlessMode.center = CGPointMake(268, 10);
        [endlessMode styleWithSize:12];
        endlessMode.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:endlessMode];
        
        progressBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 17)];
        progressBar.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
        progressBar.center = CGPointMake(-250, 9.5);
        [progressBarBackground addSubview:progressBar];
        
        scoreLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 140, 18)];
        scoreLabel.text = [NSString stringWithFormat:@"SCORE: %d", viewController.statsManager.currentScore];
        scoreLabel.center = CGPointMake(90, 28);
        [scoreLabel styleWithSize:20];
        scoreLabel.textAlignment = UITextAlignmentLeft;
        scoreLabel.alpha = 0;
        [self addSubview:scoreLabel];
        
        levelLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 140, 18)];
        levelLabel.text = [NSString stringWithFormat:@"LEVEL: %d", viewController.statsManager.currentLevel];
        levelLabel.center = CGPointMake(230, 28);
        [levelLabel styleWithSize:20];
        levelLabel.textAlignment = UITextAlignmentRight;
        levelLabel.alpha = 0;
        [self addSubview:levelLabel];
        
        bytesCounter = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 28)];        
        bytesCounter.text = [NSString stringWithFormat:@"%d", viewController.byteManager.bytes];
        bytesCounter.center = CGPointMake(160, 50);
        [bytesCounter styleWithSize:25];
        bytesCounter.alpha = 0;
        [self addSubview:bytesCounter];
        
        byteImage = [[self serveSubviewNamed:@"byteSymbol" withCenter:CGPointMake(50, -14) touchable:NO] retain];
        [bytesCounter addSubview:byteImage];
        
        NSString *devPrefix = @"iphone_";
        int offsetForOldDev = 27;
        if(IS_IPHONE_5) {
            devPrefix = @"iphone5_";
            offsetForOldDev = 0;
        }
        
        // Menu Button
        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *iphonemenu = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", devPrefix, @"newmenu.png"]];
        [menuButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchDown];
        menuButton.frame = CGRectMake(0, 0, 70, 27);
        if(IS_IPHONE_5) menuButton.frame = CGRectMake(0, 0, 75, 34);
        menuButton.center = CGPointMake(50, 435 - offsetForOldDev);
        [menuButton setImage:iphonemenu forState:UIControlStateNormal];
        [self addSubview:menuButton];
        
        // Platypuses
        platyTrap = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *iphoneplattrap = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", devPrefix, @"newtraps.png"]];
        [platyTrap addTarget:self action:@selector(platypusTrap) forControlEvents:UIControlEventTouchDown];
        platyTrap.frame = CGRectMake(0, 0, 34, 34);
        if(IS_IPHONE_5) platyTrap.frame = CGRectMake(0, 0, 39, 39);
        platyTrap.center = CGPointMake(118, 435 - offsetForOldDev);
        [platyTrap setImage:iphoneplattrap forState:UIControlStateNormal];
        [self addSubview:platyTrap];
        
        rectifyButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        rectifyButton.text = [NSString stringWithFormat:@"x%d", viewController.byteManager.rectifiers];
        rectifyButton.center = CGPointMake(146, 440 - offsetForOldDev);
        [rectifyButton styleWithSize:18];
        rectifyButton.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        [self addSubview:rectifyButton];
        
        // Chameleons
        chameleons = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *iphonechameleons = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", devPrefix, @"newchameleon.png"]];
        [chameleons addTarget:self action:@selector(chameleons) forControlEvents:UIControlEventTouchDown];
        chameleons.frame = CGRectMake(0, 0, 36, 32);
        if(IS_IPHONE_5) chameleons.frame = CGRectMake(0, 0, 40, 37);
        chameleons.center = CGPointMake(180, 435 - offsetForOldDev);
        [chameleons setImage:iphonechameleons forState:UIControlStateNormal];
        [self addSubview:chameleons];
        
        wildcardButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        wildcardButton.text = [NSString stringWithFormat:@"x%d",viewController.byteManager.wildcards];
        wildcardButton.center = CGPointMake(206, 440 - offsetForOldDev);
        [wildcardButton styleWithSize:18];
        wildcardButton.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        [self addSubview:wildcardButton];
        
        // Clues Button
        clueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *iphone5power = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", devPrefix, @"newclues.png"]];
        [clueButton addTarget:self action:@selector(clues) forControlEvents:UIControlEventTouchUpInside];
        clueButton.frame = CGRectMake(0, 0, 33, 34);
        if(IS_IPHONE_5) clueButton.frame = CGRectMake(0, 0, 38, 38);
        clueButton.center = CGPointMake(240, 435 - offsetForOldDev);
        [clueButton setImage:iphone5power forState:UIControlStateNormal];
        [self addSubview:clueButton];
        [self bringSubviewToFront:clueButton];
        
        // Number of clues left
        promptButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        promptButton.text = [NSString stringWithFormat:@"x%d",viewController.byteManager.prompts];
        promptButton.center = CGPointMake(263, 440 - offsetForOldDev);
        [promptButton styleWithSize:18];
        promptButton.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        [self addSubview:promptButton];
        
        // Powerup (shop)
        powerUp = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *iphonepowerup = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", devPrefix, @"newcart.png"]];
        [powerUp addTarget:self action:@selector(powerUp) forControlEvents:UIControlEventTouchDown];
        powerUp.frame = CGRectMake(0, 0, 36, 29);
        if(IS_IPHONE_5) powerUp.frame = CGRectMake(0, 0, 40, 33);
        powerUp.center = CGPointMake(295, 435 - offsetForOldDev);
        [powerUp setImage:iphonepowerup forState:UIControlStateNormal];
        [self addSubview:powerUp];
        
        levelingLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];        
        levelingLabel.text = @"LEVEL COMPLETE";
        levelingLabel.center = CGPointMake(160, 240);
        [levelingLabel styleWithSize:40];
        levelingLabel.alpha = 0;
        levelingLabel.numberOfLines = 2;
        [self addSubview:levelingLabel];
        
        [self checkIfPowerUpsNeedToGlow];
        

        backButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        backButton.backgroundColor = [UIColor brownColor];
        backButton.text = @"X";
        backButton.center =  CGPointMake(290, 28);
        [backButton styleWithSize:30];
        backButton.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:30];
        backButton.alpha = 0;
        backButton.textColor = [UIColor colorWithRed:1 green:0.3 blue:0.3 alpha:1];
        [self addSubview:backButton];
        
        
        allPopUps = [[NSMutableSet alloc] init];
        
    }
    return self;
}

- (void)didMoveToSuperview {
    [self checkIfPowerUpsNeedToGlow];
    if (!isVisible) {
        isVisible = YES;
        [viewController.symbolManager updateProbabilities];
        [gameEngine glitch];
        [self performSelector:@selector(showButtons) withObject:nil afterDelay:1];
    }
    else isVisible = NO;
}

- (void)showButtons {
    [self fadeInView:scoreLabel withAction:^{}];
    [self fadeInView:levelLabel withAction:^{}];
    [self fadeInView:bytesCounter withAction:^{}];
    [self fadeInView:progressBarBackground withAction:^{}];
    [self fadeInView:powButton withAction:^{}];
    [self fadeInView:promptButton withAction:^{}];
    [self fadeInView:menuButton withAction:^{}];
    [self fadeInView:clueButton withAction:^{}];
    [self fadeInView:powerButton withAction:^{}];
    [self fadeInView:platyTrap withAction:^{}];
    [self fadeInView:chameleons withAction:^{}];
    [self fadeInView:powerUp withAction:^{}];
    [self fadeInView:endlessMode withAction:^{}];
    [self fadeInView:rectifyButton withAction:^{}];
    [self fadeInView:wildcardButton withAction:^{}];
}

- (void)hideButtons {
    [self fadeOutView:scoreLabel withAction:^{}];
    [self fadeOutView:levelLabel withAction:^{}];
    [self fadeOutView:bytesCounter withAction:^{}];
    [self fadeOutView:progressBarBackground withAction:^{}];
    [self fadeOutView:powButton withAction:^{}];
    [self fadeOutView:promptButton withAction:^{}];
    [self fadeOutView:menuButton withAction:^{}];
    [self fadeOutView:clueButton withAction:^{}];
    [self fadeOutView:powerButton withAction:^{}];
    [self fadeOutView:platyTrap withAction:^{}];
    [self fadeOutView:chameleons withAction:^{}];
    [self fadeOutView:powerUp withAction:^{}];
    [self fadeOutView:endlessMode withAction:^{}];
    [self fadeOutView:rectifyButton withAction:^{}];
    [self fadeOutView:wildcardButton withAction:^{}];
}

- (void)checkIfPowerUpsNeedToGlow {
    if(viewController.byteManager.rectifiers <= 0 && platyTrap.tag < 1) {
        platyTrap.tag = 1;
        [self animGlowSymbol:platyTrap];
    }
    if(viewController.byteManager.wildcards <= 0 && chameleons.tag < 1) {
        chameleons.tag = 1;
        [self animGlowSymbol:chameleons];
    }
    if(viewController.byteManager.prompts <= 0 && clueButton.tag < 1) {
        clueButton.tag = 1;
        [self animGlowSymbol:clueButton];
    }
}

- (void)animGlowSymbol:(UIButton *)thisSymbol {
    if(thisSymbol.tag > 0)
        [UIView animateWithDuration:0.7
                              delay:0
                            options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                         animations:^{
                             thisSymbol.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.7
                                                   delay:0
                                                 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                                              animations:^{
                                                  thisSymbol.alpha = 0.3;
                                              }
                                              completion:^(BOOL finished) {
                                                  [self animGlowSymbol:thisSymbol];
                                              }];
                         }];
    else thisSymbol.alpha = 1;
}
- (void)addPoints:(int)points {
    viewController.statsManager.currentLevelScore += points;
    viewController.statsManager.currentScore += points;
    [viewController.statsManager setHighScore];
    pointsForBytes += points;
    [self updateScore];
//    if (pointsForBytes >= viewController.valuesManager.kPointsForByte) {
        int bytesToAdd = (int) pointsForBytes / viewController.valuesManager.kPointsForByte;
        [viewController.byteManager addBytes:bytesToAdd * 2];
        pointsForBytes %= viewController.valuesManager.kPointsForByte;
        [self updateBytes];
//    }
}

- (void)updateScore {    
    [scoreLabel animUpdateWithText:[NSString stringWithFormat:@"SCORE: %d",viewController.statsManager.currentScore]];
    float k = (float) viewController.statsManager.currentLevelScore / viewController.statsManager.pointsToCompleteLevel;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         progressBar.center = CGPointMake(-250 + (320 * k), 9.5);
                     }
                     completion:^(BOOL finished) {                                                                                        
                         //
                     }];
}

- (void)updateBytes {
    [bytesCounter animUpdateWithText:[NSString stringWithFormat:@"%d", viewController.byteManager.bytes]];    
}

- (void)updatePacks {
    bytesCounter.text = [NSString stringWithFormat:@"%d", viewController.byteManager.bytes];
    promptButton.text = [NSString stringWithFormat:@"x%d",viewController.byteManager.prompts];
    rectifyButton.text = [NSString stringWithFormat:@"x%d",viewController.byteManager.rectifiers];
    wildcardButton.text = [NSString stringWithFormat:@"x%d",viewController.byteManager.wildcards];
}

- (void)showLevelComplete {
    [viewController.musicController fadeToSong:@"LevelUp" andReplay:NO];
    [gameEngine clearGame];
    [self clearInfoPopUps];
    viewController.statsManager.currentLevelScore -= viewController.statsManager.pointsToCompleteLevel;
    viewController.statsManager.currentLevel ++;
    viewController.statsManager.pointsToCompleteLevel = [viewController.valuesManager pointsNeededForLevel:viewController.statsManager.currentLevel andGameMode:viewController.statsManager.selectedGameMode];
    [viewController.symbolManager updateProbabilities];
    [levelLabel animGlitchWithAction:^{
        [self showNextLevel];
    }];
    
    float k = (float) viewController.statsManager.currentLevelScore / viewController.statsManager.pointsToCompleteLevel;
    [UIView animateWithDuration:4
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         progressBar.center = CGPointMake(-250 + (320 * k), 9.5);
                     }
                     completion:^(BOOL finished) {                                                                                        
                         //
                     }];
}

- (void)showNextLevel {
    [UIView animateWithDuration:0.0111
                          delay:1
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         levelingLabel.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         levelingLabel.text = [NSString stringWithFormat:@"LEVEL %d",viewController.statsManager.currentLevel];
                         levelLabel.text = [NSString stringWithFormat:@"level: %d",viewController.statsManager.currentLevel];
                         [UIView animateWithDuration:0.0333
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              levelingLabel.alpha = 1;
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.0333
                                                                    delay:0
                                                                  options:UIViewAnimationOptionAllowUserInteraction
                                                               animations:^{
                                                                   levelingLabel.alpha = 1;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:0.0333
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionAllowUserInteraction
                                                                                    animations:^{
                                                                                        levelingLabel.alpha = 1;                        
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        [self hideNextLevel];
                                                                                    }]; 
                                                               }]; 
                                          }]; 
                     }];
    
    // Play Haven Level Complete
    PHPublisherContentRequest *request = [PHPublisherContentRequest requestForApp:kPlayHavenID secret:kPlayHeavenSecret placement:@"level_complete" delegate:(id)self];
	request.showsOverlayImmediately = YES; //optional, see next.
	[request send];
}

-(void)request:(PHPublisherContentRequest *)request unlockedReward:(PHReward *)reward; {
        [viewController.byteManager addBytes:100];
        [self updateBytes];
}

- (void)hideNextLevel {
    [UIView animateWithDuration:0.0333
                          delay:4
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         levelingLabel.alpha = 0;                        
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.0333
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              levelingLabel.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.0333
                                                                    delay:0
                                                                  options:UIViewAnimationOptionAllowUserInteraction
                                                               animations:^{
                                                                   levelingLabel.alpha = 0;                        
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [viewController.musicController fadeToSongFromLevel:viewController.statsManager.currentLevel];
                                                                   [gameEngine populateGameFieldForNextLevel];
                                                                   [UIView animateWithDuration:0.0333
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionAllowUserInteraction
                                                                                    animations:^{
                                                                                        levelingLabel.alpha = 0;
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        [UIView animateWithDuration:0.0333
                                                                                                              delay:0
                                                                                                            options:UIViewAnimationOptionAllowUserInteraction
                                                                                                         animations:^{
                                                                                                             levelingLabel.alpha = 0;                        
                                                                                                         }
                                                                                                         completion:^(BOOL finished) {
                                                                                                             levelingLabel.text = @"LEVEL COMPLETE";
                                                                                                             [viewController cacheFullScreenAd];
                                                                                                         }]; 
                                                                                    }]; 
                                                               }]; 
                                          }]; 
                     }];     
}

- (void)checkForInfoPopUps {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *thisSymbol = [[gameEngine.gameGrid objectAtIndex:i] objectAtIndex:j];
            if ((thisSymbol.isOfType > 6) | (thisSymbol.isShifter)) {
                int k = -1;
                if (thisSymbol.isOfType == 7) k = 0;
                else if (thisSymbol.isShifter) k = 1;
                else if (thisSymbol.isOfType == 9) k = 2;
                else if (thisSymbol.isOfType == 10) k = 3;
                if ((k > -1) & (![viewController.statsManager didSeePopUpForSpecialType:k])) {
                    SyntaxInfoPopUp *popUp = [[SyntaxInfoPopUp alloc] initForSymbolWithIndex:thisSymbol.isIndex andSpecialType:k andSet:allPopUps];
                    [allPopUps addObject:popUp];
                    [self addSubview:popUp];
                    gameEngine.userInteractionEnabled = NO;                    
                }
            }
        }
    }
}

- (void)clearInfoPopUps {
    if ([allPopUps count] > 0) {
        for (SyntaxInfoPopUp *popUp in allPopUps) {
            [popUp removePopUp];
        }
        [allPopUps removeAllObjects];
    }    
}

- (void)powerUp {
    [self hideMenu];
    self.userInteractionEnabled = NO;
    [self fadeOutView:self withAction:^{
        [viewController showPowerUpViewInView:self];
    }];    
}

- (void)pause {
    self.userInteractionEnabled = NO;
    [self fadeOutView:self withAction:^{
        [viewController pauseGame];
    }];
}

- (void)resume {
	[self updatePacks];
	self.alpha=1;
	self.userInteractionEnabled=YES;
}

- (void)expandMenu {
    [Flurry logEvent:@"POW Expanded"];
    
    
}


- (void)hideMenu {
//    [self fadeOutView:backButton withAction:^{
//        [self fadeInView:levelLabel withAction:^{}];
//    }];
//    [self fadeOutView:rectifyButton withAction:^{
//        [self fadeInView:menuButton withAction:^{}];
//    }];
//    [self fadeOutView:wildcardButton withAction:^{
//        [self fadeInView:powButton withAction:^{}];
//    }];
//    [self fadeOutView:powerUpButton withAction:^{
//        [self fadeInView:promptButton withAction:^{}];
//    }];
}


- (void)hideUIbuttons{
//    [self removeSubView:iphone5PlatyTrap];
//    [self removeSubView:iphone5Chameleons];
//    [self removeSubView:iphone5PowerUp];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self checkIfPowerUpsNeedToGlow];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshStuckTimerInfinity" object:nil];
    UITouch *touch = [touches anyObject];
    if ([touch view] == promptButton) {
//        [self touchButton:promptButton withAction:^{
//            if ((viewController.statsManager.currentLevelScore >= 100) | (viewController.byteManager.prompts > 0)) {
//                [viewController.soundController playSound:@"PromptButton"];
//                
//                if ([gameEngine didFindHint]) {
//                    if (viewController.byteManager.prompts > 0) {
//                        [viewController.byteManager usePackItem:@"prompt" andUpdateLabel:promptButton];
//                        [Flurry logEvent:@"Penalty Free Prompt Used"];
//                    }
//                    else {
//                        if (viewController.statsManager.currentLevelScore >= 100) {
//                            viewController.statsManager.currentLevelScore -= 100;
//                            viewController.statsManager.currentScore -= 100;
//                            [self updateScore];                            
//                        }
//                        [Flurry logEvent:@"Prompt Used"];
//                    }
//                }
//                else {
//                    //no moves
//                    [viewController.soundController playSound:@"NoMatch"];
//                }                
//            }
//            else {
//                //no prompts
//                [viewController.soundController playSound:@"NoMatch"];
//                [self updateScore];
//            }
//        }];
    }
    if ([touch view] == menuButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:menuButton withAction:^{
            [self pause];            
        }];
    }
    if ([touch view] == powButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self expandMenu];
    }
    if ([touch view] == backButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self hideMenu];
    }
    if ([touch view] == rectifyButton) {
//        [self touchButton:rectifyButton withAction:^{
//            if ((gameEngine.firstTouchedSymbol.isOfType == 9) & (viewController.byteManager.rectifiers > 0)) {
//                [viewController.soundController playSound:@"Rectify"];
//                [gameEngine rectify];
//                [viewController.byteManager usePackItem:@"rectify" andUpdateLabel:rectifyButton];
//                [Flurry logEvent:@"Rectifier Used"];
//            }
//            else {
//                [viewController.soundController playSound:@"NoMatch"];
//            }
//        }];
    }
    if ([touch view] == wildcardButton) {
//        [self touchButton:wildcardButton withAction:^{
//            if ((gameEngine.firstTouchedSymbol != nil) & (gameEngine.firstTouchedSymbol.isOfType < 7) & (viewController.byteManager.wildcards > 0)) {
//                [viewController.soundController playSound:@"WildcardMorph"];
//                [gameEngine buyWildcard];
//                [viewController.byteManager usePackItem:@"wildcard" andUpdateLabel:wildcardButton
//                 ];
//                [Flurry logEvent:@"Turn To Wildcard"];
//               
//            }
//            else {
//                [viewController.soundController playSound:@"NoMatch"];
//            }
//        }];
    }
    if ([touch view] == powerUpButton) {
        [self touchButton:powerUpButton withAction:^{
            [self powerUp];
        }];
    }
    if ([allPopUps count] == 0) {
        gameEngine.userInteractionEnabled = YES;
    }
}

- (void)platypusTrap{
    if ((gameEngine.firstTouchedSymbol.isOfType == 9) & (viewController.byteManager.rectifiers > 0)) {
        [viewController.soundController playSound:@"Rectify"];
        [gameEngine rectify];
        [viewController.byteManager usePackItem:@"rectify" andUpdateLabel:rectifyButton];
        [Flurry logEvent:@"Rectifier Used"];
    }
    else {
        [viewController.soundController playSound:@"NoMatch"];
        if(viewController.byteManager.rectifiers <= 0)
            [self showPurchaseAlert:kPurchPlat];
    }
}

- (void)chameleons{
    if ((gameEngine.firstTouchedSymbol != nil) & (gameEngine.firstTouchedSymbol.isOfType < 7) & (viewController.byteManager.wildcards > 0)) {
        [viewController.soundController playSound:@"WildcardMorph"];
        [gameEngine buyWildcard];
        [viewController.byteManager usePackItem:@"wildcard" andUpdateLabel:wildcardButton
         ];
        [Flurry logEvent:@"Turn To Wildcard"];
        
    }
    else {
        [viewController.soundController playSound:@"NoMatch"];
        if(viewController.byteManager.wildcards <= 0)
            [self showPurchaseAlert:kPurchChamel];
    }
}

- (void)clues{
    if ((viewController.statsManager.currentLevelScore >= 100) | (viewController.byteManager.prompts > 0)) {
        [viewController.soundController playSound:@"PromptButton"];
        
        if ([gameEngine didFindHint]) {
            if (viewController.byteManager.prompts > 0) {
                [viewController.byteManager usePackItem:@"prompt" andUpdateLabel:promptButton];
                [Flurry logEvent:@"Penalty Free Prompt Used"];
            }
            else {
                if (viewController.statsManager.currentLevelScore >= 100) {
                    viewController.statsManager.currentLevelScore -= 100;
                    viewController.statsManager.currentScore -= 100;
                    [self updateScore];
                }
                [Flurry logEvent:@"Prompt Used"];
            }
        }
        else {
            //no moves
            [viewController.soundController playSound:@"NoMatch"];
        }
    }
    else {
        //no prompts
        [viewController.soundController playSound:@"NoMatch"];
        if(viewController.byteManager.prompts <= 0)
            [self showPurchaseAlert:kPurchClue];
        [self updateScore];
    }
}

- (void)showPurchaseAlert:(int)num {
    currentAlert = num;
    NSString *title = @"Get More";
    NSString *caption;
    if(num == kPurchPlat)
        caption = @"Would you like to buy 1000 tokens for $1.99 and get 5 Platypus Traps?";
    if(num == kPurchChamel)
        caption = @"Would you like to buy 500 tokens for $.99 and get 5 Chameleons?";
    if(num == kPurchClue)
        caption = @"Would you like to buy 500 tokens for $.99 and get 10 Hints?";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:caption
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Get!", nil];
    [[alertView autorelease] show];
    
}


- (void)givePrizeForPurchase {
    if(currentAlert == kPurchPlat) {
        viewController.byteManager.rectifiers += 5;
        [[NSUserDefaults standardUserDefaults] setInteger:viewController.byteManager.rectifiers forKey:@"rectifiers"];
        [CATransaction begin];
        for(CALayer *layer in platyTrap.layer.sublayers)
            [layer removeAllAnimations];
        [platyTrap.layer removeAllAnimations];
        [CATransaction commit];
        platyTrap.tag = 0;
    }
    if(currentAlert == kPurchChamel) {
        viewController.byteManager.wildcards += 5;
        [[NSUserDefaults standardUserDefaults] setInteger:viewController.byteManager.wildcards forKey:@"wildcards"];
        [CATransaction begin];
        for(CALayer *layer in chameleons.layer.sublayers)
            [layer removeAllAnimations];
        [chameleons.layer removeAllAnimations];
        [CATransaction commit];
        chameleons.tag = 0;
    }
    if(currentAlert == kPurchClue) {
        viewController.byteManager.prompts += 10;
        [[NSUserDefaults standardUserDefaults] setInteger:viewController.byteManager.prompts forKey:@"prompts"];
        [CATransaction begin];
        for(CALayer *layer in clueButton.layer.sublayers)
            [layer removeAllAnimations];
        [clueButton.layer removeAllAnimations];
        [CATransaction commit];
        clueButton.tag = 0;
    }
    [self updateBytes];
    [self updatePacks];
    currentAlert = -1;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if(currentAlert == kPurchPlat)
            [appDelegate purchase:IAP_1000_BYTES_PACK];
        if(currentAlert == kPurchChamel)
            [appDelegate purchase:IAP_500_BYTES_PACK];
        if(currentAlert == kPurchClue)
            [appDelegate purchase:IAP_500_BYTES_PACK];
    }
}

- (void)dealloc {
    NSLog(@"infinity view released");
    [gameEngine.layer removeAllAnimations];
    [self.layer removeAllAnimations];
    [self removeSubView:gameEngine];
    self.gameEngine = nil;
    [self removeSubView:scoreLabel];
    [self removeSubView:levelLabel];
    [self removeSubView:byteImage];
    [self removeSubView:bytesCounter];
    [self removeSubView:progressBar];
    [self removeSubView:progressBarBackground];
    [self removeSubView:menuButton];
    [self removeSubView:powButton];
    [self removeSubView:promptButton];
    [self removeSubView:levelingLabel];
    [self removeSubView:backButton];
    [self removeSubView:rectifyButton];
    [self removeSubView:wildcardButton];
    [self removeSubView:powerUpButton];
//    [self removeSubView:iphone5PlatyTrap];
//    [self removeSubView:iphone5Chameleons];
//    [self removeSubView:iphone5PowerUp];
//    [self removeSubView:iphone5MenuButton];
//    [self removeSubView:iphone5PowerButton];
//    [self removeSubView:iphon5ClueButton];
    [self removeSubView:endlessMode];
    [self clearInfoPopUps];
    [super dealloc];   
}

@end
