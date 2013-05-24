//
//  VWWScannerAudioSettingsViewController.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VWWScannerAudioSettingsViewControllerDoneBlock)(void);

@interface VWWScannerAudioSettingsViewController : UIViewController
@property (nonatomic, strong) VWWScannerAudioSettingsViewControllerDoneBlock doneBlock;
@end
