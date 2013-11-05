//
//  SyntaxInfoPopUp.m
//  Syntax
//
//  Created by Seby Moisei on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyntaxInfoPopUp.h"
#import "ViewController.h"

@implementation SyntaxInfoPopUp

- (id)initForSymbolWithIndex:(CGPoint)thisIndex andSpecialType:(int)thisType andSet:(NSMutableSet *)thisSet{
    self = [super initWithFrame:CGRectMake(0, 0, 154.5, 105.5) andViewController:nil];
    if (self) {
        /*
         0 - wildcard;
         1 - shifter;
         2 - corrupted;
         3 - hidden;
         
         */
        
        NSArray *allTitles = [[NSArray alloc] initWithObjects:
                              @"Chameleon:\n\n\n\n\n\n\n",
                              @"Ninja Critter:\n\n\n",
                              @"Platypus:\n\n\n",
                              @"In the Bushes:\n\n\n", nil];
        NSArray *allDescriptions = [[NSArray alloc] initWithObjects:
                                    @"\nTap the symbol then tap any animal to change the Chameleon into that animal.",
                                    @"\nThis sneaky symbol changes to a new animal every time you make a move.",
                                    @"\nThis Platypus is deranged! Get rid of him with the Magic Net or Platypus Trap!",
                                    @"\nTap to see what animal is hiding. But watch out for the Deranged Platypus!",nil];
        
        self.alpha = 0;
        isRemoving = NO;
        popUpSet = [thisSet retain];
        background = [[self serveSubviewNamed:@"infoPopUp" withCenter:CGPointMake(77.25, 52.75) touchable:NO] retain];
        [self addSubview:background];
        title = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 126, 75)];
        title.center = CGPointMake(83, 43);
        title.text = [allTitles objectAtIndex:thisType];
        title.numberOfLines = 0;
        [title styleWithSize:17];
        title.textColor = [UIColor whiteColor];
        title.layer.shadowColor = [[UIColor colorWithRed:0.949 green:0.835 blue:0.533 alpha:1] CGColor];
        [self addSubview:title];
        description = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 126, 75)];
        description.center = CGPointMake(83, 47);
        description.text = [allDescriptions objectAtIndex:thisType];
        description.numberOfLines = 0;
        [description styleWithSize:13];
        [self addSubview:description];
        if (thisIndex.x < 4) {
            self.center = CGPointMake(110 + (thisIndex.x * 40), 390 - (20 + (thisIndex.y * 40)));
        }
        else {
            self.center = CGPointMake(-70 + (thisIndex.x * 40), 390 - (20 + (thisIndex.y * 40)));
            background.transform = CGAffineTransformMakeRotation(M_PI);
            title.center = CGPointMake(70, 52.5);
            description.center = CGPointMake(70, 52.5);
        }
        [allTitles release];
        [allDescriptions release];
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:self withAction:^{}];
    }
    else isVisible = NO;
}

- (void)removePopUp {
    [self fadeOutView:self withAction:^{
        [popUpSet removeObject:self];
        [self removeSubView:self];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!isRemoving) {
        isRemoving = YES;
        [self removePopUp];
    }
}

- (void)dealloc {
    [self removeSubView:background];
    [self removeSubView:title];
    [self removeSubView:description];
    [popUpSet release];
    [super dealloc];
}


@end
