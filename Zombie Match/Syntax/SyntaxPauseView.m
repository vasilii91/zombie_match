//
//  SyntaxPauseView.m
//  Syntax
//
//  Created by Seby Moisei on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxPauseView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation SyntaxPauseView

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        self.alpha = 0;
        isGoingToDissapear = NO;
        
        matchLogo = [[self serveSubviewNamed:@"zookeeper_logo" withCenter:CGPointMake(160, 80) touchable:NO] retain];
        [self addSubview:matchLogo];
        
        resumeButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        resumeButton.center = CGPointMake(160, 165);
        resumeButton.text = @"RESUME";
        [resumeButton styleWithSize:30];
        [self addSubview:resumeButton];
        
        mainMenuButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        mainMenuButton.center = CGPointMake(160, 210);
        mainMenuButton.text = @"MAIN MENU";
        [mainMenuButton styleWithSize:30];
        [self addSubview:mainMenuButton];
        
        powerUpButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        powerUpButton.text = @"POWER UP!";
        powerUpButton.center = CGPointMake(160, 255);
        [powerUpButton styleWithSize:30];
        [self addSubview:powerUpButton];
        
        getFreeAppButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 240, 45)];
        getFreeAppButton.text = @"GET FREE APP!";
        getFreeAppButton.center = CGPointMake(160, 300);
        [getFreeAppButton styleWithSize:30];
        getFreeAppButton.textColor = [UIColor colorWithRed:1 green:0.3 blue:0.3 alpha:1];
        getFreeAppButton.layer.shadowColor = [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] CGColor];
        getFreeAppButton.clipsToBounds = NO;
        [self addSubview:getFreeAppButton];
        
        powerUpSquare = [[self serveSubviewNamed:@"powerUpSquare" withCenter:CGPointMake(120, 22.5) touchable:NO] retain];
        [getFreeAppButton addSubview:powerUpSquare];
        
        SFXButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        SFXButton.center = CGPointMake(160, 345);
        if (viewController.soundController.isSFXOff) SFXButton.text = @"SFX ON";
        else SFXButton.text = @"SFX OFF";
        [SFXButton styleWithSize:30];
        [self addSubview:SFXButton];
        
        musicButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        musicButton.center = CGPointMake(160, 390);
        if (viewController.musicController.isMusicOff) musicButton.text = @"Music ON";
        else musicButton.text = @"Music OFF";
        [musicButton styleWithSize:30];
        [self addSubview:musicButton];
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [viewController.musicController fadeToSong:@"MainTitles(Syntax)" andReplay:YES];
        [self fadeInView:self withAction:^{
        }];
    }
    else isVisible = NO;
}

- (void)animGlitchLetter:(UIView *)thisLetter {
    // Dont do anything here because we dont want it to glitch anymore.
    }

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == resumeButton) {
        isGoingToDissapear = YES;
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:resumeButton withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController resumeGame];
            }];          
        }];
    }    
    if ([touch view] == mainMenuButton) {
        isGoingToDissapear = YES;
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:mainMenuButton withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController backToMenuFromPause];
                [((AppDelegate *)[[UIApplication sharedApplication] delegate]).viewController showFullScreenAd];
            }];          
        }];
    }
    if ([touch view] == powerUpButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:powerUpButton withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController showPowerUpViewInView:self];                
            }];
        }];
    }
    if ([touch view] == getFreeAppButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:getFreeAppButton withAction:^{
            [viewController getFreeApp];
        }];
    }
    if ([touch view] == SFXButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        if (viewController.soundController.isSFXOff) {
            [SFXButton animUpdateWithText:@"SFX OFF"];
            [viewController.soundController turnSoundOn];            
        }
        else {
            [SFXButton animUpdateWithText:@"SFX ON"];
            [viewController.soundController turnSoundOff];            
        }
    }
    if ([touch view] == musicButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        if (viewController.musicController.isMusicOff) {
            [musicButton animUpdateWithText:@"Music ON"];
            [viewController.musicController turnMusicOn];            
        }
        else {
            [musicButton animUpdateWithText:@"Music OFF"];
            [viewController.musicController turnMusicOff];            
        }
    }
}

- (void)dealloc {
    [self removeSubView:powerUpSquare];
    [self removeSubView:resumeButton];
    [self removeSubView:mainMenuButton];
    [self removeSubView:powerUpButton];
    [self removeSubView:getFreeAppButton];
    [self removeSubView:SFXButton];
    [self removeSubView:musicButton];
    [super dealloc];
}
@end
