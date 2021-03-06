//
//  AEPopoverController.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEPopoverController : AEBaseViewController

/** 要知道从哪个视图,哪个位置,弹出来多大的内容 */

/// 弹出的控制器
/// @param sourceView 目标视图
/// @param sourceRect 弹出视图显示位置
/// @param contentSize 弹出视图大小
/// @param direction 箭头位置
- (instancetype)initWithSourceView: (UIView *)sourceView bySourceRect: (CGRect)sourceRect andContentSize: (CGSize)contentSize andDirection: (UIPopoverArrowDirection)direction;
/** 弹出的内容多大 */
@property (nonatomic, readonly) CGSize contentSize;
/** 哪个位置弹出来的 */
@property (nonatomic, readonly) CGRect sourceRect;
/** 哪个视图弹出来的 */
@property (nonatomic, readonly) UIView *sourceView;
/** 推出方向 */
@property (nonatomic, assign) NSInteger direction;

@end

NS_ASSUME_NONNULL_END
