//
//  VWWScanner.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum{
    VWWScannerBorderTypeBlack = 0,
    VWWScannerBorderTypeRed = 1,
    VWWScannerBorderTypeBlue = 2,
    VWWScannerBorderTypeGreen = 3,
} VWWScannerBorderType;

@interface VWWScanner : NSObject
@property (nonatomic) VWWScannerBorderType *borderType;
@property (nonatomic) float borderThreshold;
-(id)initWithPoint:(CGPoint)point;
-(void)setBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint timeInterval:(NSTimeInterval)timeInterval;
@end
