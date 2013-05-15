//
//  VWWScannerTarget.h
//  EZScanner
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWScanner.h"

@interface VWWScannerTarget : NSObject

+(VWWScannerTarget*)sharedInstance;
-(void)setImage:(UIImage*)image;
-(void)addScanner:(VWWScanner*)scanner;
-(void)removeScanner:(VWWScanner*)scanner;

@end
