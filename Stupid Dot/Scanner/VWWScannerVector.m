//
//  VWWScannerVector.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerVector.h"

@interface VWWScannerVector ()
@property (nonatomic) float riseRatioPerSecond;           // (0,0 is upper left)
@property (nonatomic) float runRatioPerSecond;            //
@property (nonatomic) float hypoteneuseRatioPerSecond;    // How fast the dot is moving in pixels per second
@property (nonatomic) float angle;                          // 0 is up, 90 is right
@end

@implementation VWWScannerVector

-(id)init{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        self.riseRatioPerSecond = 7;
        self.runRatioPerSecond = 7;
        self.hypoteneuseRatioPerSecond = 49;
        self.angle = 0;
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"\triseRatioPerSecond=%f\n"
            @"\trunRatioPerSecond=%f\n"
            @"\thypoteneuseRatioPerSecond=%f\n"
            @"\tangle=%f\n",
            self.riseRatioPerSecond,
            self.runRatioPerSecond,
            self.hypoteneuseRatioPerSecond,
            self.angle];
}


#pragma mark Private methods

#pragma mark Public methods


-(void)setRiseRatio:(float)riseRatio runRatio:(float)runRatio timeInterval:(NSTimeInterval)timeInterval{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    
    self.riseRatioPerSecond = -(riseRatio / timeInterval);
    self.runRatioPerSecond = runRatio / timeInterval;
    self.hypoteneuseRatioPerSecond = sqrt(pow(abs(riseRatio), 2) + pow(abs(runRatio), 2)) / timeInterval;
    
    NSLog(@"riseRatioPerSecond:%f runRatioPerSecond:%f", self.riseRatioPerSecond, self.runRatioPerSecond);
    float angleInRadians = atan2f(self.riseRatioPerSecond, self.runRatioPerSecond);
    if(self.riseRatioPerSecond < 0){
        angleInRadians += 2*M_PI;
    }
    float angleInDegrees = angleInRadians * 180 / M_PI;
    self.angle = angleInDegrees;
    
//    // swap rise and run
//    float temp = self.runRatioPerSecond;
//    self.runRatioPerSecond = self.riseRatioPerSecond;
//    self.riseRatioPerSecond = temp;
    
    NSLog(@"Updated vector angle: %fr %fd", angleInRadians, angleInDegrees);
    
    
}



@end
