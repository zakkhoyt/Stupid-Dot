//
//  VWWScannerLine.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerLine.h"

@implementation VWWScannerLine
-(id)init{
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        _beginPoint = CGPointZero;
        _endPoint = CGPointZero;
        _radius = 1.0;
        _color = [UIColor blueColor];
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"\tbeginPoint=%@\n"
            "\tendPoint=%@\n"
            "\tradius=%f\n"
            "\tcolor=%@\n",
            NSStringFromCGPoint(self.beginPoint),
            NSStringFromCGPoint(self.endPoint),
            self.radius,
            self.color.description];
}

#pragma mark Private methods
#pragma mark Public methods

@end
