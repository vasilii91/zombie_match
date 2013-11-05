//
//  SymbolManager.m
//  Syntax
//
//  Created by Seby Moisei on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SymbolManager.h"

@implementation SymbolManager

@synthesize viewController;


- (id)initWithViewController:(ViewController *)controller {
    self = [super init];
    if (self) {
        self.viewController = controller;
        normalFrame = CGRectMake(0, 0, 40, 40);
        engageFrame = CGRectMake(0, 0, 37, 37);
        explosionFrame = CGRectMake(-20, -20, 80, 80);
        
        helperView = [[MSSView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andViewController:viewController];
        hiddenSymbolAnimationFrames = [[NSArray alloc] initWithObjects:
                                       [UIImage imageNamed:@"symbol10-1"],
                                       [UIImage imageNamed:@"symbol10-2"],
                                       [UIImage imageNamed:@"symbol10-3"],
                                       [UIImage imageNamed:@"symbol10-4"],nil];
        superSymbolMorphFrames = [[NSArray alloc] initWithObjects:
                                  [UIImage imageNamed:@"superSymbolMorph00"],
                                  [UIImage imageNamed:@"superSymbolMorph01"],
                                  [UIImage imageNamed:@"superSymbolMorph02"],
                                  [UIImage imageNamed:@"superSymbolMorph03"],
                                  [UIImage imageNamed:@"superSymbolMorph04"],
                                  [UIImage imageNamed:@"superSymbolMorph05"],
                                  [UIImage imageNamed:@"superSymbolMorph06"],
                                  [UIImage imageNamed:@"superSymbolMorph07"],
                                  [UIImage imageNamed:@"superSymbolMorph08"],
                                  [UIImage imageNamed:@"superSymbolMorph09"],
                                  [UIImage imageNamed:@"superSymbolMorph10"],
                                  [UIImage imageNamed:@"superSymbolMorph11"],
                                  [UIImage imageNamed:@"superSymbolMorph12"],
                                  [UIImage imageNamed:@"superSymbolMorph13"],
                                  [UIImage imageNamed:@"superSymbolMorph14"],
                                  [UIImage imageNamed:@"superSymbolMorph15"],
                                  [UIImage imageNamed:@"superSymbolMorph16"],
                                  [UIImage imageNamed:@"superSymbolMorph17"],
                                  [UIImage imageNamed:@"superSymbolMorph18"],
                                  [UIImage imageNamed:@"superSymbolMorph19"],
                                  [UIImage imageNamed:@"superSymbolMorph20"],
                                  [UIImage imageNamed:@"superSymbolMorph21"],
                                  [UIImage imageNamed:@"superSymbolMorph22"], nil];
        rectifySymbolMorphFrames = [[NSArray alloc] initWithObjects:
                                    [UIImage imageNamed:@"rectifySymbolMorph00"],
                                    [UIImage imageNamed:@"rectifySymbolMorph01"],
                                    [UIImage imageNamed:@"rectifySymbolMorph02"],
                                    [UIImage imageNamed:@"rectifySymbolMorph03"],
                                    [UIImage imageNamed:@"rectifySymbolMorph04"],
                                    [UIImage imageNamed:@"rectifySymbolMorph05"],
                                    [UIImage imageNamed:@"rectifySymbolMorph06"],
                                    [UIImage imageNamed:@"rectifySymbolMorph07"],
                                    [UIImage imageNamed:@"rectifySymbolMorph08"],
                                    [UIImage imageNamed:@"rectifySymbolMorph09"],
                                    [UIImage imageNamed:@"rectifySymbolMorph10"],
                                    [UIImage imageNamed:@"rectifySymbolMorph11"],
                                    [UIImage imageNamed:@"rectifySymbolMorph12"],
                                    [UIImage imageNamed:@"rectifySymbolMorph13"],
                                    [UIImage imageNamed:@"rectifySymbolMorph14"],
                                    [UIImage imageNamed:@"rectifySymbolMorph15"],
                                    [UIImage imageNamed:@"rectifySymbolMorph16"],
                                    [UIImage imageNamed:@"rectifySymbolMorph17"],
                                    [UIImage imageNamed:@"rectifySymbolMorph18"],
                                    [UIImage imageNamed:@"rectifySymbolMorph19"],
                                    [UIImage imageNamed:@"rectifySymbolMorph20"],
                                    [UIImage imageNamed:@"rectifySymbolMorph21"],
                                    [UIImage imageNamed:@"rectifySymbolMorph22"],
                                    [UIImage imageNamed:@"rectifySymbolMorph23"],
                                    [UIImage imageNamed:@"rectifySymbolMorph24"],
                                    [UIImage imageNamed:@"rectifySymbolMorph25"],
                                    [UIImage imageNamed:@"rectifySymbolMorph26"],
                                    [UIImage imageNamed:@"rectifySymbolMorph27"],
                                    [UIImage imageNamed:@"rectifySymbolMorph28"],
                                    [UIImage imageNamed:@"rectifySymbolMorph29"],
                                    [UIImage imageNamed:@"rectifySymbolMorph30"],
                                    [UIImage imageNamed:@"rectifySymbolMorph31"], nil];
        explodingSymbolFrames = [[NSArray alloc] initWithObjects:
                                 [UIImage imageNamed:@"explodingSymbol00"],
                                 [UIImage imageNamed:@"explodingSymbol01"],
                                 [UIImage imageNamed:@"explodingSymbol02"],
                                 [UIImage imageNamed:@"explodingSymbol03"],
                                 [UIImage imageNamed:@"explodingSymbol04"],
                                 [UIImage imageNamed:@"explodingSymbol05"],
                                 [UIImage imageNamed:@"explodingSymbol06"],
                                 [UIImage imageNamed:@"explodingSymbol07"],
                                 [UIImage imageNamed:@"explodingSymbol08"],
                                 [UIImage imageNamed:@"explodingSymbol09"],
                                 [UIImage imageNamed:@"explodingSymbol10"],
                                 [UIImage imageNamed:@"explodingSymbol11"],
                                 [UIImage imageNamed:@"explodingSymbol12"],
                                 [UIImage imageNamed:@"explodingSymbol13"],
                                 [UIImage imageNamed:@"explodingSymbol14"],
                                 [UIImage imageNamed:@"explodingSymbol15"],
                                 [UIImage imageNamed:@"explodingSymbol16"],nil];
        LShapeFrames = [[NSArray alloc] initWithObjects:
                        [UIImage imageNamed:@"beam00"],
                        [UIImage imageNamed:@"beam01"],
                        [UIImage imageNamed:@"beam02"],
                        [UIImage imageNamed:@"beam03"],
                        [UIImage imageNamed:@"beam04"],
                        [UIImage imageNamed:@"beam05"],
                        [UIImage imageNamed:@"beam06"],
                        [UIImage imageNamed:@"beam07"],
                        [UIImage imageNamed:@"beam08"],
                        [UIImage imageNamed:@"beam09"],
                        [UIImage imageNamed:@"beam10"],
                        [UIImage imageNamed:@"beam11"],
                        [UIImage imageNamed:@"beam12"],
                        [UIImage imageNamed:@"beam13"],
                        [UIImage imageNamed:@"beam14"],
                        [UIImage imageNamed:@"beam15"], nil];
    }
    return self;
}

- (void)preload {
    UIImageView *loaderView;
    for (UIImage *thisImage in hiddenSymbolAnimationFrames) {
        loaderView = [[UIImageView alloc] initWithImage:thisImage];
        loaderView.center = CGPointMake(-1000, -1000);
        [viewController.view addSubview:loaderView];
        [loaderView removeFromSuperview];
        [loaderView release];
    }
    for (UIImage *thisImage in superSymbolMorphFrames) {
        loaderView = [[UIImageView alloc] initWithImage:thisImage];
        loaderView.center = CGPointMake(-1000, -1000);
        [viewController.view addSubview:loaderView];
        [loaderView removeFromSuperview];
        [loaderView release];
    }
    for (UIImage *thisImage in rectifySymbolMorphFrames) {
        loaderView = [[UIImageView alloc] initWithImage:thisImage];
        loaderView.center = CGPointMake(-1000, -1000);
        [viewController.view addSubview:loaderView];
        [loaderView removeFromSuperview];
        [loaderView release];
    }
    for (UIImage *thisImage in explodingSymbolFrames) {
        loaderView = [[UIImageView alloc] initWithImage:thisImage];
        loaderView.center = CGPointMake(-1000, -1000);
        [viewController.view addSubview:loaderView];
        [loaderView removeFromSuperview];
        [loaderView release];
    }
    for (UIImage *thisImage in LShapeFrames) {
        loaderView = [[UIImageView alloc] initWithImage:thisImage];
        loaderView.center = CGPointMake(-1000, -1000);
        [viewController.view addSubview:loaderView];
        [loaderView removeFromSuperview];
        [loaderView release];
    }    
}


- (SyntaxSymbol *)randomSymbolWithMaxType:(int)maxTypes {
    SyntaxSymbol *newSymbol = [[SyntaxSymbol alloc] initWithFrame:normalFrame];
    
    int k = arc4random() % 4;
    int i = 0;
    int l = 0;
    
    switch (k) {
        case 0:
            l = arc4random() % 12;//1*wildcardProbability;
            if (l == 0) i = 7;
            else i = arc4random() % maxTypes;
            break;
        case 1:
            l = arc4random() % 12;//1*shifterProbability;
            if (l == 0) i = 8;
            else i = arc4random() % maxTypes;
            break;
        case 2:
            l = arc4random() % 12;// 1*corruptedProbability;
            if (l == 0) i = 9;
            else i = arc4random() % maxTypes;
            break;
        case 3:
            l = arc4random() % 12 ;//1*hiddenProbability;
            if (l == 0) i = 10;
            else i = arc4random() % maxTypes;
            break;
        default:
            break;
    }
    if (i == 7) newSymbol.isKeepable = YES;
    
    if (i < 8) {
        newSymbol.symbolImage = [[[UIImageView alloc] initWithFrame:normalFrame] autorelease];
        newSymbol.symbolImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"symbol%d", i]];
        [newSymbol addSubview:newSymbol.symbolImage];
    }        
    if (i == 8) {
        newSymbol.isShifter = YES;            
        i = arc4random() % 7;
        newSymbol.symbolImage = [[[UIImageView alloc] initWithFrame:normalFrame] autorelease];
        [newSymbol addSubview:newSymbol.symbolImage];
        [self animShifterSymbol:newSymbol];
    }        
    if (i == 9) {
        newSymbol.isKeepable = YES;
        newSymbol.symbolImage = [[[UIImageView alloc] initWithFrame:normalFrame] autorelease];
        
        newSymbol.symbolImage.image = [UIImage imageNamed:@"symbol9"];
        [newSymbol addSubview:newSymbol.symbolImage];
        [UIView animateWithDuration:0.25
                              delay:0.6
                            options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut)
                         animations:^{
                             newSymbol.symbolImage.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             [newSymbol.symbolAnimation stopAnimating];
                             [newSymbol.symbolAnimation removeFromSuperview];
                             newSymbol.symbolAnimation = nil;
                             newSymbol.symbolImageGlow = [[[UIImageView alloc] initWithFrame:newSymbol.symbolImage.frame] autorelease];
                             newSymbol.symbolImageGlow.image = [UIImage imageNamed:@"symbol9b"];
                             [newSymbol addSubview:newSymbol.symbolImageGlow];
                             [self animSuperSymbol:newSymbol];
                         }];

    }
    if (i == 10) {
        newSymbol.isKeepable = YES;
        newSymbol.symbolAnimation = [[[UIImageView alloc] initWithFrame:normalFrame] autorelease];
        newSymbol.symbolAnimation.animationImages = hiddenSymbolAnimationFrames;
        newSymbol.symbolAnimation.animationDuration = 0.5;
        newSymbol.symbolAnimation.animationRepeatCount = 0;
        [newSymbol addSubview:newSymbol.symbolAnimation];
        [newSymbol.symbolAnimation startAnimating];
    }
    
    
    newSymbol.isOfType = i;
    return newSymbol;
   }


- (SyntaxSymbol *)symbolWithType:(int)thisType {
    SyntaxSymbol *newSymbol = [[SyntaxSymbol alloc] initWithFrame:engageFrame];
    newSymbol.symbolImage = [[[UIImageView alloc] initWithFrame:engageFrame] autorelease];
    newSymbol.symbolImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"symbol%d", thisType]];
    [newSymbol addSubview:newSymbol.symbolImage];
    newSymbol.isOfType = thisType;
    return newSymbol;
}

- (void)selectSymbol:(SyntaxSymbol *)thisSymbol {
    if (!thisSymbol.isSelected) {
        thisSymbol.isSelected = YES;
        thisSymbol.symbolSelectionBox = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thisSymbol.bounds.size.width, thisSymbol.bounds.size.height)] autorelease];
        thisSymbol.symbolSelectionBox.image = [UIImage imageNamed:@"selectionBox"];
        [thisSymbol addSubview:thisSymbol.symbolSelectionBox];
    }    
}

- (void)deselectSymbol:(SyntaxSymbol *)thisSymbol {
    if (thisSymbol.isSelected) {
        thisSymbol.isSelected = NO;
        [thisSymbol.symbolSelectionBox removeFromSuperview];
        thisSymbol.symbolSelectionBox = nil;
    }    
}

- (void)turnToExplosiveSymbol:(SyntaxSymbol *)thisSymbol {
    if (thisSymbol.isShifter) {
        thisSymbol.isShifter = NO;
        thisSymbol.symbolImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"symbol%d",thisSymbol.isOfType]];
        [self turnToExplosiveSymbol:thisSymbol];            
    }
    else {
        if (!thisSymbol.isExplosive) {
            thisSymbol.isKeepable = YES;
            thisSymbol.isExplosive = YES;
            thisSymbol.symbolImageGlow = [[[UIImageView alloc] initWithFrame:thisSymbol.symbolImage.frame] autorelease];
            thisSymbol.symbolImageGlow.image = [UIImage imageNamed:[NSString stringWithFormat:@"symbol%d-glow", thisSymbol.isOfType]];
            [thisSymbol addSubview:thisSymbol.symbolImageGlow];
            [self animGlowSymbol:thisSymbol];
        }
    }
}

- (void)turnToSuperSymbol:(SyntaxSymbol *)thisSymbol {
    if (thisSymbol.isShifter) {
        thisSymbol.isShifter = NO;
        thisSymbol.symbolImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"symbol%d",thisSymbol.isOfType]];
        [self turnToSuperSymbol:thisSymbol];            
    }
    else {
        if (thisSymbol.isExplosive) {
            thisSymbol.isExplosive = NO;
            [thisSymbol.symbolImageGlow removeFromSuperview];
            thisSymbol.symbolImageGlow = nil;
            [self turnToSuperSymbol:thisSymbol];
        }
        else {
            thisSymbol.isKeepable = YES;
            thisSymbol.isOfType = 11;
            [self animShiftToSuperSymbol:thisSymbol];
        }
    }    
}

- (void)turnToWildcardSymbol:(SyntaxSymbol *)thisSymbol {
    thisSymbol.isShifter = NO;
    thisSymbol.isExplosive = NO;
    thisSymbol.isKeepable = YES;
    [self cleanSymbol:thisSymbol];
    thisSymbol.isOfType = 7;
    thisSymbol.symbolImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thisSymbol.bounds.size.width, thisSymbol.bounds.size.height)] autorelease];
    thisSymbol.symbolImage.image = [UIImage imageNamed:@"symbol7"];
    [thisSymbol addSubview:thisSymbol.symbolImage];
}

- (void)rectifyCorruptedSymbol:(SyntaxSymbol *)thisSymbol {
    thisSymbol.isKeepable = NO;
    thisSymbol.isOfType = arc4random() % 7;
    [self animRectifySymbol:thisSymbol];
}

- (void)shiftSymbol:(SyntaxSymbol *)thisSymbol toType:(int)thisType {
    thisSymbol.isOfType = thisType;
    thisSymbol.alpha = 1;
    if (!thisSymbol.isShifter) {
        thisSymbol.symbolImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"symbol%d",thisType]];
        if (thisType == 9) {
            thisSymbol.isKeepable = YES;;
            [UIView animateWithDuration:0.25
                                  delay:0.6
                                options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut)
                             animations:^{
                                 thisSymbol.symbolImage.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 [thisSymbol.symbolAnimation stopAnimating];
                                 [thisSymbol.symbolAnimation removeFromSuperview];
                                 thisSymbol.symbolAnimation = nil;
                                 thisSymbol.symbolImageGlow = [[[UIImageView alloc] initWithFrame:thisSymbol.symbolImage.frame] autorelease];
                                 thisSymbol.symbolImageGlow.image = [UIImage imageNamed:@"symbol9b"];
                                 [thisSymbol addSubview:thisSymbol.symbolImageGlow];
                                 [self animSuperSymbol:thisSymbol];
                             }];
            
        }
        if (thisType == 10) {
            thisSymbol.isKeepable = YES;
            thisSymbol.symbolAnimation = [[[UIImageView alloc] initWithFrame:normalFrame] autorelease];
            thisSymbol.symbolAnimation.animationImages = hiddenSymbolAnimationFrames;
            thisSymbol.symbolAnimation.animationDuration = 0.5;
            thisSymbol.symbolAnimation.animationRepeatCount = 0;
            [thisSymbol addSubview:thisSymbol.symbolAnimation];
            [thisSymbol.symbolAnimation startAnimating];
        }
        if (thisType == 11) {
            [UIView animateWithDuration:0.25
                                  delay:0.6
                                options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut)
                             animations:^{
                                 thisSymbol.symbolImage.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 [thisSymbol.symbolAnimation stopAnimating];
                                 [thisSymbol.symbolAnimation removeFromSuperview];
                                 thisSymbol.symbolAnimation = nil;
                                 thisSymbol.symbolImageGlow = [[[UIImageView alloc] initWithFrame:thisSymbol.symbolImage.frame] autorelease];
                                 thisSymbol.symbolImageGlow.image = [UIImage imageNamed:@"symbol11b"];
                                 [thisSymbol addSubview:thisSymbol.symbolImageGlow];
                                 [self animShiftToSuperSymbol:thisSymbol];
                                 [self animGlowSymbol:thisSymbol];
                             }];
        }
    }
    else [self animShifterSymbol:thisSymbol];
}

- (void)revealHiddenSymbol:(SyntaxSymbol *)thisSymbol {
    [self cleanSymbol:thisSymbol];
    thisSymbol.symbolImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thisSymbol.bounds.size.width, thisSymbol.bounds.size.height)] autorelease];
    [thisSymbol addSubview:thisSymbol.symbolImage];
    int k = arc4random() % 10;
    if (k < 6) [self shiftSymbol:thisSymbol toType:arc4random() % 7];
    else {
        thisSymbol.isKeepable = YES;        
        [self shiftSymbol:thisSymbol toType:9];
//        int i = 9;
//        if (i == 9) {
//            [UIView animateWithDuration:0.25
//                                  delay:0.6
//                                options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut)
//                             animations:^{
//                                 thisSymbol.symbolImage.alpha = 1;
//                             }
//                             completion:^(BOOL finished) {
//                                 [thisSymbol.symbolAnimation stopAnimating];
//                                 [thisSymbol.symbolAnimation removeFromSuperview];
//                                 thisSymbol.symbolAnimation = nil;
//                                 thisSymbol.symbolImageGlow = [[[UIImageView alloc] initWithFrame:thisSymbol.symbolImage.frame] autorelease];
//                                 thisSymbol.symbolImageGlow.image = [UIImage imageNamed:@"symbol9b"];
//                                 [thisSymbol addSubview:thisSymbol.symbolImageGlow];
//                                 [self animSuperSymbol:thisSymbol];
//                             }];

//        }
    }
}


#pragma animations/////////////////////////////////

- (void)animHideSymbol:(SyntaxSymbol *)thisSymbol WithDelay:(float)thisDelay {
    [UIView animateWithDuration:0.033333
                          delay:thisDelay
                        options:UIViewAnimationCurveLinear
                     animations:^{
                         thisSymbol.alpha = 0;                        
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.033333
                                               delay:0
                                             options:UIViewAnimationCurveLinear
                                          animations:^{
                                              thisSymbol.alpha = 1;                        
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.033333
                                                                    delay:0
                                                                  options:UIViewAnimationCurveLinear
                                                               animations:^{
                                                                   thisSymbol.alpha = 0;                        
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:0.033333
                                                                                         delay:0
                                                                                       options:UIViewAnimationCurveLinear
                                                                                    animations:^{
                                                                                        thisSymbol.alpha = 1;                        
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        [UIView animateWithDuration:0.033333                                                                                         
                                                                                                              delay:0
                                                                                                            options:UIViewAnimationCurveLinear
                                                                                                         animations:^{
                                                                                                             thisSymbol.alpha = 0;                        
                                                                                                         }
                                                                                                         completion:^(BOOL finished) {
                                                                                                             [UIView animateWithDuration:0.033333
                                                                                                                                   delay:0
                                                                                                                                 options:UIViewAnimationCurveLinear
                                                                                                                              animations:^{
                                                                                                                                  thisSymbol.alpha = 1;                        
                                                                                                                              }
                                                                                                                              completion:^(BOOL finished) {
                                                                                                                                  [UIView animateWithDuration:0.033333                                                                                         
                                                                                                                                                        delay:0
                                                                                                                                                      options:UIViewAnimationCurveLinear
                                                                                                                                                   animations:^{
                                                                                                                                                       thisSymbol.alpha = 0;                        
                                                                                                                                                   }
                                                                                                                                                   completion:^(BOOL finished) {
                                                                                                                                                       if (thisSymbol.isVisible) {
                                                                                                                                                           [thisSymbol removeFromSuperview];
                                                                                                                                                           [thisSymbol release];                                                                                                                                                           
                                                                                                                                                       } 
                                                                                                                                                   }]; 
                                                                                                                              }]; 
 
                                                                                                         }]; 
                                                                                    }]; 
                                                               }]; 
                                          }]; 
                     }];    
}

- (void)animGlowSymbol:(SyntaxSymbol *)thisSymbol {
    [UIView animateWithDuration:0.5
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                     animations:^{
                         thisSymbol.symbolImageGlow.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5
                                               delay:0
                                             options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                                          animations:^{
                                              thisSymbol.symbolImageGlow.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              if (thisSymbol.isVisible & thisSymbol.isExplosive) [self animGlowSymbol:thisSymbol]; 
                                          }]; 
                     }];
    thisSymbol.tag = 1;
}

- (void)animExplodeSymbol:(SyntaxSymbol *)thisSymbol WithDelay:(float)thisDelay {
    [self cleanSymbol:thisSymbol];
    thisSymbol.symbolAnimation = [[[UIImageView alloc] initWithFrame:CGRectMake(-40, -40, 120, 120)] autorelease];
    thisSymbol.symbolAnimation.animationImages = explodingSymbolFrames;
    thisSymbol.symbolAnimation.animationDuration = 17/30;
    thisSymbol.symbolAnimation.animationRepeatCount = 1;
    [thisSymbol addSubview:thisSymbol.symbolAnimation];
    [thisSymbol.symbolAnimation performSelector:@selector(startAnimating) withObject:nil afterDelay:thisDelay];
    [thisSymbol performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.6 + thisDelay];
    [thisSymbol release];
}

- (void)animShiftToSuperSymbol:(SyntaxSymbol *)thisSymbol {
    thisSymbol.symbolAnimation = [[[UIImageView alloc] initWithFrame:thisSymbol.symbolImage.frame] autorelease];
    thisSymbol.symbolAnimation.animationImages = superSymbolMorphFrames;
    thisSymbol.symbolAnimation.animationDuration = 1.1;
    thisSymbol.symbolAnimation.animationRepeatCount = 1;
    [thisSymbol addSubview:thisSymbol.symbolAnimation];
    [thisSymbol.symbolAnimation startAnimating];
    [UIView animateWithDuration:0.25
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         thisSymbol.symbolImage.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         thisSymbol.symbolImage.image = [UIImage imageNamed:@"symbol11"];
                         [UIView animateWithDuration:0.25
                                               delay:0.6
                                             options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut)
                                          animations:^{
                                              thisSymbol.symbolImage.alpha = 1;
                                          }
                                          completion:^(BOOL finished) {
                                              [thisSymbol.symbolAnimation stopAnimating];
                                              [thisSymbol.symbolAnimation removeFromSuperview];
                                              thisSymbol.symbolAnimation = nil;
                                              thisSymbol.symbolImageGlow = [[[UIImageView alloc] initWithFrame:thisSymbol.symbolImage.frame] autorelease];
                                              thisSymbol.symbolImageGlow.image = [UIImage imageNamed:@"symbol11b"];
                                              [thisSymbol addSubview:thisSymbol.symbolImageGlow];
                                              [self animSuperSymbol:thisSymbol];
                                          }];
                     }];    
}

- (void)animSuperSymbol:(SyntaxSymbol *)thisSymbol {
    if(!thisSymbol.isKeepable) return;
    [UIView animateWithDuration:0.1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                     animations:^{
                         thisSymbol.symbolImageGlow.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1333
                                               delay:0
                                             options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut)
                                          animations:^{
                                              thisSymbol.symbolImageGlow.alpha = 0;
                                          }
                                          completion:^(BOOL finished) {
                                              if (thisSymbol.isVisible) [self animSuperSymbol:thisSymbol]; 
                                          }]; 
                     }];
    thisSymbol.tag = 1;
}

- (void)animSuperEliminateSymbol:(SyntaxSymbol *)thisSymbol {
    thisSymbol.symbolAnimation = [[[UIImageView alloc] initWithFrame:thisSymbol.symbolImage.frame] autorelease];
    thisSymbol.symbolAnimation.animationImages = superSymbolMorphFrames;
    thisSymbol.symbolAnimation.animationDuration = 1.1;
    thisSymbol.symbolAnimation.animationRepeatCount = 1;
    [thisSymbol addSubview:thisSymbol.symbolAnimation];
    [thisSymbol.symbolAnimation startAnimating];
    [UIView animateWithDuration:1.1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         thisSymbol.symbolImage.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         thisSymbol.symbolAnimation.frame = CGRectMake(-40, -40, 120, 120);
                         thisSymbol.symbolAnimation.animationImages = explodingSymbolFrames;
                         thisSymbol.symbolAnimation.animationDuration = 0.57;
                         thisSymbol.symbolAnimation.animationRepeatCount = 1;
                         [thisSymbol.symbolAnimation startAnimating];
                         [thisSymbol performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.57];
                         [thisSymbol release];
                     }];        
}


- (void)animRectifySymbol:(SyntaxSymbol *)thisSymbol {
    thisSymbol.isKeepable = NO;
    thisSymbol.symbolAnimation = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thisSymbol.bounds.size.width, thisSymbol.bounds.size.height)] autorelease];
    thisSymbol.symbolAnimation.animationImages = rectifySymbolMorphFrames;
    thisSymbol.symbolAnimation.animationDuration = 32/20;
    thisSymbol.symbolAnimation.animationRepeatCount = 1;
    [thisSymbol addSubview:thisSymbol.symbolAnimation];
    [thisSymbol.symbolAnimation startAnimating];
    [UIView animateWithDuration:0.25
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         thisSymbol.symbolImage.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         thisSymbol.symbolImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"symbol%d", thisSymbol.isOfType]];
                         [UIView animateWithDuration:0.25
                                               delay:1.05
                                             options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut)
                                          animations:^{
                                              thisSymbol.symbolImage.alpha = 1;
                                          }
                                          completion:^(BOOL finished) {
                                              [thisSymbol.symbolAnimation stopAnimating];
                                              [thisSymbol.symbolAnimation removeFromSuperview];
                                              thisSymbol.symbolAnimation = nil;
                                          }];
                     }];        
}

- (void)animShifterSymbol:(SyntaxSymbol *)thisSymbol {
    [UIView animateWithDuration:0.25
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         thisSymbol.symbolImage.alpha = 0;                        
                     }
                     completion:^(BOOL finished) {
                         thisSymbol.symbolImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"symbol%d-shift", thisSymbol.isOfType]];
                         [UIView animateWithDuration:0.25
                                               delay:0
                                             options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut)
                                          animations:^{
                                              thisSymbol.symbolImage.alpha = 1;                        
                                          }
                                          completion:^(BOOL finished) {
                                              //
                                          }]; 
                     }];
}

- (void)animGlitchSymbol:(SyntaxSymbol *)thisSymbol withDelay:(float)thisDelay {
    [UIView animateWithDuration:0.016667
                          delay:thisDelay
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         thisSymbol.alpha = 0.01;                        
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.016667
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              thisSymbol.alpha = 1;                        
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.016667
                                                                    delay:0
                                                                  options:UIViewAnimationOptionAllowUserInteraction
                                                               animations:^{
                                                                   thisSymbol.alpha = 0.01;                        
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:0.016667
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionAllowUserInteraction
                                                                                    animations:^{
                                                                                        thisSymbol.alpha = 1;                        
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        //
                                                                                    }]; 
                                                               }]; 
                                          }]; 
                     }];    
}

- (void)animFlashSymbol:(SyntaxSymbol *)thisSymbol {
    thisSymbol.symbolSelectionBox = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thisSymbol.bounds.size.width, thisSymbol.bounds.size.height)] autorelease];
    thisSymbol.symbolSelectionBox.image = [UIImage imageNamed:@"selectionBox"];
    thisSymbol.symbolSelectionBox.alpha = 0;
    [thisSymbol addSubview:thisSymbol.symbolSelectionBox];
    
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         thisSymbol.symbolSelectionBox.alpha = 1;                     
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              thisSymbol.symbolSelectionBox.alpha = 0;                     
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.1
                                                                    delay:0
                                                                  options:UIViewAnimationOptionAllowUserInteraction
                                                               animations:^{
                                                                   thisSymbol.symbolSelectionBox.alpha = 0;                     
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [UIView animateWithDuration:0.1
                                                                                         delay:0
                                                                                       options:UIViewAnimationOptionAllowUserInteraction
                                                                                    animations:^{
                                                                                        thisSymbol.symbolSelectionBox.alpha = 1;                     
                                                                                    }
                                                                                    completion:^(BOOL finished) {
                                                                                        [UIView animateWithDuration:0.1
                                                                                                              delay:0
                                                                                                            options:UIViewAnimationOptionAllowUserInteraction
                                                                                                         animations:^{
                                                                                                             thisSymbol.symbolSelectionBox.alpha = 0;                     
                                                                                                         }
                                                                                                         completion:^(BOOL finished) {
                                                                                                             [UIView animateWithDuration:0.1
                                                                                                                                   delay:0
                                                                                                                                 options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                              animations:^{
                                                                                                                                  thisSymbol.symbolSelectionBox.alpha = 1;                     
                                                                                                                              }
                                                                                                                              completion:^(BOOL finished) {
                                                                                                                                  [UIView animateWithDuration:0.1
                                                                                                                                                        delay:0
                                                                                                                                                      options:UIViewAnimationOptionAllowUserInteraction
                                                                                                                                                   animations:^{
                                                                                                                                                       thisSymbol.symbolSelectionBox.alpha = 0;                     
                                                                                                                                                   }
                                                                                                                                                   completion:^(BOOL finished) {
                                                                                                                                                       [thisSymbol.symbolSelectionBox removeFromSuperview];
                                                                                                                                                       thisSymbol.symbolSelectionBox = nil;
                                                                                                                                                   }]; 

                                                                                                                              }]; 
                                                                                                         }]; 
                                                                                    }]; 
                                                               }]; 
                                          }]; 
                     }];    
}

- (void)animLShapeOnSymbol:(SyntaxSymbol *)thisSymbol andView:(UIView *)thisView {
    CGRect beamFrame = CGRectMake(0, 0, MAX((320 + 2 * abs(thisSymbol.center.x - 165)), (320 + 2 * abs(thisSymbol.center.y - 165))), 40);

    UIImageView *LShapeHorizontal = [[UIImageView alloc] initWithFrame:beamFrame];
    LShapeHorizontal.animationImages = LShapeFrames;
    LShapeHorizontal.animationDuration = 16/60;
    LShapeHorizontal.animationRepeatCount = 1;
    
    UIImageView *LShapeVertical = [[UIImageView alloc] initWithFrame:beamFrame];
    LShapeVertical.animationImages = LShapeFrames;
    LShapeVertical.animationDuration = 16/60;
    LShapeVertical.animationRepeatCount = 1;
    LShapeVertical.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    LShapeHorizontal.center = thisSymbol.center;
    LShapeVertical.center = thisSymbol.center;
    
    [thisView addSubview:LShapeHorizontal];
    [thisView addSubview:LShapeVertical];
    
    [LShapeHorizontal startAnimating];
    [LShapeVertical startAnimating];
    
    [[LShapeHorizontal autorelease] performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
    [[LShapeVertical autorelease] performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
    
    [self animHideSymbol:thisSymbol WithDelay:0];
}

- (void)refreshGrid:(NSMutableArray *)thisGrid {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            SyntaxSymbol *thisSymbol = [[thisGrid objectAtIndex:i] objectAtIndex:j];
            if (thisSymbol.isKeepable) {
                if (thisSymbol.isExplosive) [self animGlowSymbol:thisSymbol];
                else {
                    [self animSuperSymbol:thisSymbol];
                }
            }
        }
    }
}

- (void)cleanSymbol:(SyntaxSymbol *)thisSymbol {
    if (thisSymbol.symbolImage != nil) {
        [thisSymbol.symbolImage removeFromSuperview];
        thisSymbol.symbolImage = nil;
    }
    if (thisSymbol.symbolImageGlow != nil) {
        [thisSymbol.symbolImageGlow removeFromSuperview];
        thisSymbol.symbolImageGlow = nil;
    }
    if (thisSymbol.symbolAnimation != nil) {
        [thisSymbol.symbolAnimation stopAnimating];
        [thisSymbol.symbolAnimation removeFromSuperview];
        thisSymbol.symbolAnimation = nil;
    }
    if (thisSymbol.symbolSelectionBox != nil) {
        [thisSymbol.symbolSelectionBox removeFromSuperview];
        thisSymbol.symbolSelectionBox = nil;
    }
}

- (void)updateProbabilities {
    wildcardProbability = [viewController.valuesManager wildcardProbabilityForLevel:viewController.statsManager.currentLevel];
    shifterProbability = [viewController.valuesManager shifterProbabilityForLevel:viewController.statsManager.currentLevel];
    corruptedProbability = [viewController.valuesManager corruptedProbabilityForLevel:viewController.statsManager.currentLevel];
    hiddenProbability = [viewController.valuesManager hiddenProbabilityForLevel:viewController.statsManager.currentLevel];
}

- (void)zeroProbabilities {
    wildcardProbability = 0;
    shifterProbability = 0;
    corruptedProbability = 0;
    hiddenProbability = 0;
}

- (void)dealloc {
    [viewController release];
    [helperView release];
    [hiddenSymbolAnimationFrames release];
    [superSymbolMorphFrames release];
    [rectifySymbolMorphFrames release];
    [explodingSymbolFrames release];
    [super dealloc];
}

@end
