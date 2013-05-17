//
//  VWWScannerVector.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWScannerVector : NSObject
@property (nonatomic, readonly) float risePixelsPerSecond;           // (0,0 is upper left)
@property (nonatomic, readonly) float runPixelsPerSecond;            //
@property (nonatomic, readonly) float hypoteneusePixelsPerSecond;    // How fast the dot is moving in pixels per second
@property (nonatomic, readonly) float angle;                          // 0 is up, 90 is right
-(void)setBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint timeInterval:(NSTimeInterval)timeInterval;
@end
