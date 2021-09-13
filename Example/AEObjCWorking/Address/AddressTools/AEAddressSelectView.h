//
//  AEAddressSelectView.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AEAddressSelectBlock)(NSString * _Nullable titleAddress, NSString * _Nullable titleID);

NS_ASSUME_NONNULL_BEGIN

@protocol  AEAddressSelectViewDelegate <NSObject>
-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID;
@end

@interface AEAddressSelectView : UIView
/// 代理
@property (nonatomic, weak) id<AEAddressSelectViewDelegate> delegate;
/// 默认高度
@property (nonatomic, assign) NSUInteger defaultHeight;
/// 默认标题高度
@property (nonatomic, assign) CGFloat titleScrollViewH;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 已选择数组
@property (nonatomic, strong) NSMutableArray *titleIDMarr;

/// 这个属性如果是新增地址的时候设置成false
@property (nonatomic, assign) BOOL isChangeAddress;
/// 创建视图
- (UIView *)initAddressView;
/// 显示
- (void)addAnimate;

/// 显示并回调
/// @param compationHandler 回调
- (void)addAnimateCompationHandler:(AEAddressSelectBlock)compationHandler;

@end

NS_ASSUME_NONNULL_END
