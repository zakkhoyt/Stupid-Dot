//
//  VWWScannerLine.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWScannerLine : NSObject
@property (nonatomic) CGPoint lineBegin;
@property (nonatomic) CGPoint lineEnd;
@property (nonatomic) CGFloat lineRadius;
@property (nonatomic, strong) UIColor *lineColor;
@end
