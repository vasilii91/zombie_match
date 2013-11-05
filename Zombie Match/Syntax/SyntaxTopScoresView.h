//
//  SyntaxTopScoresView.h
//  Syntax
//
//  Created by Seby Moisei on 10/6/12.
//
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface SyntaxTopScoresView : MSSView {
    SyntaxLabel *titleLabel;
    SyntaxLabel *primaryLabel;
    SyntaxLabel *actionLabel;
    SyntaxLabel *infinityLabel;
    SyntaxLabel *score1Label;
    SyntaxLabel *score2Label;
    SyntaxLabel *score3Label;
    SyntaxLabel *score4Label;
    SyntaxLabel *score5Label;
    SyntaxLabel *score6Label;
    SyntaxLabel *score7Label;
    SyntaxLabel *score8Label;
    SyntaxLabel *score9Label;
    SyntaxLabel *score10Label;
    SyntaxLabel *backButton;
}

- (void)updateLabelsForGameType:(int)thisGameType;

@end
