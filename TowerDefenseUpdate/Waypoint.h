//
//  Waypoint.h
//  TowerDefenseUpdate
//
//  Created by Snowmanzzz on 13-7-12.
//  Copyright (c) 2013年 Brian Broom. All rights reserved.
//

#import "CCNode.h"

#import "cocos2d.h"
#import "HelloWorldLayer.h"

@interface Waypoint : CCNode {
    HelloWorldLayer *theGame;
}

@property (nonatomic, readwrite) CGPoint myPosition;
@property (nonatomic, assign) Waypoint *nextWaypoint;


+ (id)nodeWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location;
- (id)initWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location;

@end
