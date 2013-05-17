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
    _borderType = VWWScannerBorderTypeBlack;
    _borderThreshold = 0.5;
    _renderProgressLine = YES;
    _renderDeflectionLine = YES;
    _running = NO;
    
    
//    VWWThereminInputs *inputs = [[VWWThereminInputs alloc]init];
//    VWWThereminInput* touchScreenDevice = inputs.inputs[kKeyTouchScreen];
//    VWWThereminInputAxis* touchX = touchScreenDevice.x;
//    touchX.waveType = kWaveSawtooth;
//    VWWThereminInputAxis* touchY = touchScreenDevice.y;
//    touchY.waveType = kWaveSawtooth;
    

    
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

- (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
    for (int ii = 0 ; ii < count ; ++ii)
    {
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
        
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [result addObject:acolor];
    }
    
    free(rawData);
    
    return result;
}


#pragma mark Public methods

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
    [self processThereminFrequenciesFromPoint];
    
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












