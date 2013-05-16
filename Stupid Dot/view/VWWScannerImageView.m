//
//  VWWScannerImageView.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerImageView.h"

@interface VWWScannerImageView ()
@property (nonatomic) CGPoint touchBegin;
@property (nonatomic, strong) NSDate *timeBegin;
@end

@implementation VWWScannerImageView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];

    // Get touch point
    self.timeBegin = [NSDate date];
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    self.touchBegin = [touch locationInView:self];

    NSLog(@"%s:%d touchBegin=%@", __FUNCTION__, __LINE__, NSStringFromCGPoint(self.touchBegin));

    self.generateDotBlock(self.touchBegin);
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    // Get touch point
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    CGPoint touchEnd = [touch locationInView:self];
    
    // Calculate time between touchBegin and touchEnd
    NSDate* timeEnd = [NSDate date];
    NSTimeInterval executionTime = [timeEnd timeIntervalSinceDate:self.timeBegin];

    NSLog(@"%s:%d touchEnd=%@", __FUNCTION__, __LINE__, NSStringFromCGPoint(touchEnd));

    self.generateVectorBlock(self.touchBegin, touchEnd, executionTime);
}


//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    [super touchesMoved:touches withEvent:event];
//}

//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//    [super touchesCancelled:touches withEvent:event];
//}

@end
