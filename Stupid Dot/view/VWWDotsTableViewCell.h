//
//  VWWDotsTableViewCell.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWScanner.h"


typedef void (^VWWDotsTableViewCellAudioBlock)(VWWScanner *scanner);
typedef void (^VWWDotsTableViewCellVisualBlock)(VWWScanner *scanner);

@interface VWWDotsTableViewCell : UITableViewCell
@property (nonatomic, strong) VWWScanner *scanner;
@property (nonatomic, strong) VWWDotsTableViewCellAudioBlock audioBlock;
@property (nonatomic, strong) VWWDotsTableViewCellVisualBlock visualBlock;
@end
