//
//  VWWScannerVector.m
//  EZScanner
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerVector.h"

@implementation VWWScannerVector

-(id)init{
    self = [super init];
    if(self){
        self.angle = 0;
        self.speed = 10;
    }
    return self;
}

#pragma mark Private methods
#pragma mark Public methods

@end
