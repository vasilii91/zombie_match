//
//  InfoSlide1.m
//  Syntax
//
//  Created by Seby Moisei on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoSlide1.h"
#import "SymbolManager.h"

@implementation InfoSlide1

@synthesize canRelease;

- (id)initSlide {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 384) andViewController:nil];
    if (self) {
        canRelease = NO;
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        title = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        title.text = @"3 symbol match";
        title.center = CGPointMake(160, 60);
        [title styleWithSize:25];
        [self addSubview:title];
        
        slidetext = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        slidetext.text = @"Make a vertical or horizontal line with 3 matching zombies to send them back to the zoo.";
        slidetext.center = CGPointMake(160, 150);
        [slidetext styleWithSize:20];
        slidetext.numberOfLines = 0;
        [self addSubview:slidetext];
        
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
    [symbolManager shiftSymbol:thisSymbol toType:6];
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
    [symbolManager selectSymbol:symbolA];
    if (!canRelease) [self performSelector:@selector(step2) withObject:nil afterDelay:0.3];
    else [self releaseSymbols];
}

- (void)step2 {
    [symbolManager deselectSymbol:symbolA];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                     animations:^{
                         symbolA.center = [self CGPointFromIndex:CGPointMake(2, 1)];
                         symbolB.center = [self CGPointFromIndex:CGPointMake(2, 0)];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    if (!canRelease) [self performSelector:@selector(step3) withObject:nil afterDelay:1];
    else [self releaseSymbols];                 
}

- (void)step3 {
    for (SyntaxSymbol *thisSymbol in allSymbols) {
        if (thisSymbol.isOfType == 3) {
            [thisSymbol retain];
            [symbolManager animHideSymbol:thisSymbol WithDelay:0];
        }
    }
    if (!canRelease) [self performSelector:@selector(releaseSymbols) withObject:nil afterDelay:1];
    else [self releaseSymbols];
}

- (void)releaseSymbols {
    for (SyntaxSymbol *thisSymbol in allSymbols) {
        [thisSymbol removeFromSuperview];
        [thisSymbol release];
    }
    [allSymbols removeAllObjects];
    if (!canRelease) [self initSymbols];
    else {
        [self removeFromSuperview];
        [self release];
    }
}

- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex {
    return CGPointMake(120 + (thisIndex.x * 40), 384 - (80 + (thisIndex.y * 40)));
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
