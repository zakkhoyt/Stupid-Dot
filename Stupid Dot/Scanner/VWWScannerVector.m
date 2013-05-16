//
//  VWWScannerVector.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerVector.h"

@implementation VWWScannerVector

-(id)init{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        self.angle = 0;
        self.speed = 10;
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"angle=%f\n"
            "speed=%f\n",
            self.angle,
            self.speed];
}


#pragma mark Private methods

#pragma mark Public methods
-(void)updateAngleWithBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint{
    NSInteger rise = endPoint.x - beginPoint.x;
    NSInteger run = -(endPoint.y - beginPoint.y);
    float angleInRadians = atan2f(rise, run);
    float angleInDegrees = angleInRadians * 180 / M_PI;
    NSLog(@"Updated vector angle: %f", angleInDegrees);
}
@end
