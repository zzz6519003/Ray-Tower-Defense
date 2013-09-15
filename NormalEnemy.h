#import "cocos2d.h"
#import "HelloWorldLayer.h"

@class HelloWorldLayer, Waypoint, Tower;

@interface NormalEnemy: CCNode {
    CGPoint myPosition;
    int maxHp;
    int currentHp;
    float walkingSpeed;
    Waypoint *destinationWaypoint;
    BOOL active;
    
    // Add instance variable
    NSMutableArray *attackedBy;
}

@property (nonatomic,assign) HelloWorldLayer *theGame;
@property (nonatomic,assign) CCSprite *mySprite;

+(id)nodeWithTheGame:(HelloWorldLayer*)_game;
-(id)initWithTheGame:(HelloWorldLayer *)_game;
-(void)doActivate;
-(void)getRemoved;

// Add method definitions
-(void)getAttacked:(Tower *)attacker;
-(void)gotLostSight:(Tower *)attacker;
-(void)getDamaged:(int)damage;


@end