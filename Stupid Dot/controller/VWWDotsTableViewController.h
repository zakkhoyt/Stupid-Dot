//
//  VWWDotsTableViewController.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWScannerController.h"


typedef void (^VWWDotsTableViewControllerAudioBlock)(VWWScanner *scanner);
typedef void (^VWWDotsTableViewControllerVisualBlock)(VWWScanner *scanner);

@interface VWWDotsTableViewController : UITableViewController
@property (nonatomic, strong) VWWScannerController *scannerController;
@property (nonatomic, strong) VWWDotsTableViewControllerAudioBlock audioBlock;
@property (nonatomic, strong) VWWDotsTableViewControllerVisualBlock visualBlock;
@end
