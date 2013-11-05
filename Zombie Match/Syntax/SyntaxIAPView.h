//
//  SyntaxIAPView.h
//  Syntax
//
//  Created by Seby Moisei on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxPowerUpView.h"
#import "SyntaxLabel.h"

@interface SyntaxIAPView : MSSView {
    MSSView *motherView;
    NSMutableArray *allIAP;
    NSMutableSet *allByteSymbols;
    SyntaxLabel *loadingLabel;
    SyntaxLabel *disconnectLabel;
    SyntaxLabel *getBytesLabel;
    SyntaxLabel *buyBytes1000Button;
    SyntaxLabel *buyBytes3000Button;
    SyntaxLabel *buyBytes7500Button;
    SyntaxLabel *buyBytes20000Button;
    SyntaxLabel *buyBytes50000Button;
    SyntaxLabel *backButton;
    SyntaxLabel *greatValueLabel;
    SyntaxLabel *insaneDealLabel;
    BOOL isGoingBack;
    UIImageView *backgroundView;
}

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller andMotherView:(MSSView *)thisView;
- (void)showIAP;
- (void)disconnect;
- (void)backToMotherView;

@end
