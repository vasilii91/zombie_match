//
//  InfoSlide6.m
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoSlide6.h"
#import "SymbolManager.h"

@implementation InfoSlide6

@synthesize canRelease;

- (id)initSlide {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 384) andViewController:nil];
    if (self) {
        canRelease = NO;
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        title = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        title.text = @"Clues";
        title.center = CGPointMake(160, 60);
        [title styleWithSize:25];
        [self addSubview:title];
        
        slidetext = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
        slidetext.text = @"Can't find a match? Tap the Hints button for some help.";
        slidetext.center = CGPointMake(160, 140);
        [slidetext styleWithSize:20];
        slidetext.numberOfLines = 0;
        [self addSubview:slidetext];
        
        promptButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 120, 28)];        
        promptButton.text = @"CLUES x 5";
        promptButton.center = CGPointMake(255, 300);
        [promptButton styleWithSize:20];
        [self addSubview:promptButton];
        
        symbolManager = [[SymbolManager alloc] initWithViewController:nil];
        
        allSymbols = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:self withAction:^{
            [self initSymbols];
        }];
    }
    else isVisible = NO;
}

- (void)initSymbols {
    SyntaxSymbol *thisSymbol;
    
    thisSymbol = [symbolManager randomSymbolWithMaxType:7];
    thisSymbol.center = [self CGPointFromIndex:CGPointMake(0, 0)];
    [symbolManager shiftSymbol:thisSymbol toType:2];
    [allSymbols addObject:thisSymbol];
    [self addSubview:thisSymbol];
    
    thisSymbol = [symbolManager randomSymbolWithMaxType:7];
    thisSymbol.center = [self CGPointFromIndex:CGPointMake(1, 0)];
    [symbolManager shiftSymbol:thisSymbol toType:5];
    [allSymbols addObject:thisSymbol];
    [self addSubview:thisSymbol];
    
    thisSymbol = [symbolManager randomSymbolWithMaxType:7];
    thisSymbol.center = [self CGPointFromIndex:CGPointMake(0, 1)];
    [symbolManager shiftSymbol:thisSymbol toType:3];
    [allSymbols addObject:thisSymbol];
    [self addSubview:thisSymbol];
    
    thisSymbol = [symbolManager randomSymbolWithMaxType:7];
    thisSymbol.center = [self CGPointFromIndex:CGPointMake(1, 1)];
    [symbolManager shiftSymbol:thisSymbol toType:3];
    [allSymbols addObject:thisSymbol];
    [self addSubview:thisSymbol];
    
    symbolA = [symbolManager randomSymbolWithMaxType:7];
    symbolA.center = [self CGPointFromIndex:CGPointMake(2, 0)];
    [symbolManager shiftSymbol:symbolA toType:3];
    [allSymbols addObject:symbolA];
    [self addSubview:symbolA];
    
    symbolB = [symbolManager randomSymbolWithMaxType:7];
    symbolB.center = [self CGPointFromIndex:CGPointMake(2, 1)];
    [symbolManager shiftSymbol:symbolB toType:4];
    [allSymbols addObject:symbolB];
    [self addSubview:symbolB];
    
    if (!canRelease) [self performSelector:@selector(step1) withObject:nil afterDelay:0.2];
    else [self releaseSymbols];
}

- (void)step1 {
    NSLog(@"prins");    
    [viewController.soundController playSound:@"PromptButton"];
    [promptButton animUpdateWithText:@"CLUES x 4"];
    
    if (!canRelease) [self performSelector:@selector(step2) withObject:nil afterDelay:0.5];
    else [self releaseSymbols];
}

- (void)step2 {
    [symbolManager animFlashSymbol:symbolA];
    
    if (!canRelease) [self performSelector:@selector(releaseSymbols) withObject:nil afterDelay:1];
    else [self releaseSymbols];                 
}

- (void)releaseSymbols {
    promptButton.text = @"CLUES x 5";
    for (SyntaxSymbol *thisSymbol in allSymbols) {
        [thisSymbol removeFromSuperview];
    }
    [allSymbols removeAllObjects];
    if (!canRelease) [self initSymbols];
    else {
        [self removeFromSuperview];
        [self release];
    }
}

- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex {
    return CGPointMake(120 + (thisIndex.x * 40), 384 - (120 + (thisIndex.y * 40)));
}

- (void)dealloc {
    NSLog(@"slide released");
    [self removeSubView:title];
    [self removeSubView:slidetext];
    [symbolManager release];
    for (SyntaxSymbol *thisSymbol in allSymbols) {
        [thisSymbol removeFromSuperview];
        [thisSymbol release];
    }
    [allSymbols removeAllObjects];
    [super dealloc];
}

@end
