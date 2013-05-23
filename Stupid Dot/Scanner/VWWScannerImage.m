//
//  VWWScannerImage.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerImage.h"

@interface VWWScannerImage (){
    UIImage         *_image;
    CGImageRef      _imageRef;
    NSUInteger      _width;
    NSUInteger      _height;
    CGColorSpaceRef _colorSpace;
    unsigned char   *_rawData;
    NSUInteger      _bytesPerPixel;
    NSUInteger      _bytesPerRow;
    NSUInteger      _bitsPerComponent;
    CGContextRef    _context;
}
//@property (nonatomic, strong) UIImage *image;
//@property (nonatomic) CGImageRef imageRef;
//@property (nonatomic) NSUInteger width;
//@property (nonatomic) NSUInteger height;
//@property (nonatomic) CGColorSpaceRef colorSpace;
//@property (nonatomic) unsigned char *rawData;
//@property (nonatomic) NSUInteger bytesPerPixel;
//@property (nonatomic) NSUInteger bytesPerRow;
//@property (nonatomic) NSUInteger bitsPerComponent;
//@property (nonatomic) CGContextRef context;
@end

@implementation VWWScannerImage




-(id)initWithImage:(UIImage*)image{
    self = [super init];
    if(self){
        [self setImage:image];
    }
    return self;
}

-(void)dealloc{
    free(_rawData);
}



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




- (UIColor*)colorFromImageAtX:(float)x andY:(float)y{

    CGFloat xPixel = _width * x;
    CGFloat yPixel = _height * y;
    NSLog(@"Looking for X pixel %f/%d", xPixel, _width);
    NSLog(@"Looking for Y pixel %f/%d", yPixel, _height);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (_bytesPerRow * yPixel) + xPixel * _bytesPerPixel;
    CGFloat red   = (_rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (_rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (_rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (_rawData[byteIndex + 3] * 1.0) / 255.0;
    byteIndex += 4;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}



-(void)setImage:(UIImage *)image{
    if(image == nil) return;
    
    _image = image;
    
    _imageRef = [_image CGImage];
    _width = CGImageGetWidth(_imageRef);
    _height = CGImageGetHeight(_imageRef);
    _colorSpace = CGColorSpaceCreateDeviceRGB();
    _rawData = (unsigned char*) calloc(_height * _width * 4, sizeof(unsigned char));
    _bytesPerPixel = 4;
    _bytesPerRow = _bytesPerPixel * _width;
    _bitsPerComponent = 8;
    _context = CGBitmapContextCreate(_rawData, _width, _height,
                                         _bitsPerComponent, _bytesPerRow, _colorSpace,
                                         kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(_colorSpace);
    CGContextDrawImage(_context, CGRectMake(0, 0, _width, _height), _imageRef);
    CGContextRelease(_context);
}


@end
