//
//  Waypoint.m
//  TowerDefenseUpdate
//
//  Created by Snowmanzzz on 13-7-12.
//  Copyright (c) 2013年 Brian Broom. All rights reserved.
//

#import "Waypoint.h"

@implementation Waypoint

+ (id)nodeWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location {
    return [[self alloc] initWithTheGame:_game location:location];
}

- (id)initWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location {
    if ((self = [super init])) {
        theGame = _game;
        [self setPosition:CGPointZero];
        _myPosition = location;
        
        [theGame addChild:self];
    }
    
    return self;
}


- (void)draw {
    ccDrawColor4B(0, 255, 2, 255);
    ccDrawCircle(_myPosition, 6, 360, 30, false);
    ccDrawCircle(_myPosition, 2, 360, 30, false);
    
    if (_nextWaypoint) {
        ccDrawLine(_myPosition, _nextWaypoint.myPosition);
    }
    [super draw];
}

@end
