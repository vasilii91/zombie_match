//
//  SyntaxEngineEngageClient.m
//  Syntax
//
//  Created by Seby Moisei on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SyntaxEngineEngageClient.h"
#import "SyntaxEngageView.h"

@implementation SyntaxEngineEngageClient

@synthesize viewController;
@synthesize gameGrid;

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewController = controller;
        symbolManager = [viewController.symbolManager retain];
        isVisible = NO;
        self.userInteractionEnabled = NO;
        self.clipsToBounds = YES;
               
        gameGrid = [[NSMutableArray alloc] init];
        for (int i = 0; i < 6; i++) [gameGrid addObject:[NSMutableArray array]];
        
        symbolsToRemove = [[NSMutableArray alloc] init];
        symbolsToMove = [[NSMutableArray alloc] init];
        
        packetQueue = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
    }
    else isVisible = NO;
}

#pragma GRID MANAGEMENT //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (void)populateGameFieldFromPacket:(NSData *)thisPacket {
    queueInProgress = YES;
    PacketInit *packet = (PacketInit *)[thisPacket bytes];
    
    for (int i = 0; i < 6; i++) {
        [[gameGrid objectAtIndex:i] removeAllObjects];
        for (int j = 0; j < 6; j++) {
            SyntaxSymbol *symbol = [symbolManager symbolWithType:packet->gameGrid[i][j]];
            symbol.isIndex = CGPointMake(i, j);
            symbol.center = [self CGPointFromIndex:symbol.isIndex];
            [[gameGrid objectAtIndex:i] addObject:symbol];
            symbol.alpha = 0.001;
            [self addSubview:symbol];         
        }      
    }
    [packetQueue removeObject:thisPacket];
    queueInProgress = NO;
    [self glitch];
    [self checkQueue];
}

- (void)swapSymbolsFromPacket:(NSData *)thisPacket {
    queueInProgress = YES;
    PacketSwap *packet = (PacketSwap *)[thisPacket bytes];
    
    SyntaxSymbol *firstSymbol = [[[gameGrid objectAtIndex:packet->symbol1.x] objectAtIndex:packet->symbol1.y] retain];
    SyntaxSymbol *secondSymbol = [[[gameGrid objectAtIndex:packet->symbol2.x] objectAtIndex:packet->symbol2.y] retain];
    
    NSMutableArray *firstSymbolRow = [gameGrid objectAtIndex:firstSymbol.isIndex.x];
    NSMutableArray *secondSymbolRow = [gameGrid objectAtIndex:secondSymbol.isIndex.x];
    [firstSymbolRow replaceObjectAtIndex:firstSymbol.isIndex.y withObject:secondSymbol];
    [secondSymbolRow replaceObjectAtIndex:secondSymbol.isIndex.y withObject:firstSymbol];
    
    CGPoint temp = firstSymbol.isIndex;
    firstSymbol.isIndex = secondSymbol.isIndex;
    secondSymbol.isIndex = temp;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         firstSymbol.center = [self CGPointFromIndex:firstSymbol.isIndex];
                         firstSymbol.alpha = 1;
                         secondSymbol.center = [self CGPointFromIndex:secondSymbol.isIndex];
                         secondSymbol.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [firstSymbol release];
                         [secondSymbol release];                         
                         [packetQueue removeObject:thisPacket];
                         queueInProgress = NO;
                         [self checkQueue];
                     }];  
}

- (void)eraseSymbolsFromPacket:(NSData *)thisPacket {
    queueInProgress = YES;    
    PacketErase *packet = (PacketErase *)[thisPacket bytes];
     
    if (packet->shockwaveCenter.x > -1) [self shockWaveFromCenter:CGPointMake(packet->shockwaveCenter.x, packet->shockwaveCenter.y)];
    
    for (int i = 0; i < packet->areSymbolsToTurnExplosive; i++) {
        SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:packet->symbolsToTurnExplosive[i].x] objectAtIndex:packet->symbolsToTurnExplosive[i].y];
        [symbolManager turnToExplosiveSymbol:thisSymbol];
    }    
    for (int i = 0; i < packet->areSymbolsToTurnToSuper; i++) {
        SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:packet->symbolsToTurnToSuper[i].x] objectAtIndex:packet->symbolsToTurnToSuper[i].y];
        [symbolManager turnToSuperSymbol:thisSymbol];
    }    
    for (int i = 0; i < packet->areSymbolsToExplode; i++) {
        NSLog(@"%d-%d",packet->symbolsToExplode[i].x, packet->symbolsToExplode[i].y);
        SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:packet->symbolsToExplode[i].x] objectAtIndex:packet->symbolsToExplode[i].y];
        thisSymbol.isToExplode = YES;
        [symbolsToRemove addObject:thisSymbol];
    }
    for (int i = 0; i < packet->areSymbolsCornersForLShape; i++) {
        SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:packet->symbolsCornersForLShape[i].x] objectAtIndex:packet->symbolsCornersForLShape[i].y];
        thisSymbol.isLShapeCorner = YES;
        [symbolsToRemove addObject:thisSymbol];
    }
    for (int i = 0; i < packet->areSymbolsToRemove; i++) {
        SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:packet->symbolsToRemove[i].x] objectAtIndex:packet->symbolsToRemove[i].y];
        [symbolsToRemove addObject:thisSymbol];
    }
    
    for (SyntaxSymbol *thisSymbol in symbolsToRemove) {
        if (thisSymbol.isToExplode) [symbolManager animExplodeSymbol:thisSymbol WithDelay:(float) ((arc4random() % 5) / 10.0)];
        else if (thisSymbol.isLShapeCorner ) [symbolManager animLShapeOnSymbol:thisSymbol andView:self];
        else [symbolManager animHideSymbol:thisSymbol WithDelay:0];
        [[gameGrid objectAtIndex:thisSymbol.isIndex.x] removeObject:thisSymbol]; 
    } 
    [symbolsToRemove removeAllObjects];

    //////////////////////
    
    int k = 0;
    for (int i = 0; i < 6; i++) {
        int m = [[gameGrid objectAtIndex:i] count];        
        if (m < 6) {
            for (int j = 0; j < 6 - m; j++) {
                SyntaxSymbol *newSymbol = [symbolManager symbolWithType:packet->symbolsToAdd[k]];
                newSymbol.center = [self CGPointFromIndex:CGPointMake(i, 6+j)];
                newSymbol.isIndex = CGPointMake(i, 6+j);
                [self addSubview:newSymbol];
                [[gameGrid objectAtIndex:i] addObject:newSymbol];
                k++;
            }
        }
    }
         
    ////////////
    
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 6; j++) {
            SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (!(thisSymbol.isIndex.y == j)) {
                thisSymbol.dropSize = thisSymbol.isIndex.y - j;
                thisSymbol.isIndex = CGPointMake(i, j);
                [symbolsToMove addObject:thisSymbol];            
            }            
        }
    }
    
    viewController.statsManager.player2Score += packet->pointsToAdd;
    [viewController.engageView updatePlayer2Score];   
       
    int l = 0;
    float delay;
    float time;
    BOOL didFindSpot;
    for (int i = 0; i < 6; i++) {
        k = 0;
        didFindSpot = NO;
        for (int j = 0; j < 6; j++) {
            SyntaxSymbol *thisSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if ([symbolsToMove containsObject:thisSymbol]) {
                if (!didFindSpot) l++;
                didFindSpot = YES;
                time = sqrtf(0.05 * thisSymbol.dropSize);
                delay = 0.15 + k * 0.1 + l * 0.05;
                [UIView animateWithDuration:time
                                      delay:delay
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     thisSymbol.center = [self CGPointFromIndex:thisSymbol.isIndex];
                                 }
                                 completion:^(BOOL finished) {
                                     [symbolsToMove removeObject:thisSymbol];
                                     [self checkIfAllSymbolsRepositioned];
                                 }];                
                k++;
            }
        }
    }
}

- (void)checkIfAllSymbolsRepositioned {
    if ([symbolsToMove count] == 0) {
        [packetQueue removeObjectAtIndex:0];
        queueInProgress = NO;
        [self checkQueue];        
    }
}


#pragma ANIMATIONS AND OTHERS //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (CGPoint)CGPointFromIndex:(CGPoint)thisIndex {
    return CGPointMake(18.5 + (thisIndex.x * 37), 222 - (18.5 + (thisIndex.y * 37)));
}

- (void)glitch {
    SyntaxSymbol *symbolToGlitch;
    float delay;
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 6; j++) {
            symbolToGlitch = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            delay = sqrtf(i*i + j*j) / 15;
            [symbolManager animGlitchSymbol:symbolToGlitch withDelay:delay];
        }      
    }    
}

- (void)shockWaveFromCenter:(CGPoint)thisCenter {
    SyntaxSymbol *symbolToGlitch;
    float delay;
    float m = thisCenter.x;
    float n = thisCenter.y;
    
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 6; j++) {
            symbolToGlitch = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (![symbolsToRemove containsObject:symbolToGlitch]) {
                delay = sqrtf((i - m)*(i - m) + (j - n)*(j - n)) / 15;
                [symbolManager animGlitchSymbol:symbolToGlitch withDelay:delay];
            }            
        }      
    }        
}

- (void)clearGame {
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 6; j++) {
            SyntaxSymbol *symbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            [symbolManager animHideSymbol:symbol WithDelay:(float) (arc4random() % 100 / 100.0)];
        }
    }
    [packetQueue removeAllObjects];
}

#pragma MULTIPLAYER //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (void)addPacketToQueue:(NSData *)thisPacket {
    [packetQueue addObject:thisPacket];
    if ([packetQueue count] == 1) [self checkQueue];
}

- (void)checkQueue {
    if (!queueInProgress & isVisible) {
        if ([packetQueue count] > 0) [self processPacket:[packetQueue objectAtIndex:0]];        
    }    
}

- (void)processPacket:(NSData *)thisPacket {
    PacketType *packet = (PacketType *)[thisPacket bytes];
    switch (packet->isPacketType) {
        case kPacketInit:
            [self populateGameFieldFromPacket:thisPacket];
            break;
        case kPacketSwap:
            [self swapSymbolsFromPacket:thisPacket];
            break;
        case kPacketErase:
            [self eraseSymbolsFromPacket:thisPacket];
            break;
        case kPacketEndGame:
            [self clearGame];
            break;
        default:
            break;
    }
}

- (void)dealloc {
    [viewController release];
    [symbolManager release];
    [packetQueue removeAllObjects]; [packetQueue release];
    [symbolsToRemove removeAllObjects]; [symbolsToRemove release];
    [symbolsToMove removeAllObjects]; [symbolsToMove release];
    for (NSMutableArray *col in gameGrid) {
        for (SyntaxSymbol *symbol in col) {
            [symbolManager animHideSymbol:symbol WithDelay:0];
        }
        [col removeAllObjects];
    }
    [gameGrid removeAllObjects]; [gameGrid release];
    [super dealloc];
}
 

@end