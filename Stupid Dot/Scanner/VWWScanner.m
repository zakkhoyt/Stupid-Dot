//
//  VWWScanner.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScanner.h"
#import "VWWScannerVector.h"
#import "VWWScannerDot.h"
#import "VWWScannerLine.h"

@interface VWWScanner ()
@property (nonatomic, strong) VWWScannerDot *dot;
@property (nonatomic, strong) VWWScannerVector *vector;
@property (nonatomic, strong) VWWScannerLine *progress;
@property (nonatomic, strong) VWWScannerLine *deflection;
@end

@implementation VWWScanner

-(id)init{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        [self initializeInstanceVariables];
    }
    return self;
}

-(id)initWithPoint:(CGPoint)point{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        [self initializeInstanceVariables];
        _dot.dotPoint = point;
    }
    return self;
}


-(void)initializeInstanceVariables{
    _dot = [[VWWScannerDot alloc]init];
    _vector = [[VWWScannerVector alloc]init];
    _progress = [[VWWScannerLine alloc]init];
    _deflection = [[VWWScannerLine alloc]init];
    _borderType = VWWScannerBorderTypeBlack;
    _borderThreshold = 0.5;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"dot=%@\n"
            "vector=%@\n"
            "progress=%@\n"
            "deflection=%@\n",
            self.dot.description,
            self.vector.description,
            self.progress.description,
            self.deflection.description];
}


#pragma mark Private methods
-(void)updateVector{

    
}




#pragma mark Public methods
-(void)setBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint timeInterval:(NSTimeInterval)timeInterval{
    [self.vector updateAngleWithBeginPoint:beginPoint endPoint:endPoint];
    // TODO: calculate speed and set it on the vector here
}
@end
