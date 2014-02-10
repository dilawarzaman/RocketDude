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
- (void)didMoveToView:(SKView *)view
{
    }

-(void)addPillar{
    int x = arc4random_uniform(8)+1;
   double val = ((double)arc4random() / 2);


    SKSpriteNode *pillar = [SKSpriteNode spriteNodeWithImageNamed:@"rectangle32"];
    pillar.name=@"pillar";
    pillar.anchorPoint=CGPointMake(0, 0);
    pillar.xScale=x;
    //pillar.yScale=val;

    pillar.position=CGPointMake(self.size.width+5, 193);
    
    SKSpriteNode *edge = [SKSpriteNode spriteNodeWithImageNamed:@"edge"];
    edge.name=@"edge";
    edge.anchorPoint=CGPointMake(0, 0);
    edge.position=CGPointMake(self.size.width+5, 193);


    [self addChild:pillar];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    //for (UITouch *touch in touches) {
        //CGPoint location = [touch locationInNode:self];

      //  }
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
        if (child.position.x<-child.frame.size.width) {
            [child removeFromParent];
            [self addPillar];
        }
        if (![child.name isEqual:@"dude"]) {
            child.position=CGPointMake(child.position.x-2, child.position.y);
            if ([child intersectsNode:sprite]) {
                NSLog(@"collision:%f",sprite.position.y+sprite.frame.size.height/2);
                if (sprite.position.y+sprite.frame.size.height/2>=child.frame.size.height+sprite.frame.size.height/2+193) {
                    sprite.position=CGPointMake(sprite.position.x, child.frame.size.height+sprite.frame.size.height/2+193);
                }
                else{
                    NSLog(@"game over");
                    [self endgame];
            
                }
            }

            
        }
        
    }
    
}
-(void)endgame{
    self.view.paused=YES;
    UILabel *GameOver=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.height/2, self.view.frame.size.width/2, 150, 20)];
    GameOver.text=@"Game Over";
    [GameOver setTextColor:[UIColor blackColor]];
    [self.view addSubview:GameOver];
}
@end
