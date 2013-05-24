//
//  VWWDotView.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWDotView.h"

@implementation VWWDotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat kOffset = 6;
    CGContextRef cgContext = UIGraphicsGetCurrentContext();
    CGFloat radius = self.frame.size.height - kOffset;
    
    //    for(VWWScanner *scanner in self.scanners){
    CGFloat red, green, blue, alpha;
    
    {
        // Draw a circle (filled)
        [self.scanner.dot.fillColor getRed:&red green:&green blue:&blue alpha:&alpha];
        CGFloat fillColor[4] = {red, green, blue, alpha};
        CGContextSetFillColor(cgContext, fillColor);
        CGContextFillEllipseInRect(cgContext, CGRectMake(kOffset/2.0, kOffset/2.0 , radius, radius));
    }
    
    {
        // Draw a circle (border only)
        [self.scanner.dot.borderColor getRed:&red green:&green blue:&blue alpha:&alpha];
        CGFloat borderColor[4] = {red, green, blue, alpha};
        CGContextSetStrokeColor(cgContext, borderColor);
        CGContextStrokeEllipseInRect(cgContext, CGRectMake(kOffset/2.0, kOffset/2.0, radius, radius));
        
    }
    
    {
        // Draw color at dot (filled) as half of the radiis
        [self.scanner.colorAtDot getRed:&red green:&green blue:&blue alpha:&alpha];
        CGFloat fillColor[4] = {red, green, blue, alpha};
        CGContextSetFillColor(cgContext, fillColor);
        CGContextFillEllipseInRect(cgContext, CGRectMake((kOffset/2.0)+radius/4.0, (kOffset/2.0)+radius/4.0 , radius/2.0, radius/2.0));
    }
    CGContextDrawPath(cgContext,kCGPathStroke);
    

    
}




@end
