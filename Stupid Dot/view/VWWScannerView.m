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
        CGFloat x = self.frame.size.width * scanner.dot.point.x;
        CGFloat y = self.frame.size.height * scanner.dot.point.y;
        CGFloat red, green, blue, alpha;
        
        {   // Draw a circle (filled)
            [scanner.dot.fillColor getRed:&red green:&green blue:&blue alpha:&alpha];
            CGFloat fillColor[4] = {red, green, blue, alpha};
            CGContextSetFillColor(cgContext, fillColor);
            CGContextFillEllipseInRect(cgContext, CGRectMake(x-(scanner.dot.radius/2.0), y-(scanner.dot.radius/2.0), scanner.dot.radius, scanner.dot.radius));
        }
        
        {   // Draw a circle (border only)
            [scanner.dot.borderColor getRed:&red green:&green blue:&blue alpha:&alpha];
            CGFloat borderColor[4] = {red, green, blue, alpha};
            CGContextSetStrokeColor(cgContext, borderColor);
            CGContextStrokeEllipseInRect(cgContext, CGRectMake(x-(scanner.dot.radius/2.0), y-(scanner.dot.radius/2.0), scanner.dot.radius, scanner.dot.radius));

        }
        
        {   // Draw color at dot (filled) as half of the radiis
            [scanner.colorAtDot getRed:&red green:&green blue:&blue alpha:&alpha];
            CGFloat fillColor[4] = {red, green, blue, alpha};
            CGContextSetFillColor(cgContext, fillColor);
            CGContextFillEllipseInRect(cgContext, CGRectMake(x-(scanner.dot.radius/4.0), y-(scanner.dot.radius/4.0) , scanner.dot.radius/2.0, scanner.dot.radius/2.0));
        }
        
        
        
        {   // Render text
            UIFont *font = [UIFont systemFontOfSize:11];
            
//            // colors
//            NSString* text = [NSString stringWithFormat:@"%f %f %f", red, green, blue];
            
            // coordinates
            NSString* text = [NSString stringWithFormat:@"(%d,%d)",
                              (NSInteger)(scanner.dot.point.x * self.frame.size.width),
                              (NSInteger)((scanner.dot.point.y * self.frame.size.height) - scanner.dot.radius)];
            
            CGRect rect = CGRectMake(scanner.dot.point.x * self.frame.size.width - scanner.dot.radius/2.0,
                                     (scanner.dot.point.y * self.frame.size.height) - scanner.dot.radius,
                                     scanner.dot.radius,
                                     scanner.dot.radius);
            [text drawInRect:rect withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
        }
        
        CGContextDrawPath(cgContext,kCGPathStroke);
    
    }
    
}




-(void)renderScanners:(NSArray*)scanners{
    // Make a copy of the scanners so that our scanner controller can keep updating without crushing our data
    _scanners = [NSArray arrayWithArray:scanners];
    
    [self setNeedsDisplay];
    
}





@end
