//
//  VWWThereminInputSettingsWaveformTableViewCell.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInputSettingsWaveformTableViewCell.h"
#import "VWWSlider.h"

@interface VWWThereminInputSettingsWaveformTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation VWWThereminInputSettingsWaveformTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark Public methods
-(void)setWaveType:(WaveType)waveType{
    switch (waveType) {
        case kWaveSin:
            [self.imageView setImage:[UIImage imageNamed:@"sine_256x256.png"]];
            break;
        case kWaveSquare:
            [self.imageView setImage:[UIImage imageNamed:@"square_256x256.png"]];
            break;
        case kWaveSawtooth:
            [self.imageView setImage:[UIImage imageNamed:@"sawtooth_256x256.png"]];
            break;
        case kWaveTriangle:
            [self.imageView setImage:[UIImage imageNamed:@"triangle_256x256.png"]];
            break;
        default:
            break;
    }
}



@end
