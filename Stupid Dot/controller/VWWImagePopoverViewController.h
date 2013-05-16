//
//  VWWImagePopoverViewController.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VWWImagePopoverViewControllerCompletion)(NSString *imageName);


@interface VWWImagePopoverViewController : UIViewController
@property (nonatomic, strong) VWWImagePopoverViewControllerCompletion completion;
@end
