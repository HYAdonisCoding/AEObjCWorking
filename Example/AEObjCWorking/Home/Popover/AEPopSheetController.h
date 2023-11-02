//
//  AEPopSheetController.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEPopoverController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AEPopSheetBlock)(NSInteger index, id object);

@protocol AEPopSheetDelegate <NSObject>

- (void)alertController:(UIViewController *)alertController selectRowNumber:(NSInteger)number;

@end



@interface AEPopSheetController : AEPopoverController

/** 代理 */
@property (nonatomic, weak) id<AEPopSheetDelegate> delegate;

/** 数据源 */
@property (nonatomic, strong) NSArray *dataArray;

/// 回调
@property (nonatomic, copy) AEPopSheetBlock block;

/// 弹出的控制器 可根据目标视图位置自动判断左右及上下
/// @param sourceView 目标视图
/// @param datas 显示数据
/// @param contentWidth 显示宽度
/// @param direction 方向
/// @param completionHandler 回调
- (instancetype)initWithSourceView:(UIView *)sourceView datas:(NSArray *)datas contentWidth: (CGFloat)contentWidth andDirection:(UIPopoverArrowDirection)direction completionHandler:(AEPopSheetBlock)completionHandler;

/// 背景颜色 默认白色
@property (nonatomic, strong) UIColor *backViewColor;
/// 文字颜色 默认黑色
@property (nonatomic, strong) UIColor *textColor;
/// 是否可滚动 默认不可滚动
@property (nonatomic, assign) BOOL scrollable;



@end

NS_ASSUME_NONNULL_END
