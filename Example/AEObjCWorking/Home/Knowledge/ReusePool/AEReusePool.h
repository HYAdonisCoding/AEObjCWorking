//
//  AEReusePool.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
/// 实现重用机制的类

#import "AEBaseModel.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEReusePool : AEBaseModel

/// 从重用池中取出一个可重用的view
- (UIView *)dequeueReusableView;

/// 向重用池中添加一个视图
/// @param view 视图
- (void)addUsingView:(UIView *)view;

/// 重置方法: 将当前使用中的视图移动到可重用队列当中
- (void)reset;

@end

NS_ASSUME_NONNULL_END
