//
//  AEDynamicLabel.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/5/10.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEDynamicLabel : AEBaseView

+ (instancetype)sharedWithText:(NSString *)text speed:(double)speed frame:(CGRect)frame;

    /// 文字
@property (nonatomic, copy) NSString *text;

    /// 速度
@property (nonatomic, assign) double speed;

@end

NS_ASSUME_NONNULL_END
