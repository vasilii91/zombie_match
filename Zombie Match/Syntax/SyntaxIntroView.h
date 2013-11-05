//
//  SyntaxIntroView.h
//  Syntax
//
//  Created by Seby Moisei on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"

@interface SyntaxIntroView : MSSView {
    UIImageView *background;
    UIImageView *logo;
    BOOL readyToGo;
}

- (void)glitch;
- (void)endTimer;

@end
