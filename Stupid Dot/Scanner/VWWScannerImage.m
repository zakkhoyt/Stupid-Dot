//
//  VWWScannerImage.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerImage.h"

@interface VWWScannerImage ()
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) CGImageRef imageRef;
@property (nonatomic) NSUInteger width;
@property (nonatomic) NSUInteger height;
@property (nonatomic) CGColorSpaceRef colorSpace;
@property (nonatomic) unsigned char *rawData;
@property (nonatomic) NSUInteger bytesPerPixel;
@property (nonatomic) NSUInteger bytesPerRow;
@property (nonatomic) NSUInteger bitsPerComponent;
@property (nonatomic) CGContextRef context;
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
    free(self.rawData);
}




- (UIColor*)colorFromImageAtX:(float)x andY:(float)y{


    NSInteger xPixel = self.width * x;
    NSInteger yPixel = self.height * y;
    
    // Guarding against over indexing
    if(xPixel >= self.width) xPixel = self.width - 1;
    if(yPixel >= self.height) yPixel = self.height - 1;
//    NSLog(@"Looking for X pixel %d/%d", xPixel, self.width);
//    NSLog(@"Looking for Y pixel %d/%d", yPixel, self.height);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (self.bytesPerRow * yPixel) + xPixel * self.bytesPerPixel;
    CGFloat red   = (self.rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (self.rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (self.rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (self.rawData[byteIndex + 3] * 1.0) / 255.0;
    byteIndex += 4;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}



-(void)setImage:(UIImage *)image{
    if(image == nil) return;
    
    _image = image;
    
    self.imageRef = [self.image CGImage];
    self.width = CGImageGetWidth(self.imageRef);
    self.height = CGImageGetHeight(self.imageRef);
    self.colorSpace = CGColorSpaceCreateDeviceRGB();
    self.rawData = (unsigned char*) calloc(self.height * self.width * 4, sizeof(unsigned char));
    self.bytesPerPixel = 4;
    self.bytesPerRow = self.bytesPerPixel * self.width;
    self.bitsPerComponent = 8;
    self.context = CGBitmapContextCreate(self.rawData, self.width, self.height,
                                         self.bitsPerComponent, self.bytesPerRow, self.colorSpace,
                                         kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(self.colorSpace);
    CGContextDrawImage(self.context, CGRectMake(0, 0, self.width, self.height), self.imageRef);
    CGContextRelease(self.context);
    
    
}


@end
