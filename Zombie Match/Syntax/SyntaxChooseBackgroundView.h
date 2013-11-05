//
//  SyntaxChooseBackgroundView.h
//  Zookeeper Stampede
//
//  Created by Troy Development Enviroment on 2/15/13.
//
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "SyntaxLabel.h"
#import "MSSView.h"

@interface SyntaxChooseBackgroundView : UIImageView 
{
    UIButton *backgroundImage1;
    UIButton *backgroundImage2;
    UIButton *backgroundImage3;
    UIButton *backgroundImage4;
    UIButton *backgroundImage5;
    UIButton *backButton;
}
@property (nonatomic, retain) ViewController *viewController;
@property (retain, nonatomic) UIButton *backButton;
@property (retain, nonatomic) UIButton *backgroundImage1;
@property (retain, nonatomic) UIButton *backgroundImage2;
@property (retain, nonatomic) UIButton *backgroundImage3;
@property (retain, nonatomic) UIButton *backgroundImage4;
@property (retain, nonatomic) UIButton *backgroundImage5;


@end
