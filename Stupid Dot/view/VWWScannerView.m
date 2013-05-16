//
//  VWWScannerView.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerView.h"

@interface VWWScannerView ()
@property (nonatomic, strong) NSArray *scanners;
@end

@implementation VWWScannerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    
    CGContextRef cgContext = UIGraphicsGetCurrentContext();

    for(VWWScanner *scanner in self.scanners){

        // Draw a circle (filled)
        CGFloat redFill, greenFill, blueFill, alphaFill;
        [scanner.dot.fillColor getRed:&redFill green:&greenFill blue:&blueFill alpha:&alphaFill];
        CGFloat fillColor[4] = {redFill, greenFill, blueFill, alphaFill};
        CGContextSetFillColor(cgContext, fillColor);
        CGContextFillEllipseInRect(cgContext, CGRectMake(scanner.dot.point.x,
                                                         scanner.dot.point.y,
                                                         scanner.dot.radius,
                                                         scanner.dot.radius));
        
        // Draw a circle (border only)
        CGFloat redBorder, greenBorder, blueBorder, alphaBorder;
        [scanner.dot.borderColor getRed:&redBorder green:&greenBorder blue:&blueBorder alpha:&alphaBorder];
        CGFloat borderColor[4] = {redBorder, greenBorder, blueBorder, alphaBorder};
        CGContextSetStrokeColor(cgContext, borderColor);
        CGContextStrokeEllipseInRect(cgContext, CGRectMake(scanner.dot.point.x,
                                                           scanner.dot.point.y,
                                                           scanner.dot.radius,
                                                           scanner.dot.radius));
        
        
        CGContextDrawPath(cgContext,kCGPathStroke);
    
    }
    
}




-(void)renderScanners:(NSArray*)scanners{
    // Make a copy of the scanners so that our scanner controller can keep updating without crushing our data
    _scanners = [NSArray arrayWithArray:scanners];
    
    [self setNeedsDisplay];
    
}





@end
