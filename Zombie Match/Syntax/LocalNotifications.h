//
//  LocalNotifications.h
//  Zookeeper Stampede
//
//  Created by Troy Development Enviroment on 2/15/13.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface LocalNotifications : NSObject <UIAlertViewDelegate> {
    ViewController *viewController;
}

@property (nonatomic, strong) NSMutableArray *jokesArray;

- (id)initWithViewController:(ViewController *)controller;
- (void)loadNotificationsJokes;
- (NSString*)randomJoke;
- (void)scheduleNotificationWithTimeInterval: (NSTimeInterval)timeInterval text: (NSString*)text;
- (void)scheduleNotifications;

@end
