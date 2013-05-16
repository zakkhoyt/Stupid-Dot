//
//  VWWScannerDot.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWScannerDot : NSObject
@property (nonatomic) CGPoint point;
@property (nonatomic) CGFloat radius;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *borderColor;
@end
