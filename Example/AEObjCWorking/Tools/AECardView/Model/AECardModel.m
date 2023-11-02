//
//  AECardModel.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AECardModel.h"

@implementation AECardModel

/// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{
        @"detailModel" : NSStringFromClass([AECardDetailModel class]),
    };
}

@end

@implementation AECardDetailModel

@end
