//
//  SyntaxEngageView.h
//  Syntax
//
//  Created by Seby Moisei on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxEngineEngageServer.h"
#import "SyntaxEngineEngageClient.h"
#import "SyntaxLabel.h"

@interface SyntaxEngageView : MSSView {
    SyntaxEngineEngageServer *serverGameEngine;
    SyntaxEngineEngageClient *clientGameEngine;
    NSMutableSet *allLabels;
    SyntaxLabel *connectingLabel;
    SyntaxLabel *disconnectingLabel;
    SyntaxLabel *waitingLabel;
    SyntaxLabel *winLabel;
    SyntaxLabel *backToMainButton;
    SyntaxLabel *playAgainButton;
    SyntaxLabel *player1Label;
    SyntaxLabel *player2Label;
    SyntaxLabel *player1ScoreLabel;
    SyntaxLabel *player2ScoreLabel;
    SyntaxLabel *leaveMatchButton;
    UIImageView *progressBarBackground;
    UIView *progressBar;
    int timer;
    BOOL isPlaying;
}

@property (nonatomic, retain) SyntaxEngineEngageServer *serverGameEngine;
@property (nonatomic, retain) SyntaxEngineEngageClient *clientGameEngine;

- (void)startMatchWithPlayer1:(NSString *)player1 andPlayer2:(NSString *)player2;
- (void)matchOver;
- (void)endMatchWithWin:(BOOL)didWin;
- (void)restartMatch;
- (void)disconnectGame;
- (void)leaveEngage;

- (void)countdown;
- (void)updatePlayer1Score;
- (void)updatePlayer2Score;
- (void)showLabels;
- (void)hideEverything;


@end