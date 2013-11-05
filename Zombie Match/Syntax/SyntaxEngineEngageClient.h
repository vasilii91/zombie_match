//
//  SyntaxEngineEngageClient.h
//  Syntax
//
//  Created by Seby Moisei on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyntaxSymbol.h"
#import "ViewController.h"
#import "SymbolManager.h"
#import "SyntaxEngagePacket.h"

@interface SyntaxEngineEngageClient : UIView {
    BOOL isVisible;
    ViewController *viewController;
    SymbolManager *symbolManager;
    NSMutableArray *gameGrid;
    NSMutableArray *symbolsToRemove;
    NSMutableArray *symbolsToMove;
    NSMutableArray *packetQueue;
    BOOL queueInProgress;
}

@property (nonatomic, retain) ViewController *viewController;
@property (nonatomic, retain) NSMutableArray *gameGrid;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller;

- (void)populateGameFieldFromPacket:(NSData *)thisPacket;
- (void)swapSymbolsFromPacket:(NSData *)thisPacket;
- (void)eraseSymbolsFromPacket:(NSData *)thisPacket;
- (void)checkIfAllSymbolsRepositioned;

- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex;
- (void)glitch;
- (void)shockWaveFromCenter:(CGPoint)thisCenter;
- (void)clearGame;

- (void)addPacketToQueue:(NSData *)thisPacket;
- (void)checkQueue;
- (void)processPacket:(NSData *)thisPacket;

@end