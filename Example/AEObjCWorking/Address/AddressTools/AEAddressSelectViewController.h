//
//  AEAddressSelectViewController.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBaseViewController.h"

#import "AEAddressSelectView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEAddressSelectViewController : AEBaseViewController

/// 地址选择
/// @param province 已选择省
/// @param city 已选择市
/// @param district 已选择区
/// @param chooseLocationBlock 选择完成回调
+ (instancetype)standardLocationViewWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district completionHandler:(AEAddressSelectBlock)chooseLocationBlock;

@end

NS_ASSUME_NONNULL_END
