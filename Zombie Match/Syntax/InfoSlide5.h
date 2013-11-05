//
//  InfoSlide5.h
//  Syntax
//
//  Created by Seby Moisei on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSView.h"
#import "SyntaxLabel.h"

@interface InfoSlide5 : MSSView {
    SyntaxLabel *title;
    SyntaxLabel *primaryTitle;
    SyntaxLabel *actionTitle;
    SyntaxLabel *infinityTitle;
    SyntaxLabel *engageTitle;
    SyntaxLabel *primaryText;
    SyntaxLabel *actionText;
    SyntaxLabel *infinityText;
    SyntaxLabel *engageText;
    BOOL canRelease;
}

@property (nonatomic) BOOL canRelease;

- (id)initSlide;;
- (void)checkRelease;

@end

