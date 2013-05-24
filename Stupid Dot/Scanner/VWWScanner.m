//
//  VWWScanner.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScanner.h"
#import "VWWScannerLine.h"
#import "VWWThereminInputs.h"


@interface VWWScanner ()


@property (nonatomic, strong) VWWScannerLine *progress;
@property (nonatomic, strong) VWWScannerLine *deflection;
@property (nonatomic) BOOL running;
@property (nonatomic, strong) NSDate *date;



//@property (nonatomic) CGPoint previewPoint; // TODO: this doesn't really fit here...... where can we put it?
@end

@implementation VWWScanner

-(id)init{
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        [self initializeInstanceVariables];
    }
    return self;
}

// The point's x and y are floats from (0.0 - 1.0)
-(id)initWithPoint:(CGPoint)point{
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        [self initializeInstanceVariables];
        _dot.point = point;

    }
    return self;
}


-(void)initializeInstanceVariables{
    _dot = [[VWWScannerDot alloc]init];
    _vector = [[VWWScannerVector alloc]init];
    _progress = [[VWWScannerLine alloc]init];
    _deflection = [[VWWScannerLine alloc]init];
    _deflection.color = [UIColor orangeColor];
    _colorAtDot = [UIColor greenColor];
    _borderType = VWWScannerBorderTypeBlack;
    _borderThreshold = 0.5;
    _renderProgressLine = YES;
    _renderDeflectionLine = YES;
    _running = NO;
    
    

    
}

-(NSString*)description{
    return [NSString stringWithFormat:@"\n*********************SCANNER*********************:\n"
            "dot:\n%@"
            "vector:\n%@"
            "progress:\n%@"
            "deflection:\n%@",
            self.dot.description,
            self.vector.description,
            self.progress.description,
            self.deflection.description];
}

-(void)dealloc{
    
}


#pragma mark Private methods






#pragma mark Public methods

-(void)setImage:(UIImage *)image{

}

-(void)setRiseRatio:(float)riseRatio runRatio:(float)runRatio timeInterval:(NSTimeInterval)timeInterval{
    [self.vector setRiseRatio:riseRatio runRatio:runRatio timeInterval:timeInterval];
}

//-(void)setPreviewPoint:(CGPoint)point{
//    _previewPoint = point;
//
//}

-(void)start{
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self.running = YES;
    self.date = [NSDate date];

    VWWThereminInputAxis* touchX = [VWWThereminInputs touchscreenInput].x;
    [touchX start];
    
    VWWThereminInputAxis* touchY = [VWWThereminInputs touchscreenInput].y;
    [touchY start];
    
}

-(void)stop{
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self.running = NO;
    
    VWWThereminInputAxis* touchX = [VWWThereminInputs touchscreenInput].x;
    [touchX stop];
    
    VWWThereminInputAxis* touchY = [VWWThereminInputs touchscreenInput].y;
    [touchY stop];

}

-(void)process{
    
    if(!self.running){
//        NSLog(@"%s:%d %p Scanner is not running. Returning early.", __FUNCTION__, __LINE__, self);
        return;
    }
    
//    NSLog(@"%s:%d %p", __FUNCTION__, __LINE__, self);

    NSTimeInterval executionTime = [self.date timeIntervalSinceNow] * -1.0;
    float fractionOfSecond = 1/executionTime;
    

    
    
    
    CGPoint nextPoint = self.dot.point;
    CGFloat deltaX = self.vector.runRatioPerSecond / fractionOfSecond;
    CGFloat deltaY = self.vector.riseRatioPerSecond / fractionOfSecond;
    nextPoint.x += deltaX;
    nextPoint.y -= deltaY;
    
    if(nextPoint.x >= 1.0){
        [self.vector reverseRun];
        nextPoint.x = 1.0;
    }
    else if (nextPoint.x <= 0.0){
        [self.vector reverseRun];
        nextPoint.x = 0.0;
    }
    
    if(nextPoint.y >= 1.0){
        [self.vector reverseRise];
        nextPoint.y = 1.0;
    }
    else if(nextPoint.y <= 0.0){
        [self.vector reverseRise];
        nextPoint.y = 0.0;
    }

    self.dot.point = nextPoint;
    
    if(self.scannerImage){
        self.colorAtDot = [self.scannerImage colorFromImageAtX:nextPoint.x andY:nextPoint.y];

        float red, green, blue, alpha = 0;
        [self.colorAtDot getRed:&red green:&green blue:&blue alpha:&alpha];
        
    
        VWWThereminInputAxis* touchX = [VWWThereminInputs touchscreenInput].x;
        VWWThereminInputAxis* touchY = [VWWThereminInputs touchscreenInput].y;
        
        
//        // By position
//        float frequencyX = touchX.frequencyMax * self.dot.point.x;
//        float frequencyY = touchY.frequencyMax * (1.0 - self.dot.point.y);
 
        // By red and green
        float frequencyX = touchX.frequencyMax * red;
        float frequencyY = touchY.frequencyMax * 1.333333 * green;
        
        
        
        
        
        
        touchX.muted = NO;
        touchY.muted = NO;
        [VWWThereminInputs touchscreenInput].x.frequency = frequencyX;
        [VWWThereminInputs touchscreenInput].y.frequency = frequencyY;
    }
    
    //[self processThereminFrequenciesFromPoint];
    
    self.date = [NSDate date];
}

-(void)processThereminFrequenciesFromPoint{

    VWWThereminInputAxis* touchX = [VWWThereminInputs touchscreenInput].x;
    float frequencyX = touchX.frequencyMax * self.dot.point.x;
    [VWWThereminInputs touchscreenInput].x.frequency = frequencyX;

    VWWThereminInputAxis* touchY = [VWWThereminInputs touchscreenInput].y;
    float frequencyY = touchY.frequencyMax * (1.0 - self.dot.point.y);
    [VWWThereminInputs touchscreenInput].y.frequency = frequencyY;
    
    // If we've gone off the view, mute both channels;
    if(self.dot.point.x <= 0 || self.dot.point.x >= 1.0 ||
       self.dot.point.y <= 0 || self.dot.point.y >= 1.0){
//        [VWWThereminInputs touchscreenInput].x.muted = YES;
//        [VWWThereminInputs touchscreenInput].y.muted = YES;
    }
    else{
        [VWWThereminInputs touchscreenInput].x.muted = NO;
        [VWWThereminInputs touchscreenInput].y.muted = NO;
    }

    
    
    
    //NSLog(@"self.dot.point x:%f y:%f", self.dot.point.x, self.dot.point.y);
    
}


@end












