//
//  ByteManager.m
//  Syntax
//
//  Created by Seby Moisei on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ByteManager.h"
#import "ViewController.h"
#import "AppDelegate.h"

@implementation ByteManager

@synthesize bytes;
@synthesize wildcards;
@synthesize rectifiers;
@synthesize prompts;

@synthesize request;
@synthesize allIAP;

@synthesize IAPView;

- (id)init {
	if ((self = [super init])) {
        userDefaults = [[NSUserDefaults standardUserDefaults] retain];
        bytes = [userDefaults integerForKey:@"bytes"];
        wildcards = [userDefaults integerForKey:@"wildcards"];
        rectifiers = [userDefaults integerForKey: @"rectifiers"];
        prompts = [userDefaults integerForKey:@"prompts"];
        selectedIAP = -1;
        
    }
	return self;
}

- (void)addBytes:(int)noOfBytes {
    bytes += noOfBytes;
    [userDefaults setInteger:bytes forKey:@"bytes"];
    
}

- (void)spendBytes:(int)noOfBytes {
    bytes -= noOfBytes;
    [userDefaults setInteger:bytes forKey:@"bytes"];
}

- (BOOL)getPack:(int)thisPack {
    BOOL canGet = YES;
    
    NSArray *packCosts = [[NSArray alloc] initWithObjects:
                          [NSNumber numberWithInt:250],
                          [NSNumber numberWithInt:500],
                          [NSNumber numberWithInt:500],
                          [NSNumber numberWithInt:1000],
                          [NSNumber numberWithInt:1000],
                          [NSNumber numberWithInt:1500], nil];
    
    if ([[packCosts objectAtIndex:thisPack] intValue] <= bytes) {
        [self spendBytes:[[packCosts objectAtIndex:thisPack] intValue]];
        switch (thisPack) {
            case 0:
                prompts += 5;
                [userDefaults setInteger:prompts forKey:@"prompts"];
                break;
            case 1:
                prompts += 10;
                [userDefaults setInteger:prompts forKey:@"prompts"];
                break;
            case 2:
                wildcards += 5;
                [userDefaults setInteger:wildcards forKey:@"wildcards"];
                break;
            case 3:
                wildcards += 10;
                [userDefaults setInteger:wildcards forKey:@"wildcards"];
                break;
            case 4:
                rectifiers += 5;
                [userDefaults setInteger:rectifiers forKey:@"rectifiers"];
                break;
            case 5:
                rectifiers += 10;
                [userDefaults setInteger:rectifiers forKey:@"rectifiers"];
                break;
            default:
                break;
        }
    }
    else {
        canGet = NO;
    }
    [packCosts release];
    return canGet;
}

- (BOOL)getReshuffle:(int)cost {
    BOOL canGet = YES;    
    if (cost <= bytes)
        [self spendBytes:cost];
    else canGet = NO;
    
    return canGet;
}

// This is one of the naming conventions
- (void)usePackItem:(NSString *)thisItem andUpdateLabel:(SyntaxLabel *)thisLabel {
    if ([thisItem isEqualToString:@"wildcard"]) {
        wildcards--;
        [userDefaults setInteger:wildcards forKey:@"wildcards"];
        if (IS_IPHONE_5) {
            [thisLabel animUpdateWithText:[NSString stringWithFormat:@"x%d", wildcards]];
        }else{
            [thisLabel animUpdateWithText:[NSString stringWithFormat:@"x%d", wildcards]];
        }
    }
    else if ([thisItem isEqualToString:@"rectify"]) {
        rectifiers--;
        [userDefaults setInteger:rectifiers forKey:@"rectifiers"];
        if (IS_IPHONE_5) {
             [thisLabel animUpdateWithText:[NSString stringWithFormat:@"x%d", rectifiers]];
        }else{
            [thisLabel animUpdateWithText:[NSString stringWithFormat:@"x%d", rectifiers]];
        }
    }
    else if ([thisItem isEqualToString:@"prompt"]) {
        prompts--;
        [userDefaults setInteger:prompts forKey:@"prompts"];
        if (IS_IPHONE_5) {
            [thisLabel animUpdateWithText:[NSString stringWithFormat:@"x%d", prompts]];
        }else{
        [thisLabel animUpdateWithText:[NSString stringWithFormat:@"x%d", prompts]];
        }
    }
}

- (void)buyIAP:(int)thisIAP fromIAPView:(SyntaxIAPView *)thisView {        
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    switch (thisIAP) {
        case 0:
            [appDelegate purchase:IAP_1000_BYTES_PACK];
            break;
        case 1:
            [appDelegate purchase:IAP_3000_BYTES_PACK];
            break;
        case 2:
            [appDelegate purchase:IAP_7500_BYTES_PACK];
            break;
        case 3:
            [appDelegate purchase:IAP_20000_BYTES_PACK];
            break;
        case 4:
            [appDelegate purchase:IAP_50000_BYTES_PACK];
            break;                
        default:
            break;
    }
}

//- (void)provideContent:(NSString *)productIdentifier {
//    if ([productIdentifier isEqualToString:IAP_1000_BYTES_PACK]) {
//        [self addBytes:1000];
//    }
//    else if ([productIdentifier isEqualToString:IAP_3000_BYTES_PACK]) {
//        [self addBytes:3000];
//    }
//    else if ([productIdentifier isEqualToString:IAP_7500_BYTES_PACK]) {
//        [self addBytes:7500];
//    }
//    else if ([productIdentifier isEqualToString:IAP_20000_BYTES_PACK]) {
//        [self addBytes:20000];
//    }
//    else if ([productIdentifier isEqualToString:IAP_50000_BYTES_PACK]) {
//        [self addBytes:50000];
//    }
//    [IAPView.viewController.soundController playSound:@"IAP"];
//    [IAPView backToMotherView];
//    self.IAPView = nil;    
//}

- (void)dealloc {
    [super dealloc];
}

#pragma SKProduct

- (void)requestProductDataFromIAPView:(SyntaxIAPView *)thisView {
    self.IAPView = thisView;
    NSSet *allIAPIdentifiers = [NSSet setWithObjects:
                                IAP_1000_BYTES_PACK,
                                IAP_3000_BYTES_PACK
                                IAP_7500_BYTES_PACK
                                IAP_20000_BYTES_PACK
                                IAP_50000_BYTES_PACK,
                                nil];
    self.request = [[SKProductsRequest alloc] initWithProductIdentifiers:allIAPIdentifiers];
    request.delegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).observer;
    [request start];
    NSLog(@"requesting products...");
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"product response received...");
    self.allIAP = response.products;
    self.request = nil;
    [IAPView showIAP];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    selectedIAP = -1;
    [IAPView disconnect];
    self.IAPView = nil;
}

#pragma SKPayment

//- (void)buyProductIdentifier:(NSString *)productIdentifier {
//    SKPayment *payment = [SKPayment paymentWithProductIdentifier:productIdentifier];
//    [[SKPaymentQueue defaultQueue] addPayment:payment];    
//}
//
//- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
//    for (SKPaymentTransaction *transaction in transactions) {
//        switch (transaction.transactionState) {
//            case SKPaymentTransactionStatePurchased:
//                [self completeTransaction:transaction];
//                break;
//            case SKPaymentTransactionStateFailed:
//                [self failedTransaction:transaction];
//                break;
//            default:
//                [loadingView dismissWithClickedButtonIndex:0 animated:NO];
//                break;
//        }
//    }    
//}
//
//- (void)completeTransaction:(SKPaymentTransaction *)transaction {
//	[loadingView dismissWithClickedButtonIndex:0 animated:NO];
//    NSLog(@"transaction complete...");
//    [self provideContent:transaction.payment.productIdentifier];
//    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//}
//
//- (void)failedTransaction:(SKPaymentTransaction *)transaction {
//	[loadingView dismissWithClickedButtonIndex:0 animated:NO];
//    NSLog(@"transaction failed...");
//    // show error;
//    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//}

@end
