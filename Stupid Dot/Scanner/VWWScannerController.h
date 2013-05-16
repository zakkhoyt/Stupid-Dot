//
//  VWWScannerController.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VWWScanner.h"


typedef void (^VWWScannerControllerRenderScannersBlock)(NSArray *scanners);


@interface VWWScannerController : NSObject

@property (nonatomic, strong) VWWScannerControllerRenderScannersBlock renderScannersBlock;

+(VWWScannerController*)sharedInstance;
-(void)setImage:(UIImage*)image;
-(void)addScanner:(VWWScanner*)scanner;
-(void)printScanners;
-(void)removeScanner:(VWWScanner*)scanner;
-(void)removeAllScanners;
-(void)startProcessing;
-(void)stopProcessing;
-(void)startAllScanners;
-(void)stopAllScanners;
@end
