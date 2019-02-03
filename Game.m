//
//  Game.m
//  Flappy Bird
//
//  Created by Muhd Hizam.
//  Copyright (c) 2014 Muhd Hizam. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

-(void)GameOver {
 
    if (ScoreNumber > HighScoreNumber) {
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSaved"];
    }
    
    [TunnelMovement invalidate];
    [BirdMovement invalidate];
    
    Exit.hidden = NO;
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    Bird.hidden = YES;
    
}


-(void)Score {
    
    ScoreNumber = ScoreNumber + 1;
    ScoreLabel.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
}


-(IBAction)StartGame:(id)sender {

    TunnelTop.hidden = NO;
    TunnelBottom.hidden = NO;
    
    StartGame.hidden = YES;
    
    BirdMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BirdMoving) userInfo:nil repeats:YES];
    
    [self PlaceTunnels]; //Telling xcode to run the method PlaceTunnels when game starts
    
    TunnelMovement = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(TunnelMoving) userInfo:nil repeats:YES]; //Telling xcode to run the method TunnelMovement every 0.001s

    
}

//Method to tell xcode to regenerate and move the tunnels
-(void)TunnelMoving {
    
    TunnelTop.center = CGPointMake(TunnelTop.center.x - 1, TunnelTop.center.y);
    TunnelBottom.center = CGPointMake(TunnelBottom.center.x - 1, TunnelBottom.center.y);
    
    if (TunnelTop.center.x < -28) {
        [self PlaceTunnels];
    }
    
    if (TunnelTop.center.x == 30) {
        [self Score];
    }
    
    if (CGRectIntersectsRect(Bird.frame, TunnelTop.frame)) {
        [self GameOver];
    }
    
    if (CGRectIntersectsRect(Bird.frame, TunnelBottom.frame)) {
        [self GameOver];
    }
    
    if (CGRectIntersectsRect(Bird.frame, Top.frame)) {
        [self GameOver];
    }
    
    if (CGRectIntersectsRect(Bird.frame, Bottom.frame)) {
        [self GameOver];
    }
    
}


//Method to tell xcode where to position the tunnels
-(void)PlaceTunnels {
    
    RandomTopTunnelPosition = arc4random() %350;
    RandomTopTunnelPosition = RandomTopTunnelPosition - 228; //Set the range for the Top Tunnel between -228 and 122
    RandomBottomTunnelPosition = RandomTopTunnelPosition + 700; //Set the gap between the Top and Bottom tunnel position 655
    
    TunnelTop.center = CGPointMake(340, RandomTopTunnelPosition);
    TunnelBottom.center = CGPointMake(340, RandomBottomTunnelPosition);
}


-(void)BirdMoving {
    
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFlight);
    BirdFlight = BirdFlight - 5;
    
    if (BirdFlight < - 15) {
        BirdFlight = -15;
    }
    
    if (BirdFlight > 0) {
        Bird.image = [UIImage imageNamed:@"BirdUp.png"];
    }
    
    if (BirdFlight < 0) {
        Bird.image = [UIImage imageNamed:@"BirdDown.png"];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    BirdFlight = 20;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//The code that runs as soon as the viewDid loads up
- (void)viewDidLoad
{
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    
    Exit.hidden = YES;
    ScoreNumber = 0;
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
