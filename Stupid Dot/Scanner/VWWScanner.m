//
//  VWWScanner.m
//  EZScanner
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScanner.h"

@interface VWWScanner ()

@end

@implementation VWWScanner

-(id)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

#pragma mark Private methods

-(void)asdfsad{
    //    CGPoint p1 = CGPointMake(1, 25);
    //    CGPoint p2 = CGPointMake(5, 0);
    //    CGPoint p1 = CGPointMake(0, 5);
    //    CGPoint p2 = CGPointMake(12, 24);
    CGPoint p1 = CGPointMake(1, 1);
    CGPoint p2 = CGPointMake(3, 25);
    
    
    NSInteger rise = p2.x - p1.x;
    NSInteger run = -(p2.y - p1.y);
    float theta = atan2f(rise, run);
    float angleDegrees = theta * 180 / M_PI;
    NSLog(@"%f radians = %f degrees", theta, angleDegrees);
    
}



#pragma mark Public methods
@end
