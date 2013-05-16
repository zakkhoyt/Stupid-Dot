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
        _dotColor = [UIColor redColor];
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"dotPoint=%@\n"
            "dotRadius=%f\n"
            "dotColor=%@\n",
            NSStringFromCGPoint(self.dotPoint),
            self.dotRadius,
            self.dotColor.description];
}

#pragma mark Private methods
#pragma mark Public methods


@end
