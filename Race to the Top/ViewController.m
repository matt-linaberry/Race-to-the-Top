//
//  ViewController.m
//  Race to the Top
//
//  Created by Matthew Linaberry on 12/11/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import "ViewController.h"
#import "RTPathView.h"
#import "RTMountainPath.h"

#define RTMAP_STARTING_SCORE 15000
#define RTMAP_SCORE_DECREMENT_AMOUNT 100
#define RTTIMER_INTERVAL 0.1
#define RTWALL_PENALTY 500

@interface ViewController ()
@property (strong, nonatomic) IBOutlet RTPathView *pathView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.pathView addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", RTMAP_STARTING_SCORE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"Tapped!");
    
    // where is the tap?
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    NSLog(@"Tap location %f, %f", tapLocation.x, tapLocation.y);
}

- (void) panDetected:(UIPanGestureRecognizer *) panRecognizer
{
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y < 750)
    {
        //start this up.
        self.timer = [NSTimer scheduledTimerWithTimeInterval:RTTIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", RTMAP_STARTING_SCORE];
    }
    else if (panRecognizer.state == UIGestureRecognizerStateChanged)
    {
        for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.pathView.bounds])
        {
            UIBezierPath *tapTarget = [RTMountainPath tapTargetForPath:path];
            if ([tapTarget containsPoint:fingerLocation])
            {
                [self decrementScoreByAmount:RTWALL_PENALTY];
            }
            
        }
    }
    else if (panRecognizer.state == UIGestureRecognizerStateEnded && fingerLocation.y <= 165)
    {
        [self.timer invalidate]; // cancel the timer
        self.timer = nil;  //release it
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please start at the bottom of the path and keep your finger held down, cheater!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [self.timer invalidate];
        self.timer = nil;
    }

}

-(void) timerFired
{
    [self decrementScoreByAmount:RTMAP_SCORE_DECREMENT_AMOUNT];
}

-(void) decrementScoreByAmount:(int)amount
{
    NSString *scoreText = [[self.scoreLabel.text componentsSeparatedByString:@" "] lastObject];  // this will return the LAST token in this string!
    //convert to int
    int score = [scoreText intValue];
    score = score - amount;
    NSString *newScoreText = [self.scoreLabel.text stringByReplacingOccurrencesOfString:scoreText withString:[NSString stringWithFormat:@"%i", score]];
    self.scoreLabel.text = newScoreText;
}
@end
