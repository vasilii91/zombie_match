//
//  SyntaxSymbol.m
//  Syntax
//
//  Created by Seby Moisei on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SyntaxSymbol.h"

@implementation SyntaxSymbol

@synthesize symbolImage;
@synthesize symbolImageGlow;
@synthesize symbolAnimation;
@synthesize symbolSelectionBox;
@synthesize isOfType;
@synthesize isVisible;
@synthesize isSelected;
@synthesize isExplosive;
@synthesize isShifter;
@synthesize isKeepable;
@synthesize isToExplode;
@synthesize isLShapeCorner;
@synthesize isSuperEliminated;
@synthesize isIndex;
@synthesize dropSize;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        isOfType = -1;
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
    }
    else isVisible = NO;    
}

- (void)dealloc {
    if (symbolImage != nil) {
        [symbolImage removeFromSuperview];
        self.symbolImage = nil;        
    }
    if (symbolImageGlow != nil) {
        [symbolImageGlow removeFromSuperview];
        self.symbolImageGlow = nil;
    }
    if (symbolAnimation != nil) {
        [symbolAnimation removeFromSuperview];
        self.symbolAnimation = nil;        
    }
    if (symbolSelectionBox != nil) {
        [symbolSelectionBox removeFromSuperview];
        self.symbolSelectionBox = nil;       
    }
    [super dealloc];
}

@end