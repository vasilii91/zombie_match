//
//  SyntaxPowerUpView.m
//  Syntax
//
//  Created by Seby Moisei on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxPowerUpView.h"
#import "ViewController.h"
#import "SyntaxPrimaryView.h"
#import "SyntaxActionView.h"
#import "SyntaxInfinityView.h"
#import "SyntaxGameOverView.h"

@implementation SyntaxPowerUpView

@synthesize bytesLabel, frameView;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller andMotherView:(MSSView *)thisView{
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        motherView = [thisView retain];
        self.alpha = 0;
        isGoingToDissapear = NO;
        selectedPack = -1;
        
        allPacks = [[NSMutableArray alloc] init];
        
        int scrWidth = 320;
        int scrHeight = 480;
        NSString *devPrefix = @"iphone_";
        if(IS_IPHONE_5) {
            devPrefix = @"iphone5_";
            scrHeight = 568;
        }
        
        backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
        backgroundView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", devPrefix, @"newstore.jpg"]];
        [self addSubview:backgroundView];
        [backgroundView release];
        
        promptPack5 = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];        
//        promptPack5.text = @"Zoo";
        promptPack5.center = CGPointMake(230, (IS_IPHONE_5)?145:120);
        [promptPack5 styleWithSize:20];
        [self addSubview:promptPack5];
        [allPacks addObject:promptPack5];
        
        promptPack10 = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];        
//        promptPack10.text = @"Zoo";
        promptPack10.center = CGPointMake(230, (IS_IPHONE_5)?176:150);
        [promptPack10 styleWithSize:20];
        [self addSubview:promptPack10];
        [allPacks addObject:promptPack10];
        
        wildcardPack5 = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];        
//        wildcardPack5.text = @"Chameleon 5 Pack -> 1250 tokens";/
        wildcardPack5.center = CGPointMake(230, (IS_IPHONE_5)?230:194);
        [wildcardPack5 styleWithSize:20];
        [self addSubview:wildcardPack5];
        [allPacks addObject:wildcardPack5];
        
        wildcardPack10 = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];        
//        wildcardPack10.text = @"Chameleon 10 Pack -> 2500 tokens";
        wildcardPack10.center = CGPointMake(230, (IS_IPHONE_5)?264:224);
        [wildcardPack10 styleWithSize:20];
        [self addSubview:wildcardPack10];
        [allPacks addObject:wildcardPack10];
        
        rectifierPack5 = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];        
//        rectifierPack5.text = @"Platypus Trap 5 Pack -> 2500 tokens";
        rectifierPack5.center = CGPointMake(230, (IS_IPHONE_5)?317:266);
        [rectifierPack5 styleWithSize:20];
        [self addSubview:rectifierPack5];
        [allPacks addObject:rectifierPack5];
        
        rectifierPack10 = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];        
//        rectifierPack10.text = @"Platypus Trap 10 Pack -> 5000 tokens";
        rectifierPack10.center = CGPointMake(230, (IS_IPHONE_5)?346:296);
        [rectifierPack10 styleWithSize:20];
        [self addSubview:rectifierPack10];
        [allPacks addObject:rectifierPack10];
        
        bytesLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        bytesLabel.text = [NSString stringWithFormat:@"%d", viewController.byteManager.bytes];
        bytesLabel.center = CGPointMake(310, (IS_IPHONE_5)?497:447);
        [bytesLabel styleWithSize:25];
        bytesLabel.textColor = [UIColor whiteColor];
        bytesLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:bytesLabel];
        
//        byteImage = [[self serveSubviewNamed:@"byteSymbol" withCenter:CGPointMake(-20, 15) touchable:NO] retain];
//        [bytesLabel addSubview:byteImage];
        
        getBytesButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 131, 84)];
        getBytesButton.center = CGPointMake(160, (IS_IPHONE_5)?500:430);
        [getBytesButton addTarget:self action:@selector(getBytesHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:getBytesButton];
        
//        getBytesSquare = [[self serveSubviewNamed:@"getBytesSquare" withCenter:CGPointMake(150, 22.5) touchable:NO] retain];
//        [getBytesButton addSubview:getBytesSquare];
        
        redeemButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 131, 84)];
        [redeemButton setImage:[UIImage imageNamed:@"makepurchase.png"] forState:UIControlStateNormal];
        [redeemButton setImage:[UIImage imageNamed:@"makepurchase_pressed.png"] forState:UIControlStateHighlighted];
        redeemButton.center = CGPointMake(160, (IS_IPHONE_5)?450:430);
        [redeemButton addTarget:self action:@selector(redeemHandler) forControlEvents:UIControlEventTouchUpInside];
        redeemButton.layer.shadowColor = [[UIColor colorWithRed:0.949 green:0.835 blue:0.533 alpha:1] CGColor];
        redeemButton.alpha = 0;
        [self addSubview:redeemButton];
        
        removeAdsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 84)];
        removeAdsButton.center = CGPointMake(160, (IS_IPHONE_5)?390:360);
        [removeAdsButton addTarget:self action:@selector(removeAdsHandler) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:removeAdsButton];
        
        backButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 45)];
//        backButton.text = @"<< BACK";
        backButton.center = CGPointMake(35, (IS_IPHONE_5)?450:430);
        [backButton styleWithSize:25];
        [self addSubview:backButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBytes) name:@"updateBytes" object:nil];
        }
    return self;
}

- (void)didMoveToSuperview {
    [viewController hideFlurryBanner];
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:self withAction:^{
            
        }];
    }
    else isVisible = NO;
}

- (void)updateBytes {    
    [bytesLabel animUpdateWithText:[NSString stringWithFormat:@"%d",[viewController.byteManager bytes]]];
}

- (void)redeemHandler {    
    [viewController.soundController playSound:@"GeneralMenuButton"];
    [self touchButton:redeemButton withAction:^{
        if (![viewController.byteManager getPack:selectedPack]) {
            [viewController.soundController playSound:@"NoMatch"];
            [self fadeOutView:redeemButton withAction:^{
                [self fadeInView:getBytesButton withAction:^{}];
                [self showGetBytesAlert];
            }];
        }
                
        for(UIView *subView in self.subviews)
            if(subView == self.frameView)
                [self removeSubView:subView];
        self.frameView = nil;
        
        selectedPack = -1;
        [bytesLabel animUpdateWithText:[NSString stringWithFormat:@"%d",[viewController.byteManager bytes]]];
        [self fadeOutView:redeemButton withAction:^{
            [self fadeInView:getBytesButton withAction:^{}];
        }];
    }];
}

- (void)getBytesHandler {
    [viewController.soundController playSound:@"GeneralMenuButton"];
    [self touchButton:getBytesButton withAction:^{
        [self fadeOutView:self withAction:^{
            [viewController showIAPViewInView:self];
        }];
    }];
}

- (void)removeAdsHandler {
    if(![[[NSUserDefaults standardUserDefaults] valueForKey:IAP_FULL_VERSION] boolValue])
        [viewController removeBanner:nil];
}

- (void)selectPack:(int)thisPack {
    if (selectedPack != thisPack) {
        for (SyntaxLabel *thisLabel in allPacks) {
            if ([allPacks objectAtIndex:thisPack] == thisLabel) {
                selectedPack = thisPack;
                //                [thisLabel animGlitchWithAction:^{
                //                    thisLabel.alpha = 1;
                
                for(UIView *subView in self.subviews)
                    if(subView == self.frameView)
                        [self removeSubView:subView];
                
                self.frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 169, 32)];
                frameView.center = thisLabel.center;
                frameView.image = [UIImage imageNamed:@"itemselect.png"];
                [self addSubview:frameView];
                [self.frameView release];
                //                }];
            }
            else {
                //                [frameView removeFromSuperview];
                //                [frameView release];
                //                [thisLabel animGlitchWithAction:^{
                //                    thisLabel.alpha = 0.3;
                //                }];
            }
        }
    }
}

- (void)showGetBytesAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not enought Tokens"
                                                        message:@"You're gonna need more Tokens for this. Get some now!"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Get!", nil];
    [[alertView autorelease] show];
    
}

- (void)animGlitchView:(UIView *)thisView {
    float delay = arc4random() % 20 / 10;
    float x = thisView.center.x;
    float y = thisView.center.y;
    
    if (isVisible & !isGoingToDissapear) {
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
                                                                                            if (isVisible & !isGoingToDissapear) [self animGlitchView:thisView];
                                                                                        }]; 
                                                                   }]; 
                                              }]; 
                         }];            
    }    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == backButton) {
        isGoingToDissapear = YES;
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:backButton withAction:^{
            [self fadeOutView:self withAction:^{
                if ((motherView == (MSSView *)viewController.pauseView) | (motherView == (MSSView *)viewController.mainView) | (motherView == (MSSView *)viewController.gameOverView)) {
                    [motherView fadeInView:motherView withAction:^{}];
                    [viewController removeView:self];                    
                }
                else {
                    switch (viewController.statsManager.selectedGameMode) {
                        case 0:
                            [viewController.primaryView resume];
                            [viewController.primaryView hideUIbuttons];
                            [viewController bottomBanner];
                            break;
                        case 1:
                            [viewController.actionView resume];
                            [viewController.actionView hideUIbuttons];
                            [viewController bottomBanner];
                            break;
                        case 2:
                            [viewController.infinityView resume];
                            [viewController.infinityView hideUIbuttons];
                            [viewController bottomBanner];
                        default:
                            break;
                    }
                }                
            }];          
        }];
    }
    if ([allPacks containsObject:[touch view]]) {
        if (selectedPack == -1) {
            [self fadeOutView:getBytesButton withAction:^{
                [self fadeInView:redeemButton withAction:^{}];
            }];
        }
        [viewController.soundController playSound:@"GeneralMenuButton"];
        int k = [allPacks indexOfObject:[touch view]];
        [self selectPack:k];        
    }
    if ([touch view] == getBytesButton) {
    }
    if ([touch view] == redeemButton) {
    }
}

- (void)dealloc {
    [motherView release];
    [allPacks removeAllObjects];
    [allPacks release];
    [self removeSubView:powerUpLabel];
    [self removeSubView:promptPack3];
    [self removeSubView:promptPack5];
    [self removeSubView:promptPack10];
    [self removeSubView:wildcardPack3];
    [self removeSubView:wildcardPack5];
    [self removeSubView:wildcardPack10];
    [self removeSubView:rectifierPack3];
    [self removeSubView:rectifierPack5];
    [self removeSubView:rectifierPack10];
    [self removeSubView:bytesLabel];
    [self removeSubView:byteImage];
    [self removeSubView:getBytesSquare];
    [self removeSubView:getBytesButton];
    [self removeSubView:redeemButton];
    [self removeSubView:backButton];
    [super dealloc];
}

#pragma UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self fadeOutView:self withAction:^{
            [viewController showIAPViewInView:self];                
        }];            
    }
}

@end
