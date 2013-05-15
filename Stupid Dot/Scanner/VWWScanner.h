//
//  VWWScanner.h
//  EZScanner
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWScannerVector.h"
#import "VWWScannerDot.h"
#import "VWWScannerLine.h"


typedef enum{
    VWWScannerBorderTypeBlack = 0,
    VWWScannerBorderTypeRed = 1,
    VWWScannerBorderTypeBlue = 2,
    VWWScannerBorderTypeGreen = 3,
} VWWScannerBorderType;

@interface VWWScanner : NSObject
@property (nonatomic, strong) VWWScannerDot *dot;
@property (nonatomic, strong) VWWScannerVector *vector;
@property (nonatomic, strong) VWWScannerLine *progress;
@property (nonatomic, strong) VWWScannerLine *deflection;
@property (nonatomic) VWWScannerBorderType *borderType;
@property (nonatomic) float borderThreshold;
@end
