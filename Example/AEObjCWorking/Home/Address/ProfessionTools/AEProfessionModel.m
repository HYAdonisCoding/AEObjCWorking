//
//  AEProfessionModel.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/24.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEProfessionModel.h"

@implementation AEProfessionModel

@end

@implementation AEProfessionSubModel
/// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{
        @"professionList" : NSStringFromClass([AEProfessionModel class]),
    };
}
@end

@implementation AEProfessionSumModel
/// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{
        @"subProfession" : NSStringFromClass([AEProfessionSubModel class]),
    };
}
@end


@implementation AEProfessionSearchModel


@end
