//
//  MyScene.h
//  RocketDude
//

//  Copyright (c) 2014 Dilawar Zaman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@interface MyScene : SKScene{

    SKSpriteNode *sprite;
    BOOL touchonscreen;
    NSTimer *genTimer;
    
    NSTimer *scoreTimer;
    int score;
    SKLabelNode *scoreLabel;
    
    float height;
    float width;
    
    SKShapeNode *green;
    double batterylife;
    BOOL onPlatform;
}
@property (nonatomic, retain) NSTimer *genTimer;
@property (nonatomic, retain) NSTimer *scoreTimer;

@end
