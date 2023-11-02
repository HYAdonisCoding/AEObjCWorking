//
//  AEPreviewPDFView.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/25.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class AEPDFModel;

typedef void (^preview_block)(id data);

@interface AEPreviewPDFView : AEBaseView
@property (nonatomic, strong) AEPDFModel *model;
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
- (void)addAnimateCompationHandler:(void(^)(id data))compationHandler;
@end

NS_ASSUME_NONNULL_END
