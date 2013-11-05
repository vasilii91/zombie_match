//
//  ByteManager.h
//  Syntax
//
//  Created by Seby Moisei on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "SyntaxLabel.h"
#import "SyntaxIAPView.h"

@interface ByteManager : NSObject  {
    NSUserDefaults *userDefaults;
    SyntaxIAPView *IAPView;
    int bytes;
    int wildcards;
    int rectifiers;
    int prompts;
    int selectedIAP;
    
    SKProductsRequest *request;    
    NSArray *allIAP;
	UIAlertView				*loadingView;
}

@property (nonatomic) int bytes;
@property (nonatomic) int wildcards;
@property (nonatomic) int rectifiers;
@property (nonatomic) int prompts;
@property (nonatomic, retain) SKProductsRequest *request;
@property (nonatomic, retain) NSArray *allIAP;
@property (nonatomic, retain) SyntaxIAPView *IAPView;

- (void)addBytes:(int)noOfBytes;
- (void)spendBytes:(int)noOfBytes;
- (void)usePackItem:(NSString *)thisItem andUpdateLabel:(SyntaxLabel *)thisLabel;
- (BOOL)getPack:(int)thisPack;
- (void)buyIAP:(int)thisIAP fromIAPView:(SyntaxIAPView *)thisView;
- (BOOL)getReshuffle:(int)cost;

- (void)requestProductDataFromIAPView:(SyntaxIAPView *)thisView;
//- (void)provideContent:(NSString *)productIdentifier;
//- (void)buyProductIdentifier:(NSString *)productIdentifier;
//- (void)completeTransaction:(SKPaymentTransaction *)transaction;
//- (void)failedTransaction:(SKPaymentTransaction *)transaction;


@end