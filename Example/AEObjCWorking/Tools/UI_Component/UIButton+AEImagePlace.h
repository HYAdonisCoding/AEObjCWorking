//
//  UIButton+AEImagePlace.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/3/16.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, AEButtonEdgeInsetsStyle) {
    AEButtonEdgeInsetsStyleTop, // image在上，label在下
    AEButtonEdgeInsetsStyleLeft, // image在左，label在右
    AEButtonEdgeInsetsStyleBottom, // image在下，label在上
    AEButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (AEImagePlace)

///  设置button的titleLabel和imageView的布局样式，及间距
/// @param style titleLabel和imageView的布局样式
/// @param space titleLabel和imageView的间距
- (void)layoutButtonStyle:(AEButtonEdgeInsetsStyle)style space:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
