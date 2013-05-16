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
        _dotPoint = CGPointMake(0, 0);
        _dotRadius = 5.0;
        _dotFillColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _dotBorderColor = [UIColor redColor];
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"\tdotPoint=%@\n"
            "\tdotRadius=%f\n"
            "\tdotFillColor=%@\n"
            "\tdotBorderColor=%@\n",
            NSStringFromCGPoint(self.dotPoint),
            self.dotRadius,
            self.dotFillColor.description,
            self.dotBorderColor.description];
}

#pragma mark Private methods
#pragma mark Public methods


@end
