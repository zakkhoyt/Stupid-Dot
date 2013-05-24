//
//  SMSwitch.m
//
//  Created by Zakk Hoyt on 11/15/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SMSwitch.h"

static NSInteger kSMSwitchWidth = 78;
static NSInteger kSMSwitchHeight = 30;


@interface SMSwitch(){
    bool            _on;
    CGFloat         _animationDuration;
    UIImage         *_backgroundImageOn;
    UIImage         *_backgroundImageOff;
    UIImage         *_stickImage;
    UILabel         *_onLabel;
    UILabel         *_offLabel;
    UIImageView     *_background;
    UIImageView     *_stick;
    CGRect          _frame;
    CGSize          _stickSize;
}

@end


@implementation SMSwitch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _frame = frame;
        _stickSize.width = _frame.size.width * 0.3333;
        _stickSize.height = _frame.size.height * 0.8125;
        [self setup];
        [self addGestureRecognizers];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        // TODO: Why can't we just set _frame=self.frame? Why is self.frame 0?
        // For now use a canned size
        _frame = CGRectMake(0, 0, kSMSwitchWidth, kSMSwitchHeight);
        _stickSize.width = _frame.size.width * 0.3333;
        _stickSize.height = _frame.size.height * 0.8125;
        
        [self setup];
        [self addGestureRecognizers];
    }
    return self;
}


#pragma mark Private Methods

- (void)setup{
    _animationDuration = 0.20;
    _on = YES;
    
    // Override background from IB to clear
    self.backgroundColor = [UIColor clearColor];
    
    // Setup default images
    _backgroundImageOff = [UIImage imageNamed:@"sm_switch_background_image_off"];
    _backgroundImageOn = [UIImage imageNamed:@"sm_switch_background_image_on"];
    _stickImage = [UIImage imageNamed:@"sm_switch_stick"];
    _background = [[UIImageView alloc]initWithImage:_backgroundImageOff];
    _stick = [[UIImageView alloc]initWithImage:_stickImage];
    
    // Setup pieces
    [self setupBackground];
    [self setupStick];
    [self setupOnLabel];
    [self setupOffLabel];
    
}

-(void)setupOffLabel{
    
    CGFloat offLabelWidth = _background.frame.size.width - _stick.frame.size.width;
    CGFloat offLabelHeigth = _background.frame.size.height;
    CGFloat offLabelX = _background.frame.origin.x + _stick.frame.size.width;
    CGFloat offLabelY = _background.frame.origin.y;
    CGRect offLabelFrame = CGRectMake(offLabelX, offLabelY, offLabelWidth, offLabelHeigth);
    _offLabel = [[UILabel alloc]initWithFrame:offLabelFrame];
    _offLabel.textColor = [UIColor whiteColor];
    _offLabel.backgroundColor = [UIColor clearColor];
    [_offLabel setTextAlignment:NSTextAlignmentCenter];
    [_offLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    _offLabel.text = @"MUTE";
    _offLabel.alpha = [self offLabelAlpha];
    [self addSubview:_offLabel];
    
}
-(void)setupOnLabel{
    CGFloat onLabelWidth = _background.frame.size.width - _stick.frame.size.width;
    CGFloat onLabelHeigth = _background.frame.size.height;
    CGFloat onLabelX = _background.frame.origin.x;
    CGFloat onLabelY = _background.frame.origin.y;
    CGRect onLabelFrame = CGRectMake(onLabelX, onLabelY, onLabelWidth, onLabelHeigth);
    _onLabel = [[UILabel alloc]initWithFrame:onLabelFrame];
    _onLabel.textColor = [UIColor whiteColor];
    _onLabel.backgroundColor = [UIColor clearColor];
    [_onLabel setTextAlignment:NSTextAlignmentCenter];
    [_onLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    _onLabel.text = @"ON";
    _onLabel.alpha = [self onLabelAlpha];
    [self addSubview:_onLabel];
}

-(void)setupBackground{
    _background.frame = CGRectMake(0, 0, _frame.size.width, _frame.size.height);
    _background.image = [self switchBackgroundImage];
    _background.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_background];
    
}

-(void)setupStick{
    _stick.frame = [self switchPosition];
    _stick.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_stick];
}

-(CGFloat)onLabelAlpha{
    return _on ? 1.0 : 0.0;
}
-(CGFloat)offLabelAlpha{
    return _on ? 0.0 : 1.0;
}


-(CGRect)switchPosition{
    const CGFloat yOffset = (_frame.size.height - _stickSize.height) / 2.0;
    CGFloat xOffset = 0;
    CGFloat xInset = _frame.size.width * 0.03846;
    if(_on){
        // Set stick to the right
        xOffset = _frame.size.width - _stickImage.size.width - xInset;
    }
    else{
        xOffset = xInset;
    }
    
    return CGRectMake(xOffset,
                      yOffset,
                      _stickSize.width,
                      _stickSize.height);
}

-(UIImage*)switchBackgroundImage{
    return _on ? _backgroundImageOn : _backgroundImageOff;
}

-(void)toggleSwitch:(BOOL)on animated:(BOOL)animated completion:(SMSwitchCompletion)completion{
    _on = on;
    
    if(animated == NO){
        _stick.frame = [self switchPosition];
        _background.image = [self switchBackgroundImage];
        _onLabel.alpha = [self onLabelAlpha];
        _offLabel.alpha = [self offLabelAlpha];
        completion();
    }
    else{
        [UIView animateWithDuration:_animationDuration
                         animations:^{
                             _stick.frame = [self switchPosition];
                             _onLabel.alpha = [self onLabelAlpha];
                             _offLabel.alpha = [self offLabelAlpha];
                         } completion:^(BOOL finished){
                             _background.image = [self switchBackgroundImage];
                             completion();
                         }];
    }
}

#pragma mark Gesture Recognizers

-(void)addGestureRecognizers{
    UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftGestureHandler:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeftGestureRecognizer];
    
    UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightGestureHandler:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRightGestureRecognizer];
}

-(void)swipeLeftGestureHandler:(UIGestureRecognizer*)gestureRecognizer{
    if(_on == YES){
        _on = NO;
        [self setOn:_on ignoreControlEvents:NO];
    }
    
}
-(void)swipeRightGestureHandler:(UIGestureRecognizer*)gestureRecognizer{
    if(_on == NO){
        _on = YES;
        [self setOn:_on ignoreControlEvents:NO];
    }
}


#pragma mark Touch Events
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    _on = !_on;
    [self setOn:_on animated:YES ignoreControlEvents:NO];

//    [self toggleSwitch:_on animated:YES completion:^{
//        [self sendActionsForControlEvents:UIControlEventValueChanged];
//    }];
    
}
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//}




#pragma mark Public Methods
-(void)setText:(NSString*)text forControlState:(SMControlState)controlState{
    if(controlState == SMSwitchControlStateOff){
        _offLabel.text = text;
    }
    else{
        _onLabel.text = text;
    }
}
//-(void)setBackgroundImage:(UIImage*)image forControlState:(SMControlState)controlState{
//
//}
//-(void)setStickImage:(UIImage*)image{
//
//}

#pragma mark Public Methods that follow UISwitch interface

-(void)setOn:(bool)on ignoreControlEvents:(BOOL)ignore{
    [self toggleSwitch:on animated:YES completion:^{
        if(ignore == NO){
            if([self respondsToSelector:@selector(sendActionsForControlEvents:)] == YES){
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
        }
    }];
    
}

-(void)setOn:(BOOL)on animated:(BOOL)animated ignoreControlEvents:(BOOL)ignore{
    [self toggleSwitch:on animated:animated completion:^{
        if(ignore == NO){
            if([self respondsToSelector:@selector(sendActionsForControlEvents:)] == YES){
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
        }
    }];
}
-(bool)on{
    return _on;
}


@end



















