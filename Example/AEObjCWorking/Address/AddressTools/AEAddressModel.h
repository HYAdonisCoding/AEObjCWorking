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
