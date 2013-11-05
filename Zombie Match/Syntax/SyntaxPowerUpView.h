//
//  SyntaxPowerUpView.h
//  Syntax
//
//  Created by Seby Moisei on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface SyntaxPowerUpView : MSSView <UIAlertViewDelegate> {
    MSSView *motherView;
    int selectedPack;
    NSMutableArray *allPacks;
    SyntaxLabel *powerUpLabel;
    SyntaxLabel *promptPack3;
    SyntaxLabel *promptPack5;
    SyntaxLabel *promptPack10;
    SyntaxLabel *wildcardPack3;
    SyntaxLabel *wildcardPack5;
    SyntaxLabel *wildcardPack10;
    SyntaxLabel *rectifierPack3;
    SyntaxLabel *rectifierPack5;
    SyntaxLabel *rectifierPack10;
    SyntaxLabel *bytesLabel;
    UIImageView *byteImage;
    UIButton *getBytesButton;
    UIButton *redeemButton;
    UIButton *removeAdsButton;
    SyntaxLabel *backButton;
    UIImageView *getBytesSquare;
    BOOL isGoingToDissapear;
    UIImageView *backgroundView;
    UIImageView *frameView;
}

@property (nonatomic, retain) SyntaxLabel *bytesLabel;
@property (nonatomic, retain) UIImageView *frameView;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller andMotherView:(MSSView *)thisView;
- (void)selectPack:(int)thisPack;
- (void)showGetBytesAlert;
- (void)animGlitchView:(UIView *)thisView;

@end