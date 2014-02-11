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
        scoreLabel.position=CGPointMake(width-scoreLabel.frame.size.width, height-60);
        [self addChild:scoreLabel];

        SKShapeNode *red = [SKShapeNode node];
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 1, height-1);
        CGPathAddLineToPoint(path, NULL, 1, height-30.0);
        CGPathAddLineToPoint(path, NULL, width-1, height-30.0);
        CGPathAddLineToPoint(path, NULL, width-1, height-1);
        CGPathAddLineToPoint(path, NULL, 1, height-1);
        red.path = path;
        [red setStrokeColor:[UIColor blackColor]];
        red.fillColor=[SKColor redColor];
        CGPathRelease(path);
        [self addChild:red];
    
        green = [SKShapeNode node];
        CGMutablePathRef battery = CGPathCreateMutable();
        CGPathMoveToPoint(battery, NULL, 1, height-1);
        CGPathAddLineToPoint(battery, NULL, 1, height-30.0);
        CGPathAddLineToPoint(battery, NULL, width-1, height-30.0);
        CGPathAddLineToPoint(battery, NULL, width-1, height-1);
        CGPathAddLineToPoint(battery, NULL, 1, height-1);
        green.path = battery;
        [green setStrokeColor:[UIColor blackColor]];
        green.fillColor=[SKColor greenColor];
        //CGPathRelease(battery);
        [self addChild:green];
        batterylife=1;
        
        onPlatform=NO;
    }
    return self;
}



-(void)updateScore{
    score+=1;
    scoreLabel.text=[NSString stringWithFormat:@"%i",score];
    
    if (onPlatform)
            batterylife+=.2;
    
    else if(!onPlatform)
            batterylife-=.2;
    
    if (batterylife>1) {
        batterylife=1;
    }
    green.xScale=batterylife;
    
    if(batterylife<0){
        [self endgame];
    }

}


-(void)addPillar{
    int x = arc4random_uniform(8)+2;
    int y = arc4random_uniform(2)+2;


    SKSpriteNode *pillar = [SKSpriteNode spriteNodeWithImageNamed:@"black"];
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
    
    if (sprite.position.y+sprite.frame.size.height/2>height-30) {
        sprite.position=CGPointMake(sprite.position.x, height-sprite.frame.size.height/2-30);
    }
    
    if (sprite.position.y-sprite.frame.size.height/2<0) {
        [self endgame];
    }
    /* Called before each frame is rendered */
    onPlatform=NO;

           if (touchonscreen) {
        sprite.position=CGPointMake(sprite.position.x, sprite.position.y+5);

    }
    else{
        sprite.position=CGPointMake(sprite.position.x, sprite.position.y-7);
    }

    for (SKNode *child in self.children) {
        if (child.position.x<-child.frame.size.width) {
            [child removeFromParent];
            //[self addPillar];
        }
        if ([[child.name substringToIndex:4] isEqual:@"pill"]) {
            
            child.position=CGPointMake(child.position.x-5, child.position.y);
            if ([child intersectsNode:sprite]) {
               //NSLog(@"collision:%f",sprite.position.y+sprite.frame.size.height/2);
                if (sprite.position.y+sprite.frame.size.height/2>=child.frame.size.height+sprite.frame.size.height/2) {
                   sprite.position=CGPointMake(sprite.position.x, child.frame.size.height+sprite.frame.size.height/2);
                    onPlatform=YES;
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
    [genTimer invalidate];
    [scoreTimer invalidate];
    UILabel *GameOver=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.height/2, self.view.frame.size.width/2, 150, 20)];
    GameOver.text=@"Game Over";
    [GameOver setTextColor:[UIColor blackColor]];
    [self.view addSubview:GameOver];
    
}
@end
