//
//  VWWThereminInputSettingsViewController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/17/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminInputSettingsViewController.h"
#import "VWWThereminInputSettingsWaveformTableViewCell.h"

@interface VWWThereminInputSettingsViewController ()
@property (strong, nonatomic) UISlider *minimumFrequencySlider;
@property (strong, nonatomic) UISlider *maximumFrequencySlider;
@property (strong, nonatomic) UISlider *amplitudeSlider;
@property (strong, nonatomic) IBOutlet UITableView *waveFormTableView;
@property (strong, nonatomic) IBOutlet UITableView *effectTableView;

@end

@implementation VWWThereminInputSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    const float kSpacing = 10;
    const float kSliderWidth = 23;
    
    CGRect minimumuSliderFrame = CGRectMake(kSpacing,
                                            kSpacing,
//                                            self.view.frame.size.height - 2*kSpacing,
                                            200,
                                            kSliderWidth);
                                            
                                            
    self.minimumFrequencySlider = [[UISlider alloc]initWithFrame:minimumuSliderFrame];
//    [self.view addSubview:self.minimumFrequencySlider];

//    self.minimumFrequencySlider.transform = CGAffineTransformMakeRotation(M_PI_2);
  
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Public methods


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount = 0;
    if(tableView == self.waveFormTableView){
        rowCount = 4;
    }
    else if(tableView == self.effectTableView){
        rowCount = 2;
    }

    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if(tableView == self.waveFormTableView){
        VWWThereminInputSettingsWaveformTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"VWWThereminInputSettingsWaveformTableViewCell"];
        switch (indexPath.row) {
            case 0:
                cell.waveType = kWaveSin;
                break;
            case 1:
                cell.waveType = kWaveSquare;
                break;
            case 2:
                cell.waveType = kWaveSawtooth;
                break;
            case 3:
                cell.waveType = kWaveTriangle;
                break;
            default:
                break;
        }
        return cell;
    }
    else if(tableView == self.effectTableView){
        
    }
    
    return [[UITableViewCell alloc]init];
}


@end
