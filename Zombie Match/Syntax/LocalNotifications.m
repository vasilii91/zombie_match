//
//  LocalNotifications.m
//  Zookeeper Stampede
//
//  Created by Troy Development Enviroment on 2/15/13.
//
//

#import "LocalNotifications.h"

@implementation LocalNotifications

- (id)initWithViewController:(ViewController *)controller {
	if ((self = [super init])) {
        
        viewController = [controller retain];
    }
   
	return self;
}


#pragma mark - Local Notifications

- (void)loadNotificationsJokes
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"Jokes.txt"  ofType: nil];
    NSError *error = nil;
    NSString *jokesString = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
    
    if ( nil != error ) {
       
    }
    
    self.jokesArray = [NSMutableArray arrayWithArray: [jokesString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]]];
}


- (NSString*)randomJoke
{
    int randomIndex = arc4random() % [self.jokesArray count];
    NSString *joke = [self.jokesArray objectAtIndex: randomIndex];
    [self.jokesArray removeObjectAtIndex: randomIndex];
    
    return joke;
}


- (void)scheduleNotificationWithTimeInterval: (NSTimeInterval)timeInterval text: (NSString*)text
{
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    
    if ( nil == text ) {
        text = @"We've missed you!";
    }
    
    notif.fireDate = [NSDate dateWithTimeIntervalSinceNow: timeInterval];
    notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.alertBody = text;
    notif.alertAction = @"PLAY";
    notif.soundName = UILocalNotificationDefaultSoundName;
    notif.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification: notif];
}


- (void)scheduleNotifications
{
	//LOCAL NOTIFICATIONS
    
    //Cancel all previous Local Notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self loadNotificationsJokes];
    
    //Set new Local Notifications
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
        
        CGFloat oneDay = 60.0f*60.0f*24.0f;
        
        [self scheduleNotificationWithTimeInterval: oneDay text: [self randomJoke]];
        [self scheduleNotificationWithTimeInterval: oneDay * 3 text: [self randomJoke]];
        [self scheduleNotificationWithTimeInterval: oneDay * 7  text: [self randomJoke]];
        [self scheduleNotificationWithTimeInterval: oneDay * 15  text: [self randomJoke]];
        [self scheduleNotificationWithTimeInterval: oneDay * 30  text: [self randomJoke]];
    }
}


@end
