//
//  HelloWorldLayer.m
//  TowerDefenseUpdate
//
//  Created by Brian Broom on 4/7/13.
//  Copyright Brian Broom 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

#import "Waypoint.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "Tower.h"
#import "Enemy.h"


#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize waypoints;

@synthesize towers;



// Synthesize enemies
@synthesize enemies;

- (void)addWaypoints {
    
    waypoints = [[NSMutableArray alloc] init];
    
    Waypoint * waypoint1 = [Waypoint nodeWithTheGame:self location:ccp(420,35)];
    [waypoints addObject:waypoint1];
    
    Waypoint * waypoint2 = [Waypoint nodeWithTheGame:self location:ccp(35,35)];
    [waypoints addObject:waypoint2];
    waypoint2.nextWaypoint =waypoint1;
    
    Waypoint * waypoint3 = [Waypoint nodeWithTheGame:self location:ccp(35,130)];
    [waypoints addObject:waypoint3];
    waypoint3.nextWaypoint =waypoint2;
    
    Waypoint * waypoint4 = [Waypoint nodeWithTheGame:self location:ccp(445,130)];
    [waypoints addObject:waypoint4];
    waypoint4.nextWaypoint =waypoint3;
    
    Waypoint * waypoint5 = [Waypoint nodeWithTheGame:self location:ccp(445,220)];
    [waypoints addObject:waypoint5];
    waypoint5.nextWaypoint =waypoint4;
    
    Waypoint * waypoint6 = [Waypoint nodeWithTheGame:self location:ccp(-40,220)];
    [waypoints addObject:waypoint6];
    waypoint6.nextWaypoint =waypoint5;
}

- (BOOL)canBuyTower {
    return YES;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        for (CCSprite *tb in towerBases) {
            if (CGRectContainsPoint([tb boundingBox], location) && [self canBuyTower] && !tb.userData) {
                Tower *tower = [Tower nodeWithTheGame:self location:tb.position];
                [towers addObject:tower];
                tb.userData = (__bridge void *)(towerBases);
            }
        }
    }
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		// 1 - initialize
        self.touchEnabled = YES;
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        // 2 - set background
        CCSprite *background = [CCSprite spriteWithFile:@"bg.png"];
        [self addChild:background];
        [background setPosition:ccp(winSize.width / 2, winSize.height / 2)];
        
        // 3 - load tower positions
        [self loadTowerPosition];

        // 4 - add waypoints
        [self addWaypoints];
        
        // Add the following to the end of the init method:
        // 5 - Add enemies
        enemies = [[NSMutableArray alloc] init];
        [self loadWave];
        // 6 - Create wave label
        ui_wave_lbl = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"WAVE: %d",wave]
                                             fntFile:@"font_red_14.fnt"];
        [self addChild:ui_wave_lbl z:10];
        [ui_wave_lbl setPosition:ccp(400,winSize.height-12)];
        [ui_wave_lbl setAnchorPoint:ccp(0,0.5)];

        // 5 - add enemies
        
        // 6 - create wave label
        
        // 7 - player lives
        
        // 8 - gold
        
        // 9 - sound
	}
	return self;
}

- (void)loadTowerPosition {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TowersPosition" ofType:@"plist"];
    NSArray *towerPositions = [NSArray arrayWithContentsOfFile:plistPath];
    
    towerBases = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (NSDictionary *towerPos in towerPositions) {
        CCSprite *towerBase = [CCSprite spriteWithFile:@"open_spot.png"];
        [self addChild:towerBase];
        [towerBase setPosition:ccp([[towerPos objectForKey:@"x"] intValue],
                                   [[towerPos objectForKey:@"y"] intValue])];
        [towerBases addObject:towerBase];
    }
}

- (BOOL)circle:(CGPoint)circlePoint withRadius:(float)radius collisionWithCircle:(CGPoint)circlePointTwo collisionCircleRadius:(float)radiusTwo {
    float xdif = circlePoint.x - circlePointTwo.x;
    float ydif = circlePoint.y - circlePointTwo.y;
    
    float distance = sqrt(xdif * xdif + ydif * ydif);
    
    if (distance <= radius + radiusTwo) {
        return YES;
    }
    
    return NO;
}

//Add the following methods:
-(BOOL)loadWave {
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Waves" ofType:@"plist"];
    NSArray * waveData = [NSArray arrayWithContentsOfFile:plistPath];
    
    if(wave >= [waveData count])
    {
        return NO;
    }
    
    NSArray * currentWaveData =[NSArray arrayWithArray:[waveData objectAtIndex:wave]];
    
//    for(NSDictionary * enemyData in currentWaveData)
//    {
//        Enemy * enemy = [Enemy nodeWithTheGame:self];
//        [enemies addObject:enemy];
//        [enemy schedule:@selector(doActivate)
//               interval:[[enemyData objectForKey:@"spawnTime"]floatValue]];
//    }
    for (NSDictionary *enemyData in currentWaveData) {
        Enemy *enemy = [Enemy nodeWithTheGame:self];
        [enemies addObject:enemy];
        [enemy schedule:@selector(doActivate) interval:[[enemyData objectForKey:@"spawnTime"] floatValue]];
    }
    
    wave++;
//    [ui_wave_lbl setString:[NSString stringWithFormat:@"WAVE: %d",wave]];
    [ui_wave_lbl setString:[NSString stringWithFormat:@"ZZZ Wave: %d", wave]];
    
    return YES;
    
}

-(void)enemyGotKilled {
    if ([enemies count]<=0) //If there are no more enemies.
    {
        if(![self loadWave])
        {
            NSLog(@"You win!");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSplitCols
                                                       transitionWithDuration:1
                                                       scene:[HelloWorldLayer scene]]];
        }
    }
}


@end
