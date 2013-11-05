//
//  SyntaxBackgroundOverlay.h
//  Zookeeper Stampede
//
//  Created by Troy Development Enviroment on 2/16/13.
//
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "ViewController.h"

@interface SyntaxBackgroundOverlay : UIView <UIGestureRecognizerDelegate>
{
    ViewController *viewController;
	UIAlertView				*loadingView;
    BOOL isWaiting;
    UITapGestureRecognizer* tapRecognizer;
}

@property (nonatomic, retain) ViewController *viewController;
@property (nonatomic, retain) UIAlertView *loadingView;
@property (nonatomic, retain) UITapGestureRecognizer* tapRecognizer;
@property BOOL isWaiting;




@end
