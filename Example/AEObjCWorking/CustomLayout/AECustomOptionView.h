//
//  AECustomOptionView.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEBaseView.h"

@class AECustomOptionModel;

typedef void(^AEOperationBlock)(id _Nullable data);

NS_ASSUME_NONNULL_BEGIN

@interface AECustomOptionView : AEBaseView

+ (instancetype)sharedWithDataArray:(NSArray *)dataArray frame:(CGRect)frame;

/** 数组 */
@property (nonatomic, strong) NSArray<AECustomOptionModel *> *dataArray;

/** 返回数据 */
@property (nonatomic, copy) AEOperationBlock block;

@end

NS_ASSUME_NONNULL_END
