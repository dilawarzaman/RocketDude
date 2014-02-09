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
        
        
        [self addChild:sprite];

        onscreen=NO;
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        //CGPoint location = [touch locationInNode:self];

        }
    onscreen=YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    onscreen=NO;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (onscreen) {
        sprite.position=CGPointMake(sprite.position.x, sprite.position.y+2);

    }
    else{
        sprite.position=CGPointMake(sprite.position.x, sprite.position.y-2);
    }

}

@end
