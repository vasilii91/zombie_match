//
//  SyntaxLockedBackground.h
//  Zookeeper Stampede
//
//  Created by Troy Development Enviroment on 2/23/13.
//
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SyntaxLockedBackground : UIImageView {
    ViewController *viewController;
    UIButton *restoreButton;
    UIButton *backButton;
}

@property (nonatomic, retain) ViewController *viewController;
@property (retain, nonatomic) UIButton *restoreButton;
@property (retain, nonatomic) UIButton *backButton;



@end
