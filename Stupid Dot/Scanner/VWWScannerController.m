//
//  VWWScannerController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerController.h"
#import "VWWThereminInputs.h"


@interface VWWScannerController ()
@property (nonatomic, strong) NSMutableArray *scanners;
@property (nonatomic) dispatch_queue_t scannerQueue;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) float framesPerSecond;
@end

@implementation VWWScannerController
+(VWWScannerController*)sharedInstance{
    static VWWScannerController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWScannerController alloc]init];
    });
    return instance;
}

-(id)init{
//    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        _framesPerSecond = 60.0;
        _scanners = [@[]mutableCopy];
        _scannerQueue = dispatch_queue_create("com.vaporwarewolf.stupiddot.scanner", NULL);

        // Configure inputs from settings file (or create default)
        [VWWThereminInputs sharedInstance];

        // TODO: move this config to a screen of some sort. 
        VWWThereminInputAxis* touchX = [VWWThereminInputs touchscreenInput].x;
        touchX.waveType = kWaveSawtooth;

        VWWThereminInputAxis* touchY = [VWWThereminInputs touchscreenInput].y;
        touchY.waveType = kWaveSquare;

    }
    return self;
}






#pragma mark Private methods

- (void)processScanners {
    dispatch_async(self.scannerQueue, ^{
        for(NSInteger index = 0; index < self.scanners.count; index++){
            VWWScanner *scanner = self.scanners[index];
            // Update scanners with current info.
            scanner.image = self.image;
            
            [scanner process];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.renderScannersBlock(self.scanners);
        });
    });
}






#pragma mark Public methods

-(void)setImage:(UIImage*)image viewSize:(CGSize)viewSize{
    _image = image;
}

-(void)addScanner:(VWWScanner*)scanner{
    [self.scanners addObject:scanner];
}

-(void)printScanners{
    for(VWWScanner *scanner in self.scanners){
        NSLog(@"%@", scanner.description);
    }
}


-(void)removeScanner:(VWWScanner*)scanner{
    [self.scanners removeObject:scanner];
}
-(void)removeAllScanners{
    // This causes a problme with having only one dot
//    [self stopProcessing];
    [self stopAllScanners];
    [self.scanners removeAllObjects];
    self.renderScannersBlock(self.scanners);
}


-(void)startProcessing{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/self.framesPerSecond target:self selector:@selector(processScanners) userInfo:nil repeats:YES];
}
-(void)stopProcessing{
    [self.timer invalidate];
    self.timer = nil;
}


-(void)startAllScanners{
    [self.scanners makeObjectsPerformSelector:@selector(start)];
}
-(void)stopAllScanners{
    [self.scanners makeObjectsPerformSelector:@selector(stop)];
}




@end
