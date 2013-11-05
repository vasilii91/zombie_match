//
//  SyntaxBackgroundOverlay.m
//  Zookeeper Stampede
//
//  Created by Troy Development Enviroment on 2/16/13.
//
//

#import "SyntaxBackgroundOverlay.h"
#import "SyntaxLockedBackground.h"
#import "AppDelegate.h"

@implementation SyntaxBackgroundOverlay
@synthesize viewController, loadingView, isWaiting, tapRecognizer;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.9;
    }
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapRecognizer];
    [tapRecognizer release];    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableTap)
                                                 name:@"enableTapToBuyBacks" object:nil];
    
    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IAP_ADD_BACKGROUNDS] && !isWaiting) {
//        SKProductsRequest *request= [[SKProductsRequest alloc]
//                                     initWithProductIdentifiers: [NSSet setWithObject: IAP_ADD_BACKGROUNDS]];
//        [request start];
        [tapRecognizer setEnabled:NO];
        [((AppDelegate *)[[UIApplication sharedApplication] delegate]) purchase:IAP_ADD_BACKGROUNDS];
    }
}

- (void)enableTap {
    [tapRecognizer setEnabled:YES];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
