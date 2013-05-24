//
//  SMSwitch.h
//
//  Created by Zakk Hoyt on 11/15/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//
//  To use with Interface Builder, drag out a UIView. In the Identity Inspector, change the class to SMSwitch.
//  It can be helpful to change th background color at design time. This property will be overridden to clear during setup.
//
//  This implementation only fires the "ValueChanged" event when you connect with IB
//  Physically operates similar to a standard UISwitch, but there are some obvious differences.

#import <UIKit/UIKit.h>

typedef void (^SMSwitchCompletion)();

typedef enum {
    SMSwitchControlStateOff = 0,
    SMSwitchControlStateOn = 1
} SMControlState;

@interface SMSwitch : UIControl


-(void)setText:(NSString*)text forControlState:(SMControlState)controlState;
// TODO:
//-(void)setBackgroundImage:(UIImage*)image forControlState:(SMControlState)controlState;
//-(void)setStickImage:(UIImage*)image;

// Standard UISwitch interface
-(bool)on;
-(void)setOn:(bool)on ignoreControlEvents:(BOOL)ignore;
-(void)setOn:(BOOL)on animated:(BOOL)animated ignoreControlEvents:(BOOL)ignore;
@end
