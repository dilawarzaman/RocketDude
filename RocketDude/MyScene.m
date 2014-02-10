//
//  MyScene.m
//  RocketDude
//
//  Created by Dilawar Zaman on 2/9/14.
//  Copyright (c) 2014 Dilawar Zaman. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        sprite = [SKSpriteNode spriteNodeWithImageNamed:@"doodle100"];
        sprite.xScale=.5;
        sprite.yScale=.5;
        sprite.position = CGPointMake(30, size.height/2);
        sprite.name=@"dude";
        
        [self addChild:sprite];

        touchonscreen=NO;
        
        [self addPillar];
        
    }
    return self;
}
-(void)addPillar{
    SKSpriteNode *pillar = [SKSpriteNode spriteNodeWithImageNamed:@"rectangle32"];
    pillar.anchorPoint=CGPointMake(0, 0);
    pillar.xScale=5;
    
    pillar.position=CGPointMake(self.size.width, 195);
    [self addChild:pillar];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        //CGPoint location = [touch locationInNode:self];

        }
    touchonscreen=YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    touchonscreen=NO;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (touchonscreen) {
        sprite.position=CGPointMake(sprite.position.x, sprite.position.y+2);

    }
    else{
        sprite.position=CGPointMake(sprite.position.x, sprite.position.y-2);
    }
    for (SKNode *child in self.children) {
        if (child.position.x<-400) {
            [child removeFromParent];
        }
        if (![child.name isEqual:@"dude"]) {
            child.position=CGPointMake(child.position.x-2, child.position.y);
            
        }
        
    }
}

@end
