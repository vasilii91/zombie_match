//
//  MyStoreObserver.m
//  LittleFish
//
//  Created by Alexander Rudenko on 12/2/09.
//  Copyright 2009 r3apps.com. All rights reserved.
//

#import "StoreObserver.h"
#import "GameKit/GKScore.h"
#import "AppDelegate.h"

@implementation StoreObserver
@synthesize delegate;

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    [(AppDelegate *)delegate cancelLoadingAlert];
    [[NSNotificationCenter defaultCenter] postNotification:
            [NSNotification notificationWithName:@"enableTapToBuyBacks" object:nil]];
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // Optionally, display an error here.
		NSLog(@"transaction.error: %@", [transaction.error localizedDescription]);
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	[delegate transactionDidError:transaction.error];
}

- (void)recordTransaction:(SKPaymentTransaction *)transaction 
{
	
}

- (void)provideContent:(NSString *)identifier
{
	
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction {
    int price;
    
    if ([transaction.payment.productIdentifier isEqualToString:IAP_1000_BYTES_PACK]) {
        [(AppDelegate *)delegate addBytes:1000];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"givePrizeForPurchase" object:nil];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:IAP_3000_BYTES_PACK]) {
        [(AppDelegate *)delegate addBytes:3000];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:IAP_7500_BYTES_PACK]) {
        [(AppDelegate *)delegate addBytes:7500];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:IAP_20000_BYTES_PACK]) {
        [(AppDelegate *)delegate addBytes:20000];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:IAP_50000_BYTES_PACK]) {
        [(AppDelegate *)delegate addBytes:50000];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:IAP_500_BYTES_PACK]) {
        [(AppDelegate *)delegate addBytes:500];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"givePrizeForPurchase" object:nil];
    }
    else if([transaction.payment.productIdentifier isEqualToString:IAP_ADD_BACKGROUNDS]) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:IAP_ADD_BACKGROUNDS];
        [((AppDelegate *)delegate) removeBGBuyScreens];
        [(AppDelegate *)delegate cancelLoadingAlert];
    }
    else if([transaction.payment.productIdentifier isEqualToString:IAP_FULL_VERSION]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IAP_FULL_VERSION];
        [((AppDelegate *)delegate) hideFlurryBanner];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBytes" object:nil];
   
    [self recordTransaction: transaction];
    [self provideContent: transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:price] forKey:@"price"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCounter" object:nil userInfo:dict];
    
    [delegate transactionDidFinish:transaction.payment.productIdentifier];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction {
    [self recordTransaction: transaction];
    if([transaction.originalTransaction.payment.productIdentifier isEqualToString:IAP_ADD_BACKGROUNDS]) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:IAP_ADD_BACKGROUNDS];
        [((AppDelegate *)delegate) removeBGBuyScreens];
    }
    if([transaction.originalTransaction.payment.productIdentifier isEqualToString:IAP_FULL_VERSION]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IAP_FULL_VERSION];
        [((AppDelegate *)delegate) hideFlurryBanner];
    }
    [(AppDelegate *)delegate cancelLoadingAlert];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
//    for (SKPaymentTransaction *transaction in queue.transactions)
//            [self restoreTransaction:transaction];
//    if([queue.transactions count] == 0)
//        [(AppDelegate *)delegate cancelLoadingAlert];
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    [delegate transactionDidError:error];
}

// SKProductsRequestDelegate
- (void)requestProductData {
    productsRequest = [[[SKProductsRequest alloc]
                        initWithProductIdentifiers: [NSSet setWithObjects:
                                                     IAP_ADD_BACKGROUNDS,
                                                     IAP_1000_BYTES_PACK,
                                                     IAP_500_BYTES_PACK,
                                                     IAP_3000_BYTES_PACK,
                                                     IAP_7500_BYTES_PACK,
                                                     IAP_20000_BYTES_PACK,
                                                     IAP_50000_BYTES_PACK,
                                                     IAP_FULL_VERSION,
                                                     nil]] autorelease];
    productsRequest.delegate = self;
    [productsRequest start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
//    NSArray *myProduct = response.products;
//    NSLog(@"%@",[[myProduct objectAtIndex:0] productIdentifier]);
    //Since only one product, we do not need to choose from the array. Proceed directly to payment.
    
//    SKPayment *newPayment = [SKPayment paymentWithProduct:[myProduct objectAtIndex:0]];
//    [[SKPaymentQueue defaultQueue] addPayment:newPayment];
    [((AppDelegate *)delegate) sendResponse:response];
    [request autorelease];
}
@end

@implementation SKProduct (LocalizedPrice)

- (NSString *)localizedPrice
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:self.priceLocale];
    NSString *formattedString = [numberFormatter stringFromNumber:self.price];
    [numberFormatter release];
    return formattedString;
}

@end