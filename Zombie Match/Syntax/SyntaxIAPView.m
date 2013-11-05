//
//  SyntaxIAPView.m
//  Syntax
//
//  Created by Seby Moisei on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxIAPView.h"
#import "ViewController.h"

@implementation SyntaxIAPView

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller andMotherView:(MSSView *)thisView{
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        motherView = [thisView retain];
        self.alpha = 0;
        isGoingBack = NO;
        
        allIAP = [[NSMutableArray alloc] init];
        allByteSymbols = [[NSMutableSet alloc] init];
        
//        getBytesLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 45)];        
//        getBytesLabel.text = @">> GET TOKENS! <<";
//        getBytesLabel.center = CGPointMake(160, 30);
//        [getBytesLabel styleWithSize:35];
//        [getBytesLabel shadowSizeRatio:8];
//        getBytesLabel.textColor = [UIColor whiteColor];
//        getBytesLabel.layer.shadowColor = [[UIColor colorWithRed:0.949 green:0.835 blue:0.533 alpha:1] CGColor];
//        [self addSubview:getBytesLabel];
        
        loadingLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 45)];        
        loadingLabel.text = @"Loading ...";
        loadingLabel.center = CGPointMake(160, 240);
        [loadingLabel styleWithSize:26];
        [loadingLabel shadowSizeRatio:8];
        [self addSubview:loadingLabel];
        
        disconnectLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 45)];        
        disconnectLabel.text = @"Failed connection ...";
        disconnectLabel.center = CGPointMake(160, 240);
        [disconnectLabel styleWithSize:26];
        [disconnectLabel shadowSizeRatio:8];
        disconnectLabel.alpha = 0;
        [self addSubview:disconnectLabel];
        
        int scrWidth = 320;
        int scrCenterX = scrWidth / 2;
        int scrHeight = 480;
        NSString *devPrefix = @"iphone_";
        if(IS_IPHONE_5) {
            devPrefix = @"iphone5_";
            scrHeight = 568;
        }
        
        backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrWidth, scrHeight)];
        backgroundView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", devPrefix, @"gettokens.jpg"]];
        [self addSubview:backgroundView];
        [backgroundView release];
                
        buyBytes1000Button = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 70)];
//        buyBytes1000Button.text = @"+1000     ADD TO CART";
        buyBytes1000Button.center = CGPointMake(scrCenterX, (IS_IPHONE_5)?145:115);
        [buyBytes1000Button styleWithSize:21];
        buyBytes1000Button.textAlignment = UITextAlignmentRight;
        buyBytes1000Button.alpha = 0;
        [self addSubview:buyBytes1000Button];
        [allIAP addObject:buyBytes1000Button];
        
        buyBytes3000Button = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 70)];
//        buyBytes3000Button.text = @"+3000     ADD TO CART";
        buyBytes3000Button.center = CGPointMake(scrCenterX, (IS_IPHONE_5)?225:185);
        [buyBytes3000Button styleWithSize:21];
        buyBytes3000Button.textAlignment = UITextAlignmentRight;
        buyBytes3000Button.alpha = 0;
        [self addSubview:buyBytes3000Button];
        [allIAP addObject:buyBytes3000Button];
//        
        buyBytes7500Button = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 70)];
//        buyBytes7500Button.text = @"+7500     ADD TO CART";
        buyBytes7500Button.center = CGPointMake(160, (IS_IPHONE_5)?295:255);
        [buyBytes7500Button styleWithSize:21];
        buyBytes7500Button.textAlignment = UITextAlignmentRight;
        buyBytes7500Button.alpha = 0;
        [self addSubview:buyBytes7500Button];
        [allIAP addObject:buyBytes7500Button];

        buyBytes20000Button = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 70)];
//        buyBytes20000Button.text = @"+20000     ADD TO CART";
        buyBytes20000Button.center = CGPointMake(160, (IS_IPHONE_5)?375:325);
        [buyBytes20000Button styleWithSize:21];
        buyBytes20000Button.textAlignment = UITextAlignmentRight;
        buyBytes20000Button.alpha = 0;
        [self addSubview:buyBytes20000Button];
        [allIAP addObject:buyBytes20000Button];
        
        buyBytes50000Button = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, scrWidth, 70)];
//        buyBytes50000Button.text = @"+50000     ADD TO CART";
        buyBytes50000Button.center = CGPointMake(160, (IS_IPHONE_5)?455:395);
        [buyBytes50000Button styleWithSize:21];
        buyBytes50000Button.textAlignment = UITextAlignmentRight;
        buyBytes50000Button.alpha = 0;
        [self addSubview:buyBytes50000Button];
        [allIAP addObject:buyBytes50000Button];
        
        backButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 50)];
        backButton.center = CGPointMake(50, (IS_IPHONE_5)?500:440);
        [backButton styleWithSize:25];
        [self addSubview:backButton];
    }
    return self;
}

- (void)didMoveToSuperview {
    [viewController hideFlurryBanner];
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:self withAction:^{
            [getBytesLabel animGlitchWithDelay:0 andDoRepeat:NO];
            [viewController.byteManager requestProductDataFromIAPView:self];
//            [self showIAP];
        }];
    }
    else isVisible = NO;
}

- (void)showIAP {
    [self fadeOutView:loadingLabel withAction:^{}];
    [self fadeInView:buyBytes1000Button withAction:^{}];
    [self fadeInView:buyBytes3000Button withAction:^{}];
    [self fadeInView:buyBytes7500Button withAction:^{}];
    [self fadeInView:buyBytes20000Button withAction:^{}];
    [self fadeInView:buyBytes50000Button withAction:^{}];
}

- (void)disconnect {
    isGoingBack = YES;
    [self fadeOutView:loadingLabel withAction:^{}];
    [self fadeInView:disconnectLabel withAction:^{}];
    [self performSelector:@selector(backToMotherView) withObject:nil afterDelay:2];    
}

- (void)backToMotherView {
    isGoingBack = YES;
    if(viewController.powerUpView)
        viewController.powerUpView.bytesLabel.text = [NSString stringWithFormat:@"%d", viewController.byteManager.bytes];
    [self fadeOutView:self withAction:^{
        [motherView fadeInView:motherView withAction:^{}];
        [viewController removeView:self];
    }];    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == backButton) {
        if (!isGoingBack) {
            [viewController.soundController playSound:@"GeneralMenuButton"];
            [self touchButton:backButton withAction:^{
                [self fadeOutView:self withAction:^{
                    [motherView fadeInView:motherView withAction:^{}];
                    [viewController removeView:self];
                }];          
            }];            
        }
    }
    
    if ([allIAP containsObject:[touch view]]) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        int k = [allIAP indexOfObject:[touch view]];
        [self touchButton:[allIAP objectAtIndex:k] withAction:^{
            [viewController.byteManager buyIAP:k fromIAPView:self];
        }];        
    }
}


- (void)dealloc {
    [motherView release];
    [allIAP removeAllObjects];
    [allIAP release];
    [allByteSymbols removeAllObjects];
    [allByteSymbols release];
    [self removeSubView:getBytesLabel];
    [self removeSubView:buyBytes1000Button];
    [self removeSubView:buyBytes3000Button];
    [self removeSubView:buyBytes7500Button];
    [self removeSubView:buyBytes20000Button];
    [self removeSubView:buyBytes50000Button];
    [self removeSubView:backButton];
    [self removeSubView:greatValueLabel];
    [self removeSubView:insaneDealLabel];
    [super dealloc];
}


@end
