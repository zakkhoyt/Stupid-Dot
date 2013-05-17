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
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        [self initializeInstanceVariables];
    }
    return self;
}

// The point's x and y are floats from (0.0 - 1.0)
-(id)initWithPoint:(CGPoint)point{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
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
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self.running = YES;
    self.date = [NSDate date];
    
}

-(void)stop{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self.running = NO;
}

-(void)process{
    
    if(!self.running){
//        NSLog(@"%s:%d %p Scanner is not running. Returning early.", __FUNCTION__, __LINE__, self);
        return;
    }
    
//    NSLog(@"%s:%d %p", __FUNCTION__, __LINE__, self);

    NSTimeInterval executionTime = [self.date timeIntervalSinceNow] * -1.0;
    float fractionOfSecond = 1/executionTime;
    

    
    
    
    CGPoint nextDot = self.dot.point;
    CGFloat deltaX = self.vector.runRatioPerSecond / fractionOfSecond;
    CGFloat deltaY = self.vector.riseRatioPerSecond / fractionOfSecond;
    nextDot.x += deltaX;
    nextDot.y -= deltaY;
    self.dot.point = nextDot;


    
//    [self processThereminNotesWithX:nextDot.x Y:nextDot.y];
    
    
    
    self.date = [NSDate date];
    
}

-(void)processThereminNotesWithX:(CGFloat)x Y:(CGFloat)y{
    
    // First get the image into your data buffer
    CGImageRef imageRef = [self.image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    
    
    VWWThereminInputAxis* touchX = [VWWThereminInputs touchscreenInput].x;
    float ratioX = x/(float)width;
    if(ratioX <= 0 || ratioX >= 1.0){
        
        [VWWThereminInputs touchscreenInput].x.muted = YES;
    }
    else{
        [VWWThereminInputs touchscreenInput].x.muted = NO;
    }
    NSLog(@"ratioX:%f width:%d height:%d", ratioX, width, height);
    float frequencyX = touchX.frequencyMax * ratioX;
    [VWWThereminInputs touchscreenInput].x.frequency = frequencyX;

    
    VWWThereminInputAxis* touchY = [VWWThereminInputs touchscreenInput].y;
    float ratioY = y/(float)height;
    if(ratioY <= 0 || ratioY >= 1.0){
        [VWWThereminInputs touchscreenInput].y.muted = YES;
    }
    else{
        [VWWThereminInputs touchscreenInput].y.muted = NO;
    };
    
    NSLog(@"ratioY:%f width:%d height:%d", ratioY, width, height);
    float frequencyY = touchY.frequencyMax * ratioY;
    [VWWThereminInputs touchscreenInput].y.frequency = frequencyY;
    
    
}


@end












