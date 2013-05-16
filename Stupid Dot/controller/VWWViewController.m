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
#import "VWWImageView.h"
#import "VWWScannerView.h"


static NSString *kSegueMainToImagePopover = @"segueMainToImagePopover";


@interface VWWViewController ()
// GUI stuff
@property (weak, nonatomic) IBOutlet UIButton *loadImageButton;
@property (weak, nonatomic) IBOutlet VWWImageView *imageView;
@property (nonatomic, strong) UIPopoverController *popoverViewController;
@property (strong, nonatomic) IBOutlet VWWScannerView *scannerView;

// Other stuff
@property (nonatomic, strong) VWWScannerController *scannerController;
@property (nonatomic, strong) VWWScanner *tempScanner;
@end



@implementation VWWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scannerController = [[VWWScannerController alloc]init];
    
    VWWViewController *weakSelf = self;
    _scannerController.renderScannersBlock = ^(NSArray *scanners){
        // TODO: This is an array of VWWScanner objects. Use them to render the dots either on the VWWImageView, or another layer;
        [weakSelf.scannerView renderScanners:scanners];
    };
    
    [_scannerController startProcessing];
    
	_imageView.generateDotBlock = ^(CGPoint touchPoint){
        // Draw dot to signal something is happening
        // Generate a new scanner and add it to the controller
        self.tempScanner = [[VWWScanner alloc]initWithPoint:touchPoint];
        [self.scannerController addScanner:self.tempScanner];
    };
    
    _imageView.generateDotPreviewBlock = ^(CGPoint touchPoint){
        // Draw a preview line from the begin point to this point
    };
    
    _imageView.generateVectorBlock = ^(CGPoint touchBegin, CGPoint touchEnd, NSTimeInterval timeInterval){
        // Update more properties of self.tempscanner and start it
        [self.tempScanner setBeginPoint:touchBegin endPoint:touchEnd timeInterval:timeInterval];
        [self.tempScanner start];
        
        [self.scannerController printScanners];
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
            UIImage *image = [UIImage imageNamed:imageName];
            [self.imageView setImage:image];
            [self.scannerController setImage:image];
            [self.popoverViewController dismissPopoverAnimated:YES];
        };
    }
}

#pragma mark IBActions

- (IBAction)loadImageButtonTouchUpInside:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToImagePopover sender:self];
}


- (IBAction)removeAllButtonTouchUpInside:(id)sender {
    [self.scannerController removeAllScanners];
}



@end