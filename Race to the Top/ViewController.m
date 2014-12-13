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
@interface ViewController ()
@property (strong, nonatomic) IBOutlet RTPathView *pathView;

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
    for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.pathView.bounds])
    {
        UIBezierPath *tapTarget = [RTMountainPath tapTargetForPath:path];
        if ([tapTarget containsPoint:fingerLocation])
        {
            NSLog(@"You banged your head into the wall!!!");
        }
        
    }
}

@end
