//
//  VWWScannerVector.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerVector.h"

@interface VWWScannerVector ()
@property (nonatomic) float risePixelsPerSecond;           // (0,0 is upper left)
@property (nonatomic) float runPixelsPerSecond;            //
@property (nonatomic) float hypoteneusePixelsPerSecond;    // How fast the dot is moving in pixels per second
@property (nonatomic) float angle;                          // 0 is up, 90 is right
@end

@implementation VWWScannerVector

-(id)init{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        self.risePixelsPerSecond = 7;
        self.runPixelsPerSecond = 7;
        self.hypoteneusePixelsPerSecond = 49;
        self.angle = 0;
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"\trisePixelsPerSecond=%f\n"
            @"\trunPixelsPerSecond=%f\n"
            @"\thypoteneusePixelsPerSecond=%f\n"
            @"\tangle=%f\n",
            self.risePixelsPerSecond,
            self.runPixelsPerSecond,
            self.hypoteneusePixelsPerSecond,
            self.angle];
}


#pragma mark Private methods
//-(void)updateAngleWithBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint{
//    self.risePixelsPerSecond = endPoint.x - beginPoint.x;
//    self.runPixelsPerSecond = endPoint.y - beginPoint.y;
//    
//    NSLog(@"risePixelsPerSecond:%f runPixelsPerSecond:%f", self.risePixelsPerSecond, self.runPixelsPerSecond);
//    float angleInRadians = atan2f(self.risePixelsPerSecond, -self.runPixelsPerSecond);
//    if(self.risePixelsPerSecond < 0){
//        angleInRadians += 2*M_PI;
//    }
//    float angleInDegrees = angleInRadians * 180 / M_PI;
//    self.angle = angleInDegrees;
//    NSLog(@"Updated vector angle: %fr %fd", angleInRadians, angleInDegrees);
//}
#pragma mark Public methods



-(void)setBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint timeInterval:(NSTimeInterval)timeInterval{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    

    
    self.risePixelsPerSecond = (endPoint.x - beginPoint.x) / timeInterval;
    self.runPixelsPerSecond = (endPoint.y - beginPoint.y) / timeInterval;
    self.hypoteneusePixelsPerSecond = sqrt(pow(abs(self.risePixelsPerSecond), 2) + pow(abs(self.runPixelsPerSecond), 2)) / timeInterval;
    
    NSLog(@"risePixelsPerSecond:%f runPixelsPerSecond:%f", self.risePixelsPerSecond, self.runPixelsPerSecond);
    float angleInRadians = atan2f(self.risePixelsPerSecond, -self.runPixelsPerSecond);
    if(self.risePixelsPerSecond < 0){
        angleInRadians += 2*M_PI;
    }
    float angleInDegrees = angleInRadians * 180 / M_PI;
    self.angle = angleInDegrees;
    
    // swap rise and run
    float temp = self.runPixelsPerSecond;
    self.runPixelsPerSecond = self.risePixelsPerSecond;
    self.risePixelsPerSecond = temp;
    
    NSLog(@"Updated vector angle: %fr %fd", angleInRadians, angleInDegrees);
    
    
}



@end
