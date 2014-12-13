//
//  RTPathView.m
//  Race to the Top
//
//  Created by Matthew Linaberry on 12/12/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import "RTPathView.h"
#import "RTMountainPath.h"
@implementation RTPathView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.bounds])
    {
        [[UIColor blackColor] setStroke];
        [path stroke];
    }
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

-(void) setup
{
    self.backgroundColor = [UIColor clearColor];
}
@end
