//
//  VWWScannerImage.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWScannerImage : NSObject


-(id)initWithImage:(UIImage*)image;

// x and y are in range (0.0 .. 1.0)
- (UIColor*)colorFromImageAtX:(float)x andY:(float)y;
@end
