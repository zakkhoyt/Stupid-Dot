//
//  VWWScannerTarget.m
//  EZScanner
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerTarget.h"

@interface VWWScannerTarget ()
@property (nonatomic, strong) NSMutableArray *scanners;
@end

@implementation VWWScannerTarget
+(VWWScannerTarget*)sharedInstance{
    static VWWScannerTarget *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWScannerTarget alloc]init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        _scanners = [@[]mutableCopy];
    }
    return self;
}


#pragma mark Private methods


#pragma mark Public methods

-(void)setImage:(UIImage*)image{
    
}

-(void)addScanner:(VWWScanner*)scanner{
    
}

-(void)removeScanner:(VWWScanner*)scanner{
    
}


@end
