//
//  RTMountainPath.h
//  Race to the Top
//
//  Created by Matthew Linaberry on 12/12/14.
//  Copyright (c) 2014 Matthew Linaberry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface RTMountainPath : NSObject

+(NSArray *)mountainPathsForRect:(CGRect)rect;
+(UIBezierPath *)tapTargetForPath:(UIBezierPath *)path;
@end
