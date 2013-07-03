//
//  VWWViewController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWViewController.h"
#import "VWWScannerController.h"
#import "VWWImageView.h"
#import "VWWScannerView.h"
#import "VWWDotsTableViewController.h"
#import "VWWScannerAudioSettingsViewController.h"
#import "VWWScannerVisualSettingsViewController.h"

static NSString *kSegueMainToImagePopover = @"segueMainToImagePopover";
static NSString *kSegueMainToDotsPopover = @"segueMainToDotsPopover";
static NSString *kSegueMainToAudioSettings = @"segueMainToAudioSettings";
static NSString *kSegueMainToVisualSettings = @"segueMainToVisualSettings";

typedef enum {
    SMImagePickerTypeChooseExisting = 0,
    SMImagePickerTypeTakePhoto = 1,
} SMImagePickerType;


@interface VWWViewController ()
    <UINavigationControllerDelegate,
    UIImagePickerControllerDelegate,
    UITextViewDelegate>

// GUI stuff
@property (weak, nonatomic) IBOutlet UIButton *loadImageButton;
@property (weak, nonatomic) IBOutlet VWWImageView *imageView;
@property (nonatomic, strong) UIPopoverController *popoverViewController;
@property (strong, nonatomic) IBOutlet VWWScannerView *scannerView;
@property (nonatomic, strong) UIPopoverController *popover;

// Other stuff
@property (nonatomic, strong) VWWScannerController *scannerController;
@property (nonatomic, strong) VWWScanner *tempScanner;
@property (nonatomic) SMImagePickerType imagePickerType;
@property (nonatomic, strong) UIImagePickerController *picker;
@end



@implementation VWWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
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
    
    if([segue.identifier isEqualToString:kSegueMainToDotsPopover]){
        VWWDotsTableViewController *vc = segue.destinationViewController;
        vc.scannerController = self.scannerController;
        vc.audioBlock = ^(VWWScanner *scanner){
            [self.popoverViewController dismissPopoverAnimated:YES];
            [self performSegueWithIdentifier:kSegueMainToAudioSettings sender:self];
        };
        vc.visualBlock = ^(VWWScanner *scanner){
            [self.popoverViewController dismissPopoverAnimated:YES];
            [self performSegueWithIdentifier:kSegueMainToVisualSettings sender:self];
        };
    }
    else if([segue.identifier isEqualToString:kSegueMainToAudioSettings]){
        VWWScannerAudioSettingsViewController *vc = segue.destinationViewController;
        vc.doneBlock = ^(){
            [self dismissViewControllerAnimated:YES completion:^{}];
        };
    }
    else if([segue.identifier isEqualToString:kSegueMainToVisualSettings]){
        VWWScannerVisualSettingsViewController *vc = segue.destinationViewController;
        vc.doneBlock = ^(){
            [self dismissViewControllerAnimated:YES completion:^{}];
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


#pragma mark Private methods
-(void)chooseExistingPhoto{
    self.picker = [[UIImagePickerController alloc]init];
    self.imagePickerType = SMImagePickerTypeChooseExisting;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.allowsEditing = YES;
	self.picker.delegate = self;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.popover = [[UIPopoverController alloc] initWithContentViewController:self.picker];
        [self.popover presentPopoverFromRect:self.loadImageButton.frame
                                       inView:self.view
                     permittedArrowDirections:UIPopoverArrowDirectionAny
                                     animated:YES];
    } else {
        [self presentViewController:self.picker animated:YES completion:^{
        }];
    }
}


-(void)takePhoto{
    self.picker = [[UIImagePickerController alloc]init];
    self.imagePickerType = SMImagePickerTypeTakePhoto;
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    self.picker.allowsEditing = YES;
	self.picker.delegate = self;
    
    
    // Present
    [self presentViewController:self.picker animated:YES completion:^{
    }];
}


#pragma mark IBActions

- (IBAction)loadImageButtonTouchUpInside:(id)sender {
//    [self performSegueWithIdentifier:kSegueMainToImagePopover sender:self];
    [self chooseExistingPhoto];

}


- (IBAction)removeAllButtonTouchUpInside:(id)sender {
    [self.scannerController removeAllScanners];
}

- (IBAction)editDotsButton:(id)sender {
    [self performSegueWithIdentifier:kSegueMainToDotsPopover sender:self];
}



#pragma mark Implements UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if(image == nil){
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    // Display image to user
    [self.imageView setImage:image];
    // Load image into scanner as well
    [self.scannerController setImage:nil];
    [self.scannerController setImage:image];
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        [self.popoverViewController dismissPopoverAnimated:YES];
//    }
//    else{
//        [self dismissViewControllerAnimated:YES completion:^{}];
//    }
    

    // Dismiss image picker and popover if ipad
    [self.picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.popover dismissPopoverAnimated:YES];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    self.imageView.image = nil;
}




@end
