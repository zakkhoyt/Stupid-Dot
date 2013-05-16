//
//  VWWViewController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWViewController.h"
#import "VWWImagePopoverViewController.h"
#import "VWWScannerController.h"
#import "VWWScannerImageView.h"


static NSString *kSegueMainToImagePopover = @"segueMainToImagePopover";


@interface VWWViewController ()
// GUI stuff
@property (weak, nonatomic) IBOutlet UIButton *loadImageButton;
@property (weak, nonatomic) IBOutlet VWWScannerImageView *scannerImageView;
@property (nonatomic, strong) UIPopoverController *popoverViewController;

// Other stuff
@property (nonatomic, strong) VWWScannerController *scannerController;
@property (nonatomic, strong) VWWScanner *tempScanner;
@end



@implementation VWWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scannerController = [[VWWScannerController alloc]init];
	_scannerImageView.generateDotBlock = ^(CGPoint touchPoint){
        // Draw dot to signal something is happening
        // Generate a new scanner and add it to the controller
        self.tempScanner = [[VWWScanner alloc]initWithPoint:touchPoint];
        [self.scannerController addScanner:self.tempScanner];
    };
    
    _scannerImageView.generateVectorBlock = ^(CGPoint touchBegin, CGPoint touchEnd, NSTimeInterval timeInterval){
        // Update more properties of self.tempscanner and start it
        [self.tempScanner setBeginPoint:touchBegin endPoint:touchEnd timeInterval:timeInterval];
    };
         
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
            [self.scannerImageView setImage:[UIImage imageNamed:imageName]];
            [self.popoverViewController dismissPopoverAnimated:YES];
        };
    }
}

#pragma mark IBActions
- (IBAction)loadImageTouchUpInside:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToImagePopover sender:self];
}






@end
