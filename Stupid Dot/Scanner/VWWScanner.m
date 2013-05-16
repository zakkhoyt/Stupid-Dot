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
@property (nonatomic) BOOL running;


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
    _renderProgressLine = YES;
    _renderDeflectionLine = YES;
    _running = NO;
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

-(void)setBeginPoint:(CGPoint)beginPoint endPoint:(CGPoint)endPoint timeInterval:(NSTimeInterval)timeInterval{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    [self.vector updateAngleWithBeginPoint:beginPoint endPoint:endPoint];

    CGFloat rise = abs(endPoint.x - beginPoint.x);
    CGFloat run = abs(endPoint.y - beginPoint.y);
    CGFloat distance = sqrt(rise*rise + run*run);
    self.vector.speed = distance / timeInterval;
    

}

//-(void)setPreviewPoint:(CGPoint)point{
//    _previewPoint = point;
//
//}

-(void)start{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self.running = YES;
}

-(void)stop{
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self.running = NO;
}

-(void)process{
    
    if(!self.running){
        NSLog(@"%s:%d %p Scanner is not running. Returning early.", __FUNCTION__, __LINE__, self);
        return;
    }
    
    NSLog(@"%s:%d %p", __FUNCTION__, __LINE__, self);
    
    
    
    

    
    
//    NSTimeInterval executionTime = [self.lastProcessDate timeIntervalSinceNow] * -1000.0;
//    self.lastProcessDate = [NSDate date];
    
}

@end
