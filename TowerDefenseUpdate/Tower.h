//
//  Tower.h
//  TowerDefenseUpdate
//
//  Created by Snowmanzzz on 13-7-10.
//  Copyright (c) 2013年 Brian Broom. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
#import "HelloWorldLayer.h"

#define kTOWER_COST 300

@class HelloWorldLayer, Enemy;

@interface Tower : CCNode {
    int attackRange;
    int damage;
    float fireRate;
    
    // Add some instance variables
    BOOL attacking;
    Enemy *chosenEnemy;
    
}

@property (nonatomic, weak) HelloWorldLayer *theGame;
@property (nonatomic, strong) CCSprite *mySprite;

+ (id)nodeWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location;
- (id)initWithTheGame:(HelloWorldLayer *)_game location:(CGPoint)location;


// Add method definition
-(void)targetKilled;


@end
