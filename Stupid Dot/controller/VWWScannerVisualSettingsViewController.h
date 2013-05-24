//
//  VWWScannerVisualSettingsViewController.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VWWScannerVisualSettingsViewControllerDoneBlock)(void);

@interface VWWScannerVisualSettingsViewController : UIViewController
@property (nonatomic, strong) VWWScannerVisualSettingsViewControllerDoneBlock doneBlock;
@end
