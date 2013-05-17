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
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        _point = CGPointMake(0, 0);
        _radius = 10.0;
//        _fillColor = [UIColor redColor];
//        _borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _fillColor = [self randomColor];
        _borderColor = [self randomColor];

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

- (UIColor *) randomColor {
    return [UIColor colorWithRed:(random()%100)/(float)100 green:(random()%100)/(float)100 blue:(random()%100)/(float)100 alpha:1];
}


#pragma mark Public methods


@end
