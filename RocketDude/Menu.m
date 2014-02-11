//
//  MyScene.m
//  MyFirstGame
//
//  Created by Dilawar Zaman on 6/11/13.
//  Copyright (c) 2013 Dilawar Zaman. All rights reserved.
//

#import "Menu.h"
#import "MyScene.h"
@implementation Menu

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        height = [[UIScreen mainScreen] bounds].size.width;
        width = [[UIScreen mainScreen] bounds].size.height;

        self.backgroundColor = [SKColor whiteColor];
        
        play =[SKSpriteNode spriteNodeWithImageNamed:@"Play2.png"];
        //SaveAndExit.frame=CGRectMake(self.size.width/2, self.size.height/2, 100, 50);
        play.anchorPoint=CGPointMake(1, 1);
        play.position=CGPointMake(width,height);
        play.xScale=.5;
        play.yScale=.5;

        [self addChild:play];
        
        
       SKSpriteNode *gamecenter =[SKSpriteNode spriteNodeWithImageNamed:@"GameCenter.png"];
        //SaveAndExit.frame=CGRectMake(self.size.width/2, self.size.height/2, 100, 50);
        gamecenter.anchorPoint=CGPointMake(1, 0);
        gamecenter.position=CGPointMake(width,0);
        gamecenter.xScale=.5;
        gamecenter.yScale=.5;
        
        [self addChild:gamecenter];
        
       SKSpriteNode *name =[SKSpriteNode spriteNodeWithImageNamed:@"Name.png"];
        //SaveAndExit.frame=CGRectMake(self.size.width/2, self.size.height/2, 100, 50);
        name.anchorPoint=CGPointMake(0, 0);
        name.position=CGPointMake(0,self.size.height/2+30);
        name.xScale=.85;
        name.yScale=.85;
        [self addChild:name];

        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        
        glow=[self NewTouch];
        glow.position=location;
        glow.name=@"touchglow";
        [self addChild:glow];
        
        
        
        
        
        
      
    }
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        glow.position=location;
        
    }
    
    
}

-(void)touchesEnded: (NSSet *)touches
          withEvent: (UIEvent *)event {
    
    
    for (SKNode *child in self.children) {
        if ([child.name isEqualToString:@"touchglow"]) {
            [child removeFromParent];
        }
    }
  

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    if (CGRectContainsPoint(play.frame, location)) {
        SKView *skView = (SKView *)self.view;
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        [self presentGameScene];
    }
}

-(void)presentGameScene{
    NSLog(@"menu is presented");
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    
    SKScene * spaceshipScene = [MyScene sceneWithSize:skView.bounds.size];
    
    SKTransition *doors = [SKTransition
                           doorsOpenVerticalWithDuration:0.5];
    [self.view presentScene:spaceshipScene transition:doors];
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
}
- (SKEmitterNode*) NewTouch
{
    NSString *spark = [[NSBundle mainBundle] pathForResource:@"TouchLocation"
                                                      ofType:@"sks"];
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:spark];
    return smoke;
}

@end
