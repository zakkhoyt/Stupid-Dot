//
//  VWWScannerVector.h
//  EZScanner
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWScannerVector : NSObject
@property (nonatomic) float angle;     // 0 is up, 90 is right
@property (nonatomic) float speed;     // How fast the dot is moving in pixels per second
@end
