//
//  VWWScannerImageView.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VWWScannerImageViewGenerateDotBlock)(CGPoint touchPoint);
typedef void (^VWWScannerImageViewGenerateVectorBlock)(CGPoint touchBegin, CGPoint touchEnd, NSTimeInterval timeInterval);


@interface VWWScannerImageView : UIImageView
@property (nonatomic, strong) VWWScannerImageViewGenerateDotBlock generateDotBlock;
@property (nonatomic, strong) VWWScannerImageViewGenerateVectorBlock generateVectorBlock;
@end
