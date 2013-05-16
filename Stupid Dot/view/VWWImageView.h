//
//  VWWImageView.h
//  Stupid Dot
//
//  Created by Zakk Hoyt on 5/15/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VWWImageViewGenerateDotBlock)(CGPoint touchPoint);
typedef void (^VWWImageViewGenerateDotPreviewBlock)(CGPoint touchPoint);
typedef void (^VWWImageViewGenerateVectorBlock)(CGPoint touchBegin, CGPoint touchEnd, NSTimeInterval timeInterval);


@interface VWWImageView : UIImageView
@property (nonatomic, strong) VWWImageViewGenerateDotBlock generateDotBlock;
@property (nonatomic, strong) VWWImageViewGenerateDotPreviewBlock generateDotPreviewBlock;
@property (nonatomic, strong) VWWImageViewGenerateVectorBlock generateVectorBlock;
@end
