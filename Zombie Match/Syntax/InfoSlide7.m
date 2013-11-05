//
//  InfoSlide7.m
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoSlide7.h"

@implementation InfoSlide7

@synthesize canRelease;

- (id)initSlide {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 384) andViewController:nil];
    if (self) {
        canRelease = NO;
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        title = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        title.text = @"Special Symbols";
        title.center = CGPointMake(160, 53);
        [title styleWithSize:23];
        [self addSubview:title];
        
        symbolManager = [[SymbolManager alloc] initWithViewController:viewController];
        
        wildcard = [symbolManager randomSymbolWithMaxType:7];
        [symbolManager turnToWildcardSymbol:wildcard];
        wildcard.center = CGPointMake(50, 100);
        [self addSubview:wildcard];
        
        corrupted = [symbolManager randomSymbolWithMaxType:7];
        [symbolManager shiftSymbol:corrupted toType:9];
        corrupted.center = CGPointMake(50, 170);
        [self addSubview:corrupted];
        
        shifter = [symbolManager randomSymbolWithMaxType:7];
        shifter.isShifter = YES;
        [symbolManager shiftSymbol:shifter toType:arc4random() % 7];
        shifter.center = CGPointMake(50, 245);
        [self addSubview:shifter];
        
        hidden = [symbolManager randomSymbolWithMaxType:7];
        [symbolManager cleanSymbol:hidden];
        hidden.symbolAnimation = [[[UIImageView alloc] initWithFrame:hidden.frame] autorelease];
        hidden.symbolAnimation.animationImages = [NSArray arrayWithObjects:
                                                  [UIImage imageNamed:@"symbol10-1"],
                                                  [UIImage imageNamed:@"symbol10-2"],
                                                  [UIImage imageNamed:@"symbol10-3"],
                                                  [UIImage imageNamed:@"symbol10-4"],nil];
        hidden.symbolAnimation.animationDuration = 0.5;
        hidden.symbolAnimation.animationRepeatCount = 0;
        [hidden addSubview:hidden.symbolAnimation];
        [hidden.symbolAnimation startAnimating];
        hidden.center = CGPointMake(50, 315);
        [self addSubview:hidden];        
        
        wildcardText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 210, 70)];
        wildcardText.text = @"Tap the symbol then tap any zombies to change the Chameleon into that zombies.";
        wildcardText.center = CGPointMake(210, 100);
        [wildcardText styleWithSize:16];
        wildcardText.textAlignment = UITextAlignmentLeft;
        wildcardText.numberOfLines = 6;
        [self addSubview:wildcardText];
        
        corruptedText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 210, 70)];
        corruptedText.text = @"The Platypus is deranged! The only way to get rid of him is with the Magic Net or with the Platypus Trap!";
        corruptedText.center = CGPointMake(210, 170);
        [corruptedText styleWithSize:16];
        corruptedText.textAlignment = UITextAlignmentLeft;
        corruptedText.numberOfLines = 6;
        [self addSubview:corruptedText];
        
        shifterText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 210, 70)];
        shifterText.text = @"This sneaky symbol changes to a new zombies every time you make a move.";
        shifterText.center = CGPointMake(210, 245);
        [shifterText styleWithSize:16];
        shifterText.textAlignment = UITextAlignmentLeft;
        shifterText.numberOfLines = 6;
        [self addSubview:shifterText];
        
        hiddenText = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 210, 70)];
        hiddenText.text = @"Tap the bush to see what zombies is hiding behind it. But watch out for the Deranged Platypus!";
        hiddenText.center = CGPointMake(210, 315);
        [hiddenText styleWithSize:16];
        hiddenText.textAlignment = UITextAlignmentLeft;
        hiddenText.numberOfLines = 6;
        [self addSubview:hiddenText];        
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
    shifter.isOfType = arc4random() % 7;
    [symbolManager animShifterSymbol:shifter];
    if (!canRelease) [self performSelector:@selector(checkRelease) withObject:nil afterDelay:1];
    else {
        [self removeFromSuperview];
        [self release];
    }
}

- (void)dealloc {
    NSLog(@"slide released");
    [self removeSubView:title];
    [self removeSubView:wildcard];
    [self removeSubView:corrupted];
    [self removeSubView:shifter];
    [self removeSubView:hidden];
    [self removeSubView:wildcardText];
    [self removeSubView:corruptedText];
    [self removeSubView:shifterText];
    [self removeSubView:hiddenText];
    [symbolManager release];
    [super dealloc];
}

@end

