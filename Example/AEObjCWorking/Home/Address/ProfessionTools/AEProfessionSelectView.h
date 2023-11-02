//
//  AEProfessionSelectView.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEAddressSelectView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEProfessionSelectView : UIView
/// 默认高度
@property (nonatomic, assign) NSUInteger defaultHeight;
/// 默认标题高度
@property (nonatomic, assign) CGFloat titleScrollViewH;
/// 标题
@property (nonatomic, copy) NSString *title;

/// 创建视图
- (UIView *)initAddressView;
/// 显示
- (void)addAnimate;

/// 显示并回调
/// @param compationHandler 回调
- (void)addAnimateCompationHandler:(AEAddressSelectBlock)compationHandler;

@end

NS_ASSUME_NONNULL_END
