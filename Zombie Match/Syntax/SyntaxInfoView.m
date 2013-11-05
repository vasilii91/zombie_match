//
//  SyntaxInfoView.m
//  Syntax
//
//  Created by Seby Moisei on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxInfoView.h"
#import "ViewController.h"
#import "InfoSlide1.h"
#import "InfoSlide2.h"
#import "InfoSlide3.h"
#import "InfoSlide4.h"
#import "InfoSlide5.h"
#import "InfoSlide6.h"
#import "InfoSlide7.h"
#import "InfoSlide8.h"
#import "InfoSlide9.h"
#import "InfoSlide10.h"

@implementation SyntaxInfoView

@synthesize shortened, playButton, gameToGo;

#define kShortenedCount 6

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        self.alpha = 0;
        currentSlide = 1;
        
        infoButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 94, 30)];
        infoButton.text = @"INFO";
        infoButton.center = CGPointMake(72, 35);
        [infoButton styleWithSize:25];
        infoButton.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:infoButton];
        
        moreButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 94, 30)];
        moreButton.text = @"MORE";
        moreButton.center = CGPointMake(160, 35);
        [moreButton styleWithSize:25];
        moreButton.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:moreButton];
        
        backButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 94, 22)];
        backButton.text = @"<< BACK";
        backButton.center = CGPointMake(248, 35);
        [backButton styleWithSize:25];
        backButton.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:backButton];
        
        infoBackground = [[self serveSubviewNamed:@"infoBackground" withCenter:CGPointMake(160, 245) touchable:YES] retain];
        [self addSubview:infoBackground];
        
        previousSlideButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        previousSlideButton.text = @"<<<";
        previousSlideButton.center = CGPointMake(25, 350);
        [previousSlideButton styleWithSize:25];
        [infoBackground addSubview:previousSlideButton];
        
        nextSlideButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        nextSlideButton.text = @">>>";
        nextSlideButton.center = CGPointMake(295, 350);
        [nextSlideButton styleWithSize:25];
        [infoBackground addSubview:nextSlideButton];
        
        self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 207, 71)];
        [playButton setImage:[UIImage imageNamed:@"howtoplaybutton"] forState:UIControlStateNormal];
        [playButton setCenter:CGPointMake(160, 430)];
        [playButton addTarget:self action:@selector(goToPlayHandler) forControlEvents:UIControlEventTouchUpInside];
        [playButton setAlpha:0];
        [self addSubview:playButton];
        [playButton release];
        
        if (currentSlide == 1) previousSlideButton.alpha = 0;
        if (currentSlide == 10) nextSlideButton.alpha = 0;
        
        gameToGo = nil;
        canGoToPlay = NO;
        shortened = NO;
    }
    return self;
}

- (void)didMoveToSuperview {
    if(self.shortened) {
        header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howtoplaysign"]];
        header.center = CGPointMake(160, 41);
        [self addSubview:header];
        [header release];
    }
    
    if (!isVisible) {
        isVisible = YES;
        isMore = YES;        
        [self fadeInView:self withAction:^{
            [self showSlideNumber:1];
            [self showMore];
        }];
    }
    else isVisible = NO;
}

- (void)goToPlayHandler {    
    [self fadeOutView:self withAction:^{
        canGoToPlay = NO;
        if(self.gameToGo)
            [viewController performSelector:gameToGo];
        else [viewController showPrimaryView];
    }];
}

- (void)showSlideNumber:(int)thisSlideNumber {
    if (currentSlide == 1) [self fadeOutView:previousSlideButton withAction:^{}];
    else if (previousSlideButton.alpha == 0) [self fadeInView:previousSlideButton withAction:^{}];
    
    if (currentSlide < 10)
        [self fadeInView:nextSlideButton withAction:^{}];
    else if (nextSlideButton.alpha == 0)
        [self fadeOutView:nextSlideButton withAction:^{}];
    
    if(self.shortened && currentSlide >= kShortenedCount - 1 && nextSlideButton.alpha == 0) [self fadeOutView:nextSlideButton withAction:^{}];
    
    if (infoSlide1 != nil) {
        infoSlide1.canRelease = YES;
        [self fadeOutView:infoSlide1 withAction:^{}];
        infoSlide1 = nil;
    }
    if (infoSlide2 != nil) {
        infoSlide2.canRelease = YES;
        [self fadeOutView:infoSlide2 withAction:^{}];
        infoSlide2 = nil;
    }
    
    if (infoSlide3 != nil) {
        infoSlide3.canRelease = YES;
        [self fadeOutView:infoSlide3 withAction:^{}];
        infoSlide3 = nil;
    }
    
    if (infoSlide4 != nil) {
        infoSlide4.canRelease = YES;
        [self fadeOutView:infoSlide4 withAction:^{}];
        infoSlide4 = nil;
    }
    
    if (infoSlide5 != nil) {
        infoSlide5.canRelease = YES;
        [self fadeOutView:infoSlide5 withAction:^{}];
        infoSlide5 = nil;
    }
    
    if (infoSlide6 != nil) {
        infoSlide6.canRelease = YES;
        [self fadeOutView:infoSlide6 withAction:^{}];
        infoSlide6 = nil;
    }
    
    if (infoSlide7 != nil) {
        infoSlide7.canRelease = YES;
        [self fadeOutView:infoSlide7 withAction:^{}];
        infoSlide7 = nil;
    }
    
    if (infoSlide8 != nil) {
        infoSlide8.canRelease = YES;
        [self fadeOutView:infoSlide8 withAction:^{}];
        infoSlide8 = nil;
    }
    
    if (infoSlide9 != nil) {
        infoSlide9.canRelease = YES;
        [self fadeOutView:infoSlide9 withAction:^{}];
        infoSlide9 = nil;
    }
    
    if (infoSlide10 != nil) {
        infoSlide10.canRelease = YES;
        [self fadeOutView:infoSlide10 withAction:^{}];
        infoSlide10 = nil;
    }

//    NSArray *currentArray = normalArray;
//    if(self.shortened) currentArray = shortArray;
//    Class slideClass = [[currentArray objectAtIndex:thisSlideNumber] class]; //just to not rewrite everything else. km
//    MSSView *slide = [[slideClass alloc] initSlide];
    //    [infoBackground addSubview:slide];
    
    if(!self.shortened)
        switch (thisSlideNumber) {
            case 1:
                infoSlide1 = [[InfoSlide1 alloc] initSlide]; //who did this???...
                [infoBackground addSubview:infoSlide1];
                break;
            case 2:
                infoSlide2 = [[InfoSlide2 alloc] initSlide];
                [infoBackground addSubview:infoSlide2];
                break;
            case 3:
                infoSlide3 = [[InfoSlide3 alloc] initSlide];
                [infoBackground addSubview:infoSlide3];
                break;
            case 4:
                infoSlide4 = [[InfoSlide4 alloc] initSlide];
                [infoBackground addSubview:infoSlide4];
                break;
            case 5:
                infoSlide5 = [[InfoSlide5 alloc] initSlide];
                [infoBackground addSubview:infoSlide5];
                break;
            case 6:
                infoSlide6 = [[InfoSlide6 alloc] initSlide];
                [infoBackground addSubview:infoSlide6];
                break;
            case 7:
                infoSlide7 = [[InfoSlide7 alloc] initSlide];
                [infoBackground addSubview:infoSlide7];
                break;
            case 8:
                infoSlide8 = [[InfoSlide8 alloc] initSlide];
                [infoBackground addSubview:infoSlide8];
                break;
            case 9:
                infoSlide9 = [[InfoSlide9 alloc] initSlide];
                [infoBackground addSubview:infoSlide9];
                break;
            case 10:
                infoSlide10 = [[InfoSlide10 alloc] initSlide];
                [infoBackground addSubview:infoSlide10];
                break;
            default:
                break;
        }
    else
        switch (thisSlideNumber) {
            case 1:
                infoSlide1 = [[InfoSlide1 alloc] initSlide]; //who did this???...
                [infoBackground addSubview:infoSlide1];
                break;
            case 2:
                infoSlide2 = [[InfoSlide2 alloc] initSlide];
                [infoBackground addSubview:infoSlide2];
                break;
            case 3:
                infoSlide3 = [[InfoSlide3 alloc] initSlide];
                [infoBackground addSubview:infoSlide3];
                break;
            case 4:
                infoSlide7 = [[InfoSlide7 alloc] initSlide];
                [infoBackground addSubview:infoSlide7];
                break;
            case 5:
                infoSlide8 = [[InfoSlide8 alloc] initSlide];
                [infoBackground addSubview:infoSlide8];
                break;
            case 6:
                infoSlide9 = [[InfoSlide9 alloc] initSlide];
                [infoBackground addSubview:infoSlide9];
                break;
            default:
                break;
        }
}

- (void)showMore {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_FULL_VERSION]) {

    // I dont want to show apps here.
    
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == backButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:backButton withAction:^{
            [self fadeOutView:self withAction:^{
                if(self.shortened)
                    [viewController showMainView];
                else
                    [viewController showMoreView];
                [viewController removeView:self];
            }];          
        }];
    }
    if ([touch view] == moreButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:moreButton withAction:^{
            [self showMore];             
        }];
    }
    if ([touch view] == previousSlideButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:previousSlideButton withAction:^{
            [playButton setAlpha:0];
            [nextSlideButton setText:@">>>"];
            if (currentSlide > 1) {
                currentSlide--;
                [self showSlideNumber:currentSlide];
            }
        }];
    }
    if ([touch view] == nextSlideButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:nextSlideButton withAction:^{
            if (currentSlide < 10) {
                if(!(self.shortened && currentSlide >= kShortenedCount - 1)) {
                    currentSlide++;
                    [self showSlideNumber:currentSlide];
                }
                else {
                    currentSlide++;
                    [self showSlideNumber:currentSlide];
                    [playButton setAlpha:1];
                    [self fadeOutView:nextSlideButton withAction:^{}];
                }
            }
        }];
    }
}

- (void)dealloc {
    NSLog(@"info release");
    [self removeSubView:infoButton];
    [self removeSubView:moreButton];
    [self removeSubView:previousSlideButton];
    [self removeSubView:nextSlideButton];
    [self removeSubView:backButton];
    [self removeSubView:moreTable];
    playButton = nil;
    infoSlide1.canRelease = YES;
    infoSlide2.canRelease = YES;
    infoSlide3.canRelease = YES;
    infoSlide4.canRelease = YES;
    infoSlide5.canRelease = YES;
    infoSlide6.canRelease = YES;
    infoSlide7.canRelease = YES;
    infoSlide8.canRelease = YES;
    infoSlide9.canRelease = YES;
    infoSlide10.canRelease = YES;
    [self removeSubView:infoBackground];
    [super dealloc];
}
@end
