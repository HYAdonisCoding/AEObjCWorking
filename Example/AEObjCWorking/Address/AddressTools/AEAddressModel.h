//
//  AEAddressModel.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEAddressModel : NSObject
/// 编码
@property (nonatomic, copy) NSString *code;
/// 名称
@property (nonatomic, copy) NSString *area;

// 辖区列表 只有省编码说明是市,既有省编码又有市编码说明是区
/// 辖区列表
@property (nonatomic, strong) NSArray<AEAddressModel *> *list;
/// 省编码
@property (nonatomic, copy) NSString * pCode;
/// 市编码
@property (nonatomic, copy) NSString * cCode;


@end

@interface ProvinceModel : NSObject
@property(nonatomic,copy)NSString *created_time;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger is_enabled;
@property(nonatomic,copy)NSString *province_name;
@property(nonatomic,assign)NSInteger seq_no;
@property(nonatomic,copy)NSString *updated_time;
@property(nonatomic,assign)NSInteger updated_user;
@end

@interface CityModel : NSObject
@property(nonatomic,copy)NSString *city_name;
@property(nonatomic,copy)NSString *created_time;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger is_cod;
@property(nonatomic,assign)NSInteger is_enabled;
@property(nonatomic,assign)NSInteger province_id;
@property(nonatomic,assign)NSInteger seq_no;
@property(nonatomic,copy)NSString *updated_time;
@property(nonatomic,assign)NSInteger updated_user;
@end

@interface CountyModel : NSObject
@property(nonatomic,assign)NSInteger city_id;
@property(nonatomic,copy)NSString *county_name;
@property(nonatomic,copy)NSString *created_time;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger is_enabled;
@property(nonatomic,assign)NSInteger seq_no;
@property(nonatomic,copy)NSString *updated_time;
@property(nonatomic,assign)NSInteger updated_user;
@end

@interface TownModel : NSObject
@property(nonatomic,assign)NSInteger county_id;
@property(nonatomic,copy)NSString *town_name;
@property(nonatomic,copy)NSString *created_time;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,assign)NSInteger is_enabled;
@property(nonatomic,assign)NSInteger seq_no;
@property(nonatomic,copy)NSString *updated_time;
@property(nonatomic,assign)NSInteger updated_user;
@end

NS_ASSUME_NONNULL_END
