//
//  SyntaxSymbol.h
//  Syntax
//
//  Created by Seby Moisei on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyntaxSymbol : UIView {
    CGRect normalFrame;
    UIImageView *symbolImage;
    UIImageView *symbolImageGlow;
    UIImageView *symbolAnimation;
    UIImageView *symbolSelectionBox;
    int isOfType;
    BOOL isVisible;
    BOOL isSelected;
    BOOL isExplosive;
    BOOL isShifter;
    BOOL isKeepable;
    BOOL isToExplode;
    BOOL isLShapeCorner;
    BOOL isSuperEliminated;
    CGPoint isIndex;
    int dropSize;
}

@property (nonatomic, retain) UIImageView *symbolImage;
@property (nonatomic, retain) UIImageView *symbolImageGlow;
@property (nonatomic, retain) UIImageView *symbolAnimation;
@property (nonatomic, retain) UIImageView *symbolSelectionBox;

@property (nonatomic) int isOfType;
@property (nonatomic) BOOL isVisible;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isExplosive;
@property (nonatomic) BOOL isShifter;
@property (nonatomic) BOOL isKeepable;
@property (nonatomic) BOOL isToExplode;
@property (nonatomic) BOOL isLShapeCorner;
@property (nonatomic) BOOL isSuperEliminated;
@property (nonatomic) CGPoint isIndex;
@property (nonatomic) int dropSize;

@end
