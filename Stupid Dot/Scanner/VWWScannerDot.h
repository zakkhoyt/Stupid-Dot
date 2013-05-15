//
//  VWWScannerDot.h
//  EZScanner
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWScannerDot : NSObject
@property (nonatomic) CGPoint dotPoint;
@property (nonatomic) CGFloat dotRadius;
@property (nonatomic, strong) UIColor *dotColor;
@end
