//
//  VWWScannerVector.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWScannerVector : NSObject
@property (nonatomic, readonly) float riseRatioPerSecond;           // (0,0 is upper left)
@property (nonatomic, readonly) float runRatioPerSecond;            //
@property (nonatomic, readonly) float hypoteneuseRatioPerSecond;    // How fast the dot is moving in pixels per second
@property (nonatomic, readonly) float angle;                          // 0 right, 90 is straight up, etc...
-(void)setRiseRatio:(float)riseRatio runRatio:(float)runRatio timeInterval:(NSTimeInterval)timeInterval;
-(void)reverseRise;
-(void)reverseRun;
@end
