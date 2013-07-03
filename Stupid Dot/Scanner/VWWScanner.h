//
//  VWWScanner.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWScannerDot.h"
#import "VWWScannerVector.h"
#import "VWWScannerImage.h"

typedef enum{
    VWWScannerBorderTypeBlack = 0,
    VWWScannerBorderTypeRed = 1,
    VWWScannerBorderTypeBlue = 2,
    VWWScannerBorderTypeGreen = 3,
} VWWScannerBorderType;

typedef enum{
    VWWScannerReactionTypeFollowLeft = 0,
    VWWScannerReactionTypeFollowRight = 1,
    VWWScannerReactionTypeBounce = 2,
} VWWScannerReactionType;;

@interface VWWScanner : NSObject
@property (nonatomic, strong) VWWScannerDot *dot;
@property (nonatomic, strong) VWWScannerVector *vector;
@property (nonatomic) VWWScannerBorderType *borderType;
@property (nonatomic) VWWScannerReactionType *reactionType;
@property (nonatomic) float borderThreshold;
@property (nonatomic) BOOL renderProgressLine;
@property (nonatomic) BOOL renderDeflectionLine;
@property (nonatomic, weak) VWWScannerImage *scannerImage;
@property (nonatomic) float framesPerSecond;
@property (nonatomic, strong) UIColor *colorAtDot;

-(id)initWithPoint:(CGPoint)point;
-(void)setRiseRatio:(float)riseRatio runRatio:(float)runRatio timeInterval:(NSTimeInterval)timeInterval;

//-(void)setPreviewPoint:(CGPoint)point;
-(void)start;
-(void)stop;
-(void)process;
@end
