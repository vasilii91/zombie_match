//
//  SyntaxActionView.h
//  Syntax
//
//  Created by Seby Moisei on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxEngineAction.h"
#import "SyntaxLabel.h"
#import "SyntaxInfoPopUp.h"
#import "Flurry.h"

@interface SyntaxActionView : MSSView <UIAlertViewDelegate> {
    SyntaxEngineAction *gameEngine;
    SyntaxLabel *scoreLabel;
    SyntaxLabel *levelLabel;
    SyntaxLabel *bytesCounter;
    UIImageView *byteImage;
    UIImageView *progressBarBackground;
    UIView *progressBar;
    UIImageView *timerBarBackground;
    UIView *timerBar;
//    SyntaxLabel *menuButton;
    UIImageView *powButton;
    SyntaxLabel *promptButton;
    SyntaxLabel *levelingLabel;
    
    SyntaxLabel *backButton;    
    SyntaxLabel *rectifyButton;
    SyntaxLabel *wildcardButton;
    SyntaxLabel *powerUpButton;
    
    SyntaxLabel *timedMode;
    
    NSMutableSet *allPopUps;
    
    BOOL isPlaying;
    BOOL isGameOver;
    float timer;
    int pointsForBytes;
    
    
    // Iphone 5 Buttons
    UIButton *clueButton;
    UIButton *menuButton;
    UIButton *powerButton;
    UIButton *platyTrap;
    UIButton *chameleons;
    UIButton *powerUp;
    
    UIImageView *propositionToShuffle;
    UIButton *reshuffleButton;
    UIButton *gameOverButton;
    int currentAlert;
}

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isGameOver;
@property (nonatomic, retain) SyntaxEngineAction *gameEngine;
@property float timer;

- (void)showButtons;
- (void)hideButtons;
- (void)countdown;
- (void)addPoints:(int)points;
- (void)updateScore;

- (void)updateBytes;
- (void)updatePacks;

- (void)showLevelComplete;
- (void)showNextLevel;
- (void)hideNextLevel;

- (void)gameOver;
- (void)restart;

- (void)checkForInfoPopUps;
- (void)clearInfoPopUps;

- (void)powerUp;
- (void)pause;
- (void)resume;

- (void)expandMenu;
- (void)hideMenu;

// Iphone 5 buttons
- (void)hideUIbuttons;
- (void)platypusTrap;
- (void)chameleons;
- (void)clues;

- (void)proposeReshuffle;
- (void)checkIfPowerUpsNeedToGlow;

@end
