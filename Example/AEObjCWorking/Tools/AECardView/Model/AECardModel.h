//
//  AECardModel.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AECardDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface AECardModel : NSObject

/// 详情
@property (nonatomic, copy) NSArray<AECardDetailModel *> *detailModel;

/// 标题
@property (nonatomic, copy) NSString *title;


@end

@interface AECardDetailModel : NSObject

/// 子标题
@property (nonatomic, copy) NSString *subTitle;

/// 详情
@property (nonatomic, copy) NSString *detail;


@end

NS_ASSUME_NONNULL_END
