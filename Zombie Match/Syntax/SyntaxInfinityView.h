//
//  SyntaxInfinityView.h
//  Syntax
//
//  Created by Seby Moisei on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxEngineInfinity.h"
#import "SyntaxLabel.h"
#import "SyntaxInfoPopUp.h"
#import "Flurry.h"

@interface SyntaxInfinityView : MSSView {
    SyntaxEngineInfinity *gameEngine;
    SyntaxLabel *scoreLabel;
    SyntaxLabel *levelLabel;
    SyntaxLabel *bytesCounter;
    UIImageView *byteImage;
    UIImageView *progressBarBackground;
    UIView *progressBar;
//    SyntaxLabel *menuButton;
    UIImageView *powButton;
    SyntaxLabel *promptButton;
    SyntaxLabel *levelingLabel;
    
    SyntaxLabel *backButton;
    SyntaxLabel *rectifyButton;
    SyntaxLabel *wildcardButton;
    SyntaxLabel *powerUpButton;
    
    SyntaxLabel *endlessMode;
    
    NSMutableSet *allPopUps;
    
    int pointsForBytes;
    
    // Iphone 5 Buttons
    UIButton *clueButton;
    UIButton *menuButton;
    UIButton *powerButton;
    UIButton *platyTrap;
    UIButton *chameleons;
    UIButton *powerUp;
    int currentAlert;
}

@property (nonatomic, retain) SyntaxEngineInfinity *gameEngine;

- (void)showButtons;
- (void)hideButtons;
- (void)addPoints:(int)points;
- (void)updateScore;

- (void)updateBytes;
- (void)updatePacks;

- (void)showLevelComplete;
- (void)showNextLevel;
- (void)hideNextLevel;

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

- (void)checkIfPowerUpsNeedToGlow;

@end
