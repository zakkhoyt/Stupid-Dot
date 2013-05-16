//
//  VWWScannerController.m
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWScannerController.h"

@interface VWWScannerController ()
@property (nonatomic, strong) NSMutableArray *scanners;
@property (nonatomic) dispatch_queue_t scannerQueue;
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) NSArray *pixelBuffer;
@property (nonatomic, strong) UIImage *image;
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
    NSLog(@"%s:%d", __FUNCTION__, __LINE__);
    self = [super init];
    if(self){
        _scanners = [@[]mutableCopy];
        _scannerQueue = dispatch_queue_create("com.vaporwarewolf.stupiddot.scanner", NULL);
    }
    return self;
}






#pragma mark Private methods






- (void)processScanners {
    dispatch_async(self.scannerQueue, ^{
        for(NSInteger index = 0; index < self.scanners.count; index++){
            VWWScanner *scanner = self.scanners[index];
            scanner.image = self.image;
            [scanner process];
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.renderScannersBlock(self.scanners);
        });
    });
}






#pragma mark Public methods

-(void)setImage:(UIImage*)image{
    _image = image;
}

-(void)addScanner:(VWWScanner*)scanner{
    [self.scanners addObject:scanner];
}

-(void)removeScanner:(VWWScanner*)scanner{
    [self.scanners removeObject:scanner];
}
-(void)removeAllScanners{
    [self stopProcessing];
    [self stopAllScanners];
    [self.scanners removeAllObjects];
}


-(void)startProcessing{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/(float)60.0 target:self selector:@selector(processScanners) userInfo:nil repeats:YES];
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
