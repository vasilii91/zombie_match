//
//  MyStoreObserver.h
//  LittleFish
//
//  Created by Alexander Rudenko on 12/2/09.
//  Copyright 2009 r3apps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol StoreObserverProtocol <NSObject>
	-(void)transactionDidFinish:(NSString*)transactionIdentifier;
	-(void)transactionDidError:(NSError*)error;
@end


@interface StoreObserver : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate> 
{
	id <StoreObserverProtocol> delegate;		
    
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
}

@property (nonatomic, assign) id <StoreObserverProtocol> delegate;

- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;

- (void)requestProductData;
@end


@interface SKProduct (LocalizedPrice)

@property (nonatomic, readonly) NSString *localizedPrice;

@end 