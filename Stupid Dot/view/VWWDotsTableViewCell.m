//
//  VWWDotsTableViewCell.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWDotsTableViewCell.h"
#import "SMSwitch.h"
#import "VWWDotView.h"

@interface VWWDotsTableViewCell ()
@property (weak, nonatomic) IBOutlet SMSwitch *muteSwitch;
@property (weak, nonatomic) IBOutlet VWWDotView *dotView;
@end

@implementation VWWDotsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//
//
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect{
//    
//    CGContextRef cgContext = UIGraphicsGetCurrentContext();
//    CGFloat radius = self.frame.size.height;
//    
////    for(VWWScanner *scanner in self.scanners){
//        CGFloat red, green, blue, alpha;
//        
//        {
//            // Draw a circle (filled)
//            [self.scanner.dot.fillColor getRed:&red green:&green blue:&blue alpha:&alpha];
//            CGFloat fillColor[4] = {red, green, blue, alpha};
//            CGContextSetFillColor(cgContext, fillColor);
//            CGContextFillEllipseInRect(cgContext, CGRectMake(10, 0 , radius, radius));
//        }
//        
//        {
//            // Draw a circle (border only)
//            [self.scanner.dot.borderColor getRed:&red green:&green blue:&blue alpha:&alpha];
//            CGFloat borderColor[4] = {red, green, blue, alpha};
//            CGContextSetStrokeColor(cgContext, borderColor);
//            CGContextStrokeEllipseInRect(cgContext, CGRectMake(10, 0, radius, radius));
//            
//        }
//        
//        {
//            // Draw color at dot (filled) as half of the radiis
//            [self.scanner.colorAtDot getRed:&red green:&green blue:&blue alpha:&alpha];
//            CGFloat fillColor[4] = {red, green, blue, alpha};
//            CGContextSetFillColor(cgContext, fillColor);
//            CGContextFillEllipseInRect(cgContext, CGRectMake(10+radius/4.0, radius/4.0 , radius/2.0, radius/2.0));
//        }
//        CGContextDrawPath(cgContext,kCGPathStroke);
//        
////    }
//    
//}


#pragma mark IBActions

- (IBAction)muteSwitchValueChanged:(id)sender {
}

- (IBAction)audioButtonTouchUpInside:(id)sender {
    if(self.audioBlock) self.audioBlock(self.scanner);
}

- (IBAction)visualButtonTouchUpInside:(id)sender {
    if(self.visualBlock) self.visualBlock(self.scanner);
}



#pragma mark Public Methods

-(void)setScanner:(VWWScanner *)scanner{
    _scanner = scanner;
    self.dotView.scanner = _scanner;
}



@end
