//
//  VWWThereminInputSettingsWaveformTableViewCell.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VWWThereminTypes.h"

typedef void (^VWWThereminInputSettingsWaveformTableViewCellSelectionBlock)(WaveType waveType);

@interface VWWThereminInputSettingsWaveformTableViewCell : UITableViewCell
@property (nonatomic) WaveType waveType;
@end
