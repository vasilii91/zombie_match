//
//  SyntaxEngineEngageServer.m
//  Syntax
//
//  Created by Seby Moisei on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SyntaxEngineEngageServer.h"
#import "GameCenterManager.h"
#import "SyntaxEngageView.h"
#import "SyntaxEngineEngageClient.h"

@implementation SyntaxEngineEngageServer

@synthesize viewController;
@synthesize gameGrid;


- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame];
    if (self) {
        self.viewController = controller;
        symbolManager = [viewController.symbolManager retain];
        isVisible = NO;
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        isShockwave = NO;
        isCascading = NO;
        isDoubleMatch = NO;
        [self clearPoints];
        noOfCascadingMatches = 0;
        shockwaveCentre = CGPointMake(-1, -1);
        
        gameGrid = [[NSMutableArray alloc] init];
        for (int i = 0; i < 6; i++) [gameGrid addObject:[NSMutableArray array]];
        
        symbolsToRemove = [[NSMutableSet alloc] init];
        symbolsToMove = [[NSMutableSet alloc] init];
        symbolsToSkip = [[NSMutableSet alloc] init];
        firstTouchedSymbol = nil;
    }
    return self;
}

#pragma GRID MANAGEMENT //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (void)populateGameField {
    isGameOver = NO;
    didClear = NO;
    PacketInit packet;
    packet.packetType.isPacketType = kPacketInit;
    
    for (int i = 0; i < 6; i++) {
        [[gameGrid objectAtIndex:i] removeAllObjects];
        for (int j = 0; j < 6; j++) {
            SyntaxSymbol *symbol = [symbolManager symbolWithType:arc4random() % 5];
            symbol.isIndex = CGPointMake(i, j);
            symbol.center = [self CGPointFromIndex:symbol.isIndex];
            [[gameGrid objectAtIndex:i] addObject:symbol];
            [self checkIfSymbolNotMakingPattern:symbol];
            symbol.alpha = 0.001;
            [self addSubview:symbol];
            
            packet.gameGrid[i][j] = symbol.isOfType;
        }      
    }
    [self glitch];
    NSData *packetData = [NSData dataWithBytes:&packet length:sizeof(PacketInit)];
    [viewController.gameCenterManager sendPacket:packetData];
    canTouch = YES;
}

- (void)checkIfSymbolNotMakingPattern:(SyntaxSymbol *)thisSymbol {
    int x = thisSymbol.isIndex.x;
    int y = thisSymbol.isIndex.y;
    int typeToSkip = thisSymbol.isOfType;
    BOOL hasToChange = NO;
    SyntaxSymbol *symbolToCheck;
    if (x > 1) {
        symbolToCheck = [[gameGrid objectAtIndex:x - 1] objectAtIndex:y];
        if (symbolToCheck.isOfType == typeToSkip) {
            symbolToCheck = [[gameGrid objectAtIndex:x - 2] objectAtIndex:y];
            if (symbolToCheck.isOfType == typeToSkip) hasToChange = YES;
        }        
    }
    if (y > 1) {
        symbolToCheck = [[gameGrid objectAtIndex:x] objectAtIndex:y - 1];
        if (symbolToCheck.isOfType == typeToSkip) {
            symbolToCheck = [[gameGrid objectAtIndex:x] objectAtIndex:y - 2];
            if (symbolToCheck.isOfType == typeToSkip) hasToChange = YES;
        }        
    }
    if (hasToChange) {
        int newType = (arc4random() % 5);
        while (newType == typeToSkip) {
            newType = (arc4random() % 5);
        }
        [symbolManager shiftSymbol:thisSymbol toType:newType];
    }
}

- (void)selectSymbol:(SyntaxSymbol *)thisSymbol {
    if (firstTouchedSymbol == nil) {
        [viewController.soundController playSound:@"SymbolSelect_A"];
        firstTouchedSymbol = [thisSymbol retain];
        [symbolManager selectSymbol:thisSymbol];
    }
    else {
        [viewController.soundController playSound:@"SymbolSelect_B"];
        [symbolManager deselectSymbol:firstTouchedSymbol];
        if ([self symbol:thisSymbol.isIndex isNeighbourToSymbol:firstTouchedSymbol.isIndex]) {
            if (!(firstTouchedSymbol.isOfType == 11)) [self swapSymbol:thisSymbol withSymbol:firstTouchedSymbol];
            else {
                [symbolsToRemove addObject:firstTouchedSymbol];
                [self eliminateAllSymbolsOfType:thisSymbol.isOfType];                    
            }
        }           
        [firstTouchedSymbol release];
        firstTouchedSymbol = nil;
    }       
}

- (BOOL)symbol:(CGPoint)firstIndex isNeighbourToSymbol:(CGPoint)secondIndex {
    BOOL isNeighbour = NO;
    if ((abs((firstIndex.x - secondIndex.x)) == 1) & (firstIndex.y == secondIndex.y)) isNeighbour = YES;
    else if ((abs((firstIndex.y - secondIndex.y)) == 1) & (firstIndex.x == secondIndex.x)) isNeighbour = YES;
    return isNeighbour;
}

- (void)swapSymbol:(SyntaxSymbol *)firstSymbol withSymbol:(SyntaxSymbol *)secondSymbol {
    canTouch = NO;
    PacketSwap packet;
    packet.packetType.isPacketType = kPacketSwap;
    packet.symbol1.x = firstSymbol.isIndex.x;
    packet.symbol1.y = firstSymbol.isIndex.y;
    packet.symbol2.x = secondSymbol.isIndex.x;
    packet.symbol2.y = secondSymbol.isIndex.y;    
    NSData *packetData = [NSData dataWithBytes:&packet length:sizeof(PacketSwap)];
    [viewController.gameCenterManager sendPacket:packetData];
    
    NSMutableArray *firstSymbolRow = [gameGrid objectAtIndex:firstSymbol.isIndex.x];
    NSMutableArray *secondSymbolRow = [gameGrid objectAtIndex:secondSymbol.isIndex.x];
    [firstSymbolRow replaceObjectAtIndex:firstSymbol.isIndex.y withObject:secondSymbol];
    [secondSymbolRow replaceObjectAtIndex:secondSymbol.isIndex.y withObject:firstSymbol];
    
    CGPoint temp = firstSymbol.isIndex;
    firstSymbol.isIndex = secondSymbol.isIndex;
    secondSymbol.isIndex = temp;
    
    [firstTouchedSymbol release];
    firstTouchedSymbol = nil;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         firstSymbol.center = [self CGPointFromIndex:firstSymbol.isIndex];
                         secondSymbol.center = [self CGPointFromIndex:secondSymbol.isIndex];
                     }
                     completion:^(BOOL finished) {
                         isMoveValid = NO;
                         isDoubleMatch = YES;
                         [self searchPatterns];                         
                         if (!isMoveValid) [self swapBackSymbol:firstSymbol withSymbol:secondSymbol];
                     }];  
}

- (void)swapBackSymbol:(SyntaxSymbol *)firstSymbol withSymbol:(SyntaxSymbol *)secondSymbol {
    canTouch = NO;
    [viewController.soundController playSound:@"NoMatch"];
    
    PacketSwap packet;
    packet.packetType.isPacketType = kPacketSwap;
    packet.symbol1.x = firstSymbol.isIndex.x;
    packet.symbol1.y = firstSymbol.isIndex.y;
    packet.symbol2.x = secondSymbol.isIndex.x;
    packet.symbol2.y = secondSymbol.isIndex.y;    
    NSData *packetData = [NSData dataWithBytes:&packet length:sizeof(PacketSwap)];
    [viewController.gameCenterManager sendPacket:packetData];
    
    NSMutableArray *firstSymbolRow = [gameGrid objectAtIndex:firstSymbol.isIndex.x];
    NSMutableArray *secondSymbolRow = [gameGrid objectAtIndex:secondSymbol.isIndex.x];
    [firstSymbolRow replaceObjectAtIndex:firstSymbol.isIndex.y withObject:secondSymbol];
    [secondSymbolRow replaceObjectAtIndex:secondSymbol.isIndex.y withObject:firstSymbol];
    
    CGPoint temp = firstSymbol.isIndex;
    firstSymbol.isIndex = secondSymbol.isIndex;
    secondSymbol.isIndex = temp;
    
    [firstTouchedSymbol release];
    firstTouchedSymbol = nil;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         firstSymbol.center = [self CGPointFromIndex:firstSymbol.isIndex];
                         firstSymbol.alpha = 1;
                         secondSymbol.center = [self CGPointFromIndex:secondSymbol.isIndex];
                         secondSymbol.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         canTouch = YES;
                     }];      
}


- (void)eliminateNeightboursOfSymbolAtIndex:(CGPoint)thisIndex {
    int m;
    int n;
    for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
            m = thisIndex.x + i;
            n = thisIndex.y + j;
            if ((m > -1) & (m < 6) & (n > -1) & (n < 6)) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:m] objectAtIndex:n];
                if (symbolToAdd.isOfType > 6) [symbolsToSkip addObject:symbolToAdd];
                if (!([symbolsToRemove containsObject:symbolToAdd]) & (![symbolsToSkip containsObject:symbolToAdd])) {
                    [symbolsToRemove addObject:symbolToAdd];
                    symbolToAdd.isToExplode = YES;
                }
            }
        }
    }    
}

- (void)eliminateAllSymbolsOfType:(int)thisType {
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 6; j++) {
            SyntaxSymbol *symbolToCheck = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            if (symbolToCheck.isOfType == thisType) {
                [symbolsToRemove addObject:symbolToCheck];
                noOfSuperEliminated++;
            }
        }
    }
    [self eraseSymbols]; 
}

- (void)eliminateAllSymbolsInLineWithSymbolAtIndex:(CGPoint)thisIndex {
    for (int i = 0; i < 6; i++) {
        SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:i] objectAtIndex:thisIndex.y];
        if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];    
    }
    for (int j = 0; j < 6; j++) {
        SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisIndex.x] objectAtIndex:j];
        if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                        
    }    
}

- (void)eraseSymbols {
    canTouch = NO;
    PacketErase packet;
    packet.packetType.isPacketType = kPacketErase;
    
    packet.shockwaveCenter.x = shockwaveCentre.x;
    packet.shockwaveCenter.y = shockwaveCentre.y;
    
    if (isShockwave) {
        [self shockWaveFromCenter:shockwaveCentre];
        shockwaveCentre = CGPointMake(-1, -1);
    }
    
    int i = 0;
    int j = 0;
    int k = 0;
    
    for (SyntaxSymbol *thisSymbol in symbolsToSkip) {
        if (thisSymbol.isExplosive) {
            packet.symbolsToTurnExplosive[i].x = thisSymbol.isIndex.x;
            packet.symbolsToTurnExplosive[i].y = thisSymbol.isIndex.y;
            i++;            
        }
        if (thisSymbol.isOfType == 11) {
            packet.symbolsToTurnToSuper[j].x = thisSymbol.isIndex.x;
            packet.symbolsToTurnToSuper[j].y = thisSymbol.isIndex.y;
            j++;            
        };
    }
    packet.areSymbolsToTurnExplosive = i;
    packet.areSymbolsToTurnToSuper = j;
    
    i = 0;
    j = 0;
    k = 0;
    for (SyntaxSymbol *thisSymbol in symbolsToRemove) {
        if (![symbolsToSkip containsObject:thisSymbol]) {
            if (thisSymbol.isToExplode) {
                packet.symbolsToExplode[i].x = thisSymbol.isIndex.x;
                packet.symbolsToExplode[i].y = thisSymbol.isIndex.y;                
                [symbolManager animExplodeSymbol:thisSymbol WithDelay:(float) ((arc4random() % 5) / 10.0)];
                i++;
            }
            else if (thisSymbol.isLShapeCorner ) {
                packet.symbolsCornersForLShape[j].x = thisSymbol.isIndex.x;
                packet.symbolsCornersForLShape[j].y = thisSymbol.isIndex.y;
                [symbolManager animLShapeOnSymbol:thisSymbol andView:self];
                j++;
            }
            else {
                packet.symbolsToRemove[k].x = thisSymbol.isIndex.x;
                packet.symbolsToRemove[k].y = thisSymbol.isIndex.y;
                [symbolManager animHideSymbol:thisSymbol WithDelay:0];
                k++;                
            }            
            [[gameGrid objectAtIndex:thisSymbol.isIndex.x] removeObject:thisSymbol]; 
        }
    }
    packet.areSymbolsToExplode = i;
    packet.areSymbolsCornersForLShape = j;
    packet.areSymbolsToRemove = k;
    
    [symbolsToRemove removeAllObjects];
    [symbolsToSkip removeAllObjects];
    
    /////////////////////////////////////////////
    
    if (isCascading) noOfCascadingMatches++;
    
    if (noOfNormalMatches > 0) [viewController.soundController playSound:@"SymbolElimination"];
    if (noOfMatchesOf4 > 0) [viewController.soundController playSound:@"4Match"];
    if (noOfMatchesOf4Explosion > 0) [viewController.soundController playSound:@"4Match_Explosion"];
    if (noOfMatchesOf5 > 0) [viewController.soundController playSound:@"5Match"];
    if (noOfLShapedMatches > 0) [viewController.soundController playSound:@"LMatch"];
    if (noOfSuperEliminated > 0) [viewController.soundController playSound:@"SuperSymbolElimination"];
    
    pointsToAdd = noOfNormalMatches * viewController.valuesManager.kPointsStandardMatch +
    noOfMatchesOf4 * viewController.valuesManager.kPoints4Match +
    noOfMatchesOf4Explosion * viewController.valuesManager.kPoints4MatchExplosion +
    noOfMatchesOf5 * viewController.valuesManager.kPoints5Match +
    noOfLShapedMatches * viewController.valuesManager.kPointsLMatch +
    noOfSuperEliminated * viewController.valuesManager.kPointsSuperEliminatedSymbol +
    noOfCascadingMatches * viewController.valuesManager.kPointsCascadingMatch +
    noOfDoubleMatches * viewController.valuesManager.kPointsDoubleMatch;
    
    packet.pointsToAdd = pointsToAdd;
    
    viewController.statsManager.player1Score += pointsToAdd;
    [viewController.engageView updatePlayer1Score];
    
    [self clearPoints];
    
    isCascading = YES;
    
        
    /////////////////////////////////////////////////
    
    k = 0;
    for (int i = 0; i < 6; i++) {
        int m = [[gameGrid objectAtIndex:i] count];
        if (m < 6) {
            for (int j = 0; j < 6 - m; j++) {
                SyntaxSymbol *newSymbol = [symbolManager symbolWithType:arc4random() % 5];
                newSymbol.center = [self CGPointFromIndex:CGPointMake(i, 6+j)];
                newSymbol.isIndex = CGPointMake(i,6+j);
                [self addSubview:newSymbol];
                packet.symbolsToAdd[k] = newSymbol.isOfType;
                k++;
                [[gameGrid objectAtIndex:i] addObject:newSymbol];                
            }
        }
    }
    
    NSData *packetData = [NSData dataWithBytes:&packet length:sizeof(PacketErase)];
    [viewController.gameCenterManager sendPacket:packetData];
    
    ////////////////////////////////////////////////
    
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
    if ([symbolsToMove count] == 0) [self searchPatterns];
}

#pragma PATTERN SEARCHING //\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

- (void)searchPatterns {
    if (!isGameOver) {
        int canGlitch;
        
        ///L-shaped pattern
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 6; j++) {
                SyntaxSymbol *searchedSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
                if (searchedSymbol.isOfType < 5) if (![symbolsToRemove containsObject:searchedSymbol]) [self searchPatternLShapeForSymbol:searchedSymbol];
            }
        } 
        
        ///horizontal patterns
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 6; j++) {
                SyntaxSymbol *searchedSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
                if (searchedSymbol.isOfType < 5) if (![symbolsToRemove containsObject:searchedSymbol]) [self searchPatternHorizontalForSymbol:searchedSymbol];
            }
        } 
        
        ///vertical patterns
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 4; j++) {
                SyntaxSymbol *searchedSymbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
                if (searchedSymbol.isOfType < 5) if (![symbolsToRemove containsObject:searchedSymbol]) [self searchPatternVerticalForSymbol:searchedSymbol];            
            }
        }
        
        if ([symbolsToRemove count] > 0) {
            isMoveValid = YES;
            if ((isDoubleMatch) & ([symbolsToRemove count] > 5)) noOfDoubleMatches++;
            [self eraseSymbols];
        }
        else {        
            isCascading = NO;
            noOfCascadingMatches = 0;        
            if (!isGameOver) {
                canGlitch = arc4random() % 3;
                if (canGlitch == 0) [self glitch];            
            }
            canTouch = YES;
        }
        isDoubleMatch = NO;        
    }
    else [self clearGame];
}
- (void)searchPatternLShapeForSymbol:(SyntaxSymbol *)thisSymbol {
    int x = thisSymbol.isIndex.x;
    int y = thisSymbol.isIndex.y;
    BOOL hasHorizontal = NO;
    BOOL hasVertical = NO;
    
    if (x > 1) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x - 1] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            nextSymbol = [[gameGrid objectAtIndex:x - 2] objectAtIndex:y];
            if (thisSymbol.isOfType == nextSymbol.isOfType) hasHorizontal = YES;
        }
    }
    if (x < 4) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x + 1] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            nextSymbol = [[gameGrid objectAtIndex:x + 2] objectAtIndex:y];
            if (thisSymbol.isOfType == nextSymbol.isOfType) hasHorizontal = YES;
        }
    }
    if (y > 1) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y - 1];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y - 2];
            if (thisSymbol.isOfType == nextSymbol.isOfType) hasVertical = YES;
        }
    }
    if (y < 4) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y + 1];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y + 2];
            if (thisSymbol.isOfType == nextSymbol.isOfType) hasVertical = YES;
        }
    }    
    if (hasHorizontal & hasVertical) {
        thisSymbol.isLShapeCorner = YES;
        noOfLShapedMatches++;
        [self eliminateAllSymbolsInLineWithSymbolAtIndex:thisSymbol.isIndex];        
    }
}

- (void)searchPatternHorizontalForSymbol:(SyntaxSymbol *)thisSymbol {
    int x = thisSymbol.isIndex.x + 1;
    int y = thisSymbol.isIndex.y;
    int matched = 1;
    BOOL canBreak = NO;
    BOOL canEliminateNeighbours = NO;
    
    if (thisSymbol.isExplosive) canEliminateNeighbours = YES;
    
    while (x < 6) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            matched++;
            if (nextSymbol.isExplosive) canEliminateNeighbours = YES;
        }
        else canBreak = YES;       
        x++;
        if (canBreak) break;        
    }
    
    x = thisSymbol.isIndex.x;
    switch (matched) {
        case 5:
            noOfMatchesOf5++;
            for (int i = 0; i < matched; i++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x + i] objectAtIndex:thisSymbol.isIndex.y];
                if (i == 0) {
                    [symbolsToSkip addObject:symbolToAdd];
                    [symbolManager turnToSuperSymbol:symbolToAdd];
                }
                else {
                    if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                    
                }                
            }
            break;
        case 4:
            noOfMatchesOf4++;
            for (int i = 0; i < matched; i++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x + i] objectAtIndex:thisSymbol.isIndex.y];
                if (i == 0) {
                    [symbolsToSkip addObject:symbolToAdd];
                    [symbolManager turnToExplosiveSymbol:symbolToAdd];
                }
                else {
                    if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                    
                }                
            }
            break;
        case 3:
            noOfNormalMatches++;
            for (int i = 0; i < matched; i++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x + i] objectAtIndex:thisSymbol.isIndex.y];
                if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];
            }
            break;            
        default:
            break;
    }
    if (canEliminateNeighbours & (matched > 2)) {
        noOfMatchesOf4Explosion++;
        for (int i = 0; i < matched; i++) {
            SyntaxSymbol *symbolToCheck = [[gameGrid objectAtIndex:thisSymbol.isIndex.x + i] objectAtIndex:thisSymbol.isIndex.y];
            symbolToCheck.isToExplode = YES;
            [self eliminateNeightboursOfSymbolAtIndex:symbolToCheck.isIndex];
        }        
        isShockwave = YES;
        shockwaveCentre = CGPointMake(x, y); 
    }
}

- (void)searchPatternVerticalForSymbol:(SyntaxSymbol *)thisSymbol {
    int x = thisSymbol.isIndex.x;
    int y = thisSymbol.isIndex.y + 1;
    int matched = 1;
    BOOL canBreak = NO;
    BOOL canEliminateNeighbours = NO;
    
    if (thisSymbol.isExplosive) canEliminateNeighbours = YES;
    
    while (y < 6) {
        SyntaxSymbol *nextSymbol = [[gameGrid objectAtIndex:x] objectAtIndex:y];
        if (thisSymbol.isOfType == nextSymbol.isOfType) {
            matched++;
            if (nextSymbol.isExplosive) canEliminateNeighbours = YES;
        }
        else canBreak = YES;       
        y++;
        if (canBreak) break;        
    }
    
    y = thisSymbol.isIndex.y;
    switch (matched) {
        case 5:
            noOfMatchesOf5++;
            for (int j = 0; j < matched; j++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x] objectAtIndex:thisSymbol.isIndex.y + j];
                if (j == 0) {
                    [symbolsToSkip addObject:symbolToAdd];
                    [symbolManager turnToSuperSymbol:symbolToAdd];
                }
                else {
                    if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                    
                }                
            }
            break;
        case 4:
            noOfMatchesOf4++;
            for (int j = 0; j < matched; j++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x] objectAtIndex:thisSymbol.isIndex.y + j];
                if (j == 0) {
                    [symbolsToSkip addObject:symbolToAdd];
                    [symbolManager turnToExplosiveSymbol:symbolToAdd];
                }
                else {
                    if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];                    
                }                
            }
            break;
        case 3:
            noOfNormalMatches++;
            for (int j = 0; j < matched; j++) {
                SyntaxSymbol *symbolToAdd = [[gameGrid objectAtIndex:thisSymbol.isIndex.x] objectAtIndex:thisSymbol.isIndex.y + j];
                if (![symbolsToRemove containsObject:symbolToAdd]) [symbolsToRemove addObject:symbolToAdd];
            }
            break;            
        default:
            break;
    }
    if (canEliminateNeighbours & (matched > 2)) {
        noOfMatchesOf4Explosion++;
        for (int j = 0; j < matched; j++) {
            SyntaxSymbol *symbolToCheck = [[gameGrid objectAtIndex:thisSymbol.isIndex.x] objectAtIndex:thisSymbol.isIndex.y + j];
            symbolToCheck.isToExplode = YES;
            [self eliminateNeightboursOfSymbolAtIndex:symbolToCheck.isIndex];
        } 
        isShockwave = YES;
        shockwaveCentre = CGPointMake(x, y); 
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
    isShockwave = NO;    
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

- (void)clearPoints {
    noOfNormalMatches = 0;
    noOfDoubleMatches = 0;
    noOfMatchesOf4 = 0;
    noOfMatchesOf4Explosion = 0;
    noOfMatchesOf5 = 0;
    noOfSuperEliminated = 0;
    noOfLShapedMatches = 0;
}

- (void)clearGame {
    didClear = YES;
    PacketErase packet;
    packet.packetType.isPacketType = kPacketEndGame;
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 6; j++) {
            SyntaxSymbol *symbol = [[gameGrid objectAtIndex:i] objectAtIndex:j];
            [symbolManager animHideSymbol:symbol WithDelay:(float) (arc4random() % 100 / 100.0)];
        }
    }
    [symbolsToRemove removeAllObjects];
    [symbolsToSkip removeAllObjects];
    [symbolsToMove removeAllObjects];
    
    NSData *packetData = [NSData dataWithBytes:&packet length:sizeof(PacketEndGame)];
    [viewController.gameCenterManager sendPacket:packetData];
}

- (void)endGame {
    isGameOver = YES;
    if (!didClear) [self clearGame];
}


////////////////
//////////////////////////////////////////////////---> Input & App Specific <---///////////////////////////////////////////////////
///////////////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (canTouch) {
        UITouch *touch = [touches anyObject];
        if ([[touch view] isKindOfClass:[SyntaxSymbol class]]) {
            SyntaxSymbol *thisSymbol = (SyntaxSymbol *)[touch view];      
            [self selectSymbol:thisSymbol];
        }              
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (canTouch) {
        UITouch *touch = [touches anyObject];
        if ([[touch view] isKindOfClass:[SyntaxSymbol class]]) {
            SyntaxSymbol *thisSymbol = (SyntaxSymbol *)[touch view];
            if (thisSymbol == firstTouchedSymbol) {
                CGPoint location = [touch locationInView:self];
                float dx = thisSymbol.center.x - location.x;
                float dy = thisSymbol.center.y - location.y;
                if ((abs(dx) > 15) | (abs(dy) > 15)) {
                    CGPoint direction;
                    if (abs(dx) > abs(dy)) {
                        if (dx > 0) direction = CGPointMake(-1, 0);
                        else direction = CGPointMake(1, 0);
                    }
                    else {
                        if (dy > 0) direction = CGPointMake(0, 1);
                        else direction = CGPointMake(0, -1);            
                    }
                    CGPoint posibleIndex = CGPointMake(thisSymbol.isIndex.x + direction.x, thisSymbol.isIndex.y + direction.y);
                    if ((posibleIndex.x > -1) & (posibleIndex.x < 6) & (posibleIndex.y > -1) & (posibleIndex.y < 6)) {
                        SyntaxSymbol *otherSymbol = [[gameGrid objectAtIndex:posibleIndex.x] objectAtIndex:posibleIndex.y];
                        if ([self symbol:thisSymbol.isIndex isNeighbourToSymbol:otherSymbol.isIndex]) {
                            [self swapSymbol:thisSymbol withSymbol:otherSymbol];
                            [symbolManager deselectSymbol:thisSymbol];
                        }
                    }
                }            
            }
        }        
    }
}

- (void)dealloc {
    [viewController release];
    [symbolManager release];
    [symbolsToRemove removeAllObjects]; [symbolsToRemove release];
    [symbolsToMove removeAllObjects]; [symbolsToMove release];
    [symbolsToSkip removeAllObjects]; [symbolsToSkip release];
    for (NSMutableArray *col in gameGrid) {
        for (SyntaxSymbol *symbol in col) {
            [symbolManager animHideSymbol:symbol WithDelay:0];
        }
        [col removeAllObjects];
    }
    [gameGrid removeAllObjects]; [gameGrid release];
    if (firstTouchedSymbol != nil) [firstTouchedSymbol release];
    [super dealloc];
}


@end