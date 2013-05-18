//
//  VWWSlider.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWSlider.h"



@interface VWWSlider (){
    CGRect          _frame;
//    UIView          *_backgroundView;
    UIImageView         *_backgroundImageView;
//    UIImage         *_backgroundImageOff;
    UILabel         *_maximumLabel;
    UILabel         *_minimumLabel;
}

@end


@implementation VWWSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    
    _frame = CGRectMake(0, 0, 80, 580);
//    _frame = [[UIView alloc]initWithFrame:backgroundFrame];
    
    
    self.backgroundColor = [UIColor greenColor];
    
    _maximumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 80, 20)];
    _maximumLabel.textColor = [UIColor blackColor];
    _maximumLabel.backgroundColor = [UIColor clearColor];
    [_maximumLabel setTextAlignment:NSTextAlignmentCenter];
    [_maximumLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
    [self addSubview:_maximumLabel];

    _minimumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 550, 80, 20)];
    _minimumLabel.textColor = [UIColor blackColor];
    _minimumLabel.backgroundColor = [UIColor clearColor];
    [_minimumLabel setTextAlignment:NSTextAlignmentCenter];
    [_minimumLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
    [self addSubview:_minimumLabel];

    
    _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 80, 500)];
    _backgroundImageView.image = [UIImage imageNamed:@"SliderBackground.png"];
//    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_backgroundImageView];
    
    
    _minimumLabel.text = @"20";
    _maximumLabel.text = @"3000";
//    _offLabel.textColor = [UIColor whiteColor];
//    _offLabel.backgroundColor = [UIColor clearColor];
//    [_offLabel setTextAlignment:NSTextAlignmentCenter];
//    [_offLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
//    _offLabel.text = @"OFF";
//    _offLabel.alpha = [self offLabelAlpha];
//    [self addSubview:_offLabel];

}




#pragma mark Touch Events

// 0% - <0.069% is max label
// 0.069% = 99.93% is slider
// >99.93% = 100% is minimium label;
-(void)setSliderPosition:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *touchesArray = [touches allObjects];
    UITouch* touch = touchesArray[0];
    CGPoint point = [touch locationInView:self];
    
    float yPositionOfSelf = point.y / 580;
    
    if(yPositionOfSelf >= 0.69 && yPositionOfSelf <= 99.93){
    // 98.62
        
    }
    
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}

@end




