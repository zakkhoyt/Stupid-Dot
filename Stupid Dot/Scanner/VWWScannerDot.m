//
//  VWWScannerDot.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerDot.h"

@implementation VWWScannerDot
-(id)init{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        _point = CGPointMake(0, 0);
        _radius = 8.0;
        _fillColor = [UIColor redColor];
        _borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"\troint=%@\n"
            "\tradius=%f\n"
            "\tfillColor=%@\n"
            "\tborderColor=%@\n",
            NSStringFromCGPoint(self.point),
            self.radius,
            self.fillColor.description,
            self.borderColor.description];
}

#pragma mark Private methods
#pragma mark Public methods


@end
