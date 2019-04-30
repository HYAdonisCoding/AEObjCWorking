//
//  AECustomViewFlowLayout.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AEAlignmentFlowLayoutType) {
    AEAlignmentFlowLayoutTypeCenter,
    AEAlignmentFlowLayoutTypeLeft,
    AEAlignmentFlowLayoutTypeRight,
};



NS_ASSUME_NONNULL_BEGIN

@interface AECustomViewFlowLayout : UICollectionViewFlowLayout

    //全能初始化方法 其他方式初始化最终都会走到这里
-(instancetype)initWithType:(AEAlignmentFlowLayoutType)type cellSpace:(CGFloat)cellSpace;

@end

NS_ASSUME_NONNULL_END
