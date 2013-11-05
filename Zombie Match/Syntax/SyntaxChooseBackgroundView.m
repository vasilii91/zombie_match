//
//  SyntaxChooseBackgroundView.m
//  Zookeeper Stampede
//
//  Created by Troy Development Enviroment on 2/15/13.
//
//

#import "SyntaxChooseBackgroundView.h"
#import "ViewController.h"
#import "GameCenterManager.h"
#import "SyntaxBackgroundView.h"
#import "MSSView.h"
#import "AppDelegate.h"

@implementation SyntaxChooseBackgroundView
@synthesize viewController;
@synthesize backgroundImage1;
@synthesize backgroundImage2;
@synthesize backgroundImage3;
@synthesize backgroundImage4;
@synthesize backgroundImage5, backButton;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
        if (self) {
            self.opaque = YES;
            
            // Background image for choosebackground view
            if (IS_IPHONE_5) {
                self.image = [UIImage imageNamed:@"iphone5background0.png"];
            } else{
                self.image = [UIImage imageNamed:@"choosebackgroundblank.jpg"];
            }
            
            backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *backImage = [UIImage imageNamed:@""];
            [backButton addTarget:
             ((AppDelegate *)[[UIApplication sharedApplication] delegate]).viewController
                           action:@selector(chooseBackgroundBackButton) forControlEvents:UIControlEventTouchDown];
            backButton.frame = CGRectMake(10.0, 10.0, 44.0, 42.0);
            [backButton setImage:backImage forState:UIControlStateNormal];
            [self addSubview:backButton];
            
            // Arabian Nights Button
            backgroundImage1 = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *bgImage1 = [UIImage imageNamed:@"iapbgbutton1.png"];
            [backgroundImage1 addTarget:viewController action:@selector(changeBackground1) forControlEvents:UIControlEventTouchDown];
            if (IS_IPHONE_5) {
                backgroundImage1.frame = CGRectMake(20.0, 140.0, 117.0, 128.0);
            } else{
                backgroundImage1.frame = CGRectMake(20.0, 120.0, 117.0, 128.0);
            }
            [backgroundImage1 setImage:bgImage1 forState:UIControlStateNormal];
            [self addSubview:backgroundImage1];
            
            // The Outback
            backgroundImage2 = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *bgImage2 = [UIImage imageNamed:@"iapbgbutton2.png"];
            [backgroundImage2 addTarget:viewController action:@selector(changeBackground2) forControlEvents:UIControlEventTouchDown];
            if (IS_IPHONE_5) {
                 backgroundImage2.frame = CGRectMake(180.0, 138.0, 117.0, 121.0);
            } else{
                 backgroundImage2.frame = CGRectMake(180.0, 115.0, 117.0, 121.0);
            }
            [backgroundImage2 setImage:bgImage2 forState:UIControlStateNormal];
            [self addSubview:backgroundImage2];
            
            // Grassy Knoll
            backgroundImage3 = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *bgImage3 = [UIImage imageNamed:@"iapbgbutton3.png"];
            [backgroundImage3 addTarget:viewController action:@selector(changeBackground3) forControlEvents:UIControlEventTouchDown];
            if (IS_IPHONE_5) {
                backgroundImage3.frame = CGRectMake(100.0, 250.0, 117.0, 128.0);
            } else{
                backgroundImage3.frame = CGRectMake(100.0, 230.0, 117.0, 128.0);
            }
            [backgroundImage3 setImage:bgImage3 forState:UIControlStateNormal];
            [self addSubview:backgroundImage3];
            
            // Loose in the City
            backgroundImage4 = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *bgImage4 = [UIImage imageNamed:@"iapbgbutton4.png"];
            [backgroundImage4 addTarget:viewController action:@selector(changeBackground4) forControlEvents:UIControlEventTouchDown];
            if (IS_IPHONE_5) {
                backgroundImage4.frame = CGRectMake(25.0, 365.0, 117.0, 121.0);
            } else{
                backgroundImage4.frame = CGRectMake(25.0, 345.0, 117.0, 121.0);
            }
            [backgroundImage4 setImage:bgImage4 forState:UIControlStateNormal];
            [self addSubview:backgroundImage4];
            
            // Outer Space
            backgroundImage5 = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *bgImage5 = [UIImage imageNamed:@"iapbgbutton5.png"];
            [backgroundImage5 addTarget:viewController action:@selector(changeBackground5) forControlEvents:UIControlEventTouchDown];
            if (IS_IPHONE_5) {
                backgroundImage5.frame = CGRectMake(180.0, 365.0, 117.0, 121.0);
            } else{
                backgroundImage5.frame = CGRectMake(180.0, 345.0, 117.0, 121.0);
            }
            [backgroundImage5 setImage:bgImage5 forState:UIControlStateNormal];
            [self addSubview:backgroundImage5];
            
            [self setUserInteractionEnabled:YES];
    }
    
    
    return self;
}

- (void)dealloc {
    [backgroundImage1 removeFromSuperview];
    [backgroundImage2 removeFromSuperview];
    [backgroundImage3 removeFromSuperview];
    [backgroundImage4 removeFromSuperview];
    [backgroundImage5 removeFromSuperview];
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

