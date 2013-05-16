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
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        _lineBegin = CGPointZero;
        _lineEnd = CGPointZero;
        _lineRadius = 1.0;
        _lineColor = [UIColor blueColor];
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"\tlineBegin=%@\n"
            "\tlineEnd=%@\n"
            "\tlineRadius=%f\n"
            "\tlineColor=%@\n",
            NSStringFromCGPoint(self.lineBegin),
            NSStringFromCGPoint(self.lineEnd),
            self.lineRadius,
            self.lineColor.description];
}

#pragma mark Private methods
#pragma mark Public methods

@end
