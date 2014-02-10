//
//  MyScene.m
//  RocketDude
//
//  Created by Dilawar Zaman on 2/9/14.
//  Copyright (c) 2014 Dilawar Zaman. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene
@synthesize genTimer;
@synthesize scoreTimer;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        height = [[UIScreen mainScreen] bounds].size.width;
        width = [[UIScreen mainScreen] bounds].size.height;
        self.backgroundColor = [SKColor whiteColor];
        
        sprite = [SKSpriteNode spriteNodeWithImageNamed:@"doodle100"];
        sprite.xScale=.5;
        sprite.yScale=.5;
        sprite.position = CGPointMake(30, height/2);
        sprite.name=@"dude";
        [self addChild:sprite];

        touchonscreen=NO;
        
        [self addPillar];
        
        genTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(addPillar) userInfo:nil repeats:YES];
        
        scoreTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateScore) userInfo:nil repeats:YES];
        score=0;
        
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        scoreLabel.text=@"0";
        scoreLabel.fontSize=30;
        scoreLabel.fontColor=[SKColor blackColor];
        scoreLabel.position=CGPointMake(70, 250);
        [self addChild:scoreLabel];

    }
    return self;
}
-(void)updateScore{
    score+=1;
    scoreLabel.text=[NSString stringWithFormat:@"%i",score];

}


-(void)addPillar{
    int x = arc4random_uniform(8)+2;
    int y = arc4random_uniform(3)+1;


    SKSpriteNode *pillar = [SKSpriteNode spriteNodeWithImageNamed:@"rectangle32"];
    pillar.name=@"pillar";
    pillar.anchorPoint=CGPointMake(0, 0);
    pillar.xScale=x;
    pillar.yScale=y;

    pillar.position=CGPointMake(self.size.width+3, 0);
    
    

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
            //[self addPillar];
        }
        if ([child.name isEqual:@"pillar"]) {
            child.position=CGPointMake(child.position.x-2, child.position.y);
            if ([child intersectsNode:sprite]) {
               //NSLog(@"collision:%f",sprite.position.y+sprite.frame.size.height/2);
                if (sprite.position.y+sprite.frame.size.height/2>=child.frame.size.height+sprite.frame.size.height/2) {
                    sprite.position=CGPointMake(sprite.position.x, child.frame.size.height+sprite.frame.size.height/2);
                }
                else{
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
