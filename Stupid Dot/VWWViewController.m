//
//  VWWViewController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWViewController.h"

@interface VWWViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loadImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation VWWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions
- (IBAction)loadImageTouchUpInside:(id)sender {
//    [self.imageView setImage:[UIImage imageNamed:@"white.jpg"]];
    [self.imageView setImage:[UIImage imageNamed:@"maze_01.jpg"]];
//    [self.imageView setImage:[UIImage imageNamed:@"maze_02.jpg"]];
//    [self.imageView setImage:[UIImage imageNamed:@"maze_03.jpg"]];
//    [self.imageView setImage:[UIImage imageNamed:@"maze_04.jpg"]];
}






@end
