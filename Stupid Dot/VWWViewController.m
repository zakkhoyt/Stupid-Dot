//
//  VWWViewController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWViewController.h"
#import "VWWImagePopoverViewController.h"

@interface VWWViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loadImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIPopoverController *popoverViewController;
@end

static NSString *kSegueMainToImagePopover = @"segueMainToImagePopover";

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue isKindOfClass:[UIStoryboardPopoverSegue class]]){
        self.popoverViewController = ((UIStoryboardPopoverSegue*)segue).popoverController;
    }
    
    if([segue.identifier isEqualToString:kSegueMainToImagePopover]){
        VWWImagePopoverViewController *vc = segue.destinationViewController;
        vc.completion = ^(NSString *imageName){
            [self.imageView setImage:[UIImage imageNamed:imageName]];
            [self.popoverViewController dismissPopoverAnimated:YES];
        };
    }
}

#pragma mark IBActions
- (IBAction)loadImageTouchUpInside:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToImagePopover sender:self];
}






@end
