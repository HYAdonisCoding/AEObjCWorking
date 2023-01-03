//
//  UIImage+AEBlackAndWhite.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/1/3.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ImageChangeType) {
    ImageChangeTypeBW = 0,
    ImageChangeTypePink,
    ImageChangeTypeBlue,
    ImageChangeTypeOrigin
};

@interface UIImage (AEBlackAndWhite)
+ (UIImage *)changeColoursTogray:(UIImage *)anImage type:(ImageChangeType)type;

//转化灰度
- (UIImage *)grayImage;

+ (void)ae_imageSwizzldMethedWith:(BOOL)changeGray;
@end

NS_ASSUME_NONNULL_END
