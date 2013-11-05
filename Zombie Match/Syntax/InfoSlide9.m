//
//  InfoSlide9.m
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoSlide9.h"

@implementation InfoSlide9

@synthesize canRelease;

- (id)initSlide {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 384) andViewController:nil];
    if (self) {
        canRelease = NO;
        
        
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        title = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        title.text = @"Power Up's!";
        title.center = CGPointMake(160, 53);
        [title styleWithSize:23];
        [self addSubview:title];
        

        // Tokens
        tokens = [[self serveSubviewNamed:@"byteSymbol" withCenter:CGPointMake(50, 116) touchable:NO] retain];
        [self addSubview:tokens];
        
        // Clues
        clues = [[self serveSubviewNamed:@"cluesymbol" withCenter:CGPointMake(50, 178) touchable:NO] retain];
        [self addSubview:clues];
        
        // Camelions
        chameleon = [[self serveSubviewNamed:@"symbol7" withCenter:CGPointMake(50, 237) touchable:NO] retain];
        [self addSubview:chameleon];
        
        // Plat Trap
        platTrap = [[self serveSubviewNamed:@"plattrapsymbol" withCenter:CGPointMake(50, 299) touchable:NO] retain];
        [self addSubview:platTrap];
              
            
        slideText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 210, 70)];
        slideText.text = @"Visit the Power Up! screen to redeem Tokens for power up’s.";
        slideText.center = CGPointMake(210, 116);
        [slideText styleWithSize:16];
        slideText.textAlignment = UITextAlignmentLeft;
        slideText.numberOfLines = 6;
        [self addSubview:slideText];
    
        
        PPFText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 210, 70)];
        PPFText.text = @"The Penalty-Free Hint (PFH) gives you a Hint without affecting your score.";
        PPFText.center = CGPointMake(210, 178);
        [PPFText styleWithSize:16];
        PPFText.textAlignment = UITextAlignmentLeft;
        PPFText.numberOfLines = 6;
        [self addSubview:PPFText];
        
        wildcardText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 210, 70)];
        wildcardText.text = @"Need more Chameleons? Redeem some Tokens to Power Up and get them.";
        wildcardText.center = CGPointMake(210, 237);
        [wildcardText styleWithSize:16];
        wildcardText.textAlignment = UITextAlignmentLeft;
        wildcardText.numberOfLines = 6;
        [self addSubview:wildcardText];
        
        rectifierText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 210, 70)];
        rectifierText.text = @"No Magic Nets? Grab some Platypus Traps, and get rid of Mr. Platypus!";
        rectifierText.center = CGPointMake(210, 299);
        [rectifierText styleWithSize:16];
        rectifierText.textAlignment = UITextAlignmentLeft;
        rectifierText.numberOfLines = 6;
        [self addSubview:rectifierText];
        
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:self withAction:^{
            [self checkRelease];
        }];
    }
    else isVisible = NO;
}

- (void)checkRelease {
    if (!canRelease) [self performSelector:@selector(checkRelease) withObject:nil afterDelay:1];
    else {
        [self removeFromSuperview];
        [self release];
    }
}

- (void)dealloc {
    NSLog(@"slide released");
    [self removeSubView:title];
    [self removeSubView:slideText];
    [self removeSubView:PPF];
    [self removeSubView:wildcard];
    [self removeSubView:rectifier];
    [self removeSubView:PPFText];
    [self removeSubView:wildcardText];
    [self removeSubView:rectifierText];
    [super dealloc];
}

@end
