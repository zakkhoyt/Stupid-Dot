//
//  VWWScannerAudioSettingsViewController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerAudioSettingsViewController.h"
#import "VWWScanner.h"

@interface VWWScannerAudioSettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *xWavetypeLabel;
@property (weak, nonatomic) IBOutlet UISlider *xWavetypeSlider;
@property (weak, nonatomic) IBOutlet UILabel *xMinimiumFrequencyLabel;
@property (weak, nonatomic) IBOutlet UISlider *xMinimumFrequencySlider;
@property (weak, nonatomic) IBOutlet UILabel *xMaximimumFrequencyLabel;
@property (weak, nonatomic) IBOutlet UISlider *xMaximumFrequencySlider;
@property (weak, nonatomic) IBOutlet UILabel *xAmplitudeLabel;
@property (weak, nonatomic) IBOutlet UISlider *xAmplitudeSlider;
@property (weak, nonatomic) IBOutlet UILabel *yWavetypeLabel;
@property (weak, nonatomic) IBOutlet UISlider *yWavetypeSlider;
@property (weak, nonatomic) IBOutlet UILabel *yMinimumFrequencyLabel;
@property (weak, nonatomic) IBOutlet UISlider *yMinimiumFrequencySlider;
@property (weak, nonatomic) IBOutlet UILabel *yMaximumFrequencyLabel;
@property (weak, nonatomic) IBOutlet UISlider *yMaximumFrequencySlider;
@property (weak, nonatomic) IBOutlet UILabel *yAmplitudeLabel;
@property (weak, nonatomic) IBOutlet UISlider *yAmplitudeSlider;
@end

@implementation VWWScannerAudioSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.xMinimumFrequencySlider.value = self.scanner.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions

- (IBAction)doneButtonTouchUpInside:(id)sender {
    if(self.doneBlock) self.doneBlock();
}

@end

