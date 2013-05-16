//
//  VWWScannerLine.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWScannerLine : NSObject
@property (nonatomic) CGPoint beginPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGFloat radius;
@property (nonatomic, strong) UIColor *color;
@end
