//
//  SyntaxLockedBackground.m
//  Zookeeper Stampede
//
//  Created by Troy Development Enviroment on 2/23/13.
//
//

#import "SyntaxLockedBackground.h"
#import "ViewController.h"
#import "SyntaxBackgroundOverlay.h"
#import "AppDelegate.h"

@implementation SyntaxLockedBackground
@synthesize viewController;
@synthesize restoreButton, backButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
        
        
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *backImage = [UIImage imageNamed:@""];
        [backButton addTarget:
         ((AppDelegate *)[[UIApplication sharedApplication] delegate]).viewController
                       action:@selector(chooseBackgroundBackButton) forControlEvents:UIControlEventTouchDown];
        backButton.frame = CGRectMake(10.0, 10.0, 44.0, 42.0);
        [backButton setImage:backImage forState:UIControlStateNormal];
        [self addSubview:backButton];
        
        // Restore Button
        restoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *restoreImage = [UIImage imageNamed:@"restore.png"];
        [restoreButton addTarget:[[UIApplication sharedApplication] delegate] action:@selector(restorePurchases)
                    forControlEvents:UIControlEventTouchDown];
        [restoreButton setImage:restoreImage forState:UIControlStateNormal];
        [self addSubview:restoreButton];
        
        if (IS_IPHONE_5) {
            restoreButton.frame = CGRectMake(260.0, 10.0, 50, 37);
        }
        else {
             restoreButton.frame = CGRectMake(260.0, 10.0, 50, 37);
        }
        [self setUserInteractionEnabled:YES];       
    }
    return self;
}

- (void)dealloc
{
    [restoreButton removeFromSuperview];
    [backButton removeFromSuperview];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
