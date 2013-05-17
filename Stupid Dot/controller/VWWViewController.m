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
//    [self addGestureRecognizers];
    _scannerController = [[VWWScannerController alloc]init];
    
    VWWViewController *weakSelf = self;
    _scannerController.renderScannersBlock = ^(NSArray *scanners){
        //This is an array of VWWScanner objects. Use them to render the dots either on the VWWImageView, or another layer;
        [weakSelf.scannerView renderScanners:scanners];
    };
    
    [_scannerController startProcessing];
    
	_imageView.generateDotBlock = ^(CGPoint touchPoint){
        // Draw dot to signal something is happening
        // Generate a new scanner and add it to the controller
        CGRect frame = self.imageView.frame;
        CGPoint point = CGPointMake(touchPoint.x / (float)frame.size.width, touchPoint.y / (float)frame.size.height);
        self.tempScanner = [[VWWScanner alloc]initWithPoint:point];

        
#if defined (VWW_ONLY_ONE_SCANNER)
        [self.scannerController removeAllScanners];
#else

#endif
        [self.scannerController addScanner:self.tempScanner];
    };
    
    _imageView.generateDotPreviewBlock = ^(CGPoint touchPoint){
        // Draw a preview line from the begin point to this point
    };
    
    _imageView.generateVectorBlock = ^(CGPoint touchBegin, CGPoint touchEnd, NSTimeInterval timeInterval){
        // Update more properties of self.tempscanner and start it
        float runRatio = (touchEnd.x - touchBegin.x) / _imageView.frame.size.width;
        float riseRatio = (touchEnd.y - touchBegin.y) / _imageView.frame.size.width;
        [self.tempScanner.vector setRiseRatio:riseRatio runRatio:runRatio timeInterval:timeInterval];
        [self.tempScanner start];
//        [self.scannerController printScanners];
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

            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                [self.popoverViewController dismissPopoverAnimated:YES];
            }
            else{
                [self dismissViewControllerAnimated:YES completion:^{}];
            }
        };
    }
}



-(void)addGestureRecognizers{
    
    UILongPressGestureRecognizer* longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureHandler:)];
    [self.view addGestureRecognizer:longPressGestureRecognizer];
}


-(void)longPressGestureHandler:(UIGestureRecognizer*)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self performSegueWithIdentifier:kSegueMainToImagePopover sender:self];
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
