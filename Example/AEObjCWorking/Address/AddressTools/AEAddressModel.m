//
//  AEAddressModel.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEAddressModel.h"


@implementation AEAddressModel

/// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{
        @"list" : NSStringFromClass([AEAddressModel class]),
    };
}

@end

@implementation ProvinceModel

@end

@implementation CityModel

@end

@implementation CountyModel

@end

@implementation TownModel

@end

