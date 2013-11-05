//
//  SyntaxEngagePacket.h
//  Syntax
//
//  Created by Seby Moisei on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

typedef enum {
    kPacketInit = 0,
    kPacketSwap,
    kPacketErase,
    kPacketPlayAgain,
    kPacketEndGame
} IsPacketType;

typedef struct{
    IsPacketType isPacketType;    
} PacketType;

typedef struct {
    int x;
    int y;    
} Index;

#pragma Packet Types //////////////////////////////////

typedef struct {
    PacketType packetType;
    int gameGrid[6][6];    
} PacketInit;

typedef struct {
    PacketType packetType;
    Index symbol1;
    Index symbol2;
} PacketSwap;

typedef struct {
    PacketType packetType;
    Index symbolsToRemove[36];
    int symbolsToAdd[36];
    Index symbolsToTurnExplosive[36];
    Index symbolsToExplode[36];
    Index symbolsToTurnToSuper[36];
    Index symbolsCornersForLShape[12];
    int areSymbolsToRemove;
    int areSymbolsToTurnExplosive;
    int areSymbolsToExplode;
    int areSymbolsToTurnToSuper;
    int areSymbolsCornersForLShape;
    int pointsToAdd;
    Index shockwaveCenter;
} PacketErase;

typedef struct {
    PacketType packetType;    
} PacketPlayAgain;

typedef struct {
    PacketType packetType;
} PacketEndGame;

