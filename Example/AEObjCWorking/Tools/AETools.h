//
//  AETools.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/12/27.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AETools : NSObject
//判断当前时间是否在某个区间
+ (BOOL)isCurrentTimeBetweenStartTime:(NSString *)startStr andEndTime:(NSString *)endStr format:(NSString *)format;

/// 判断当前时间是否大于等于某个时间
/// - Parameters:
///   - timeString: 时间
///   - format: 时间格式
+ (BOOL)isCurrentTimeGreaterOrEqualThan:(NSString *)timeString format:(NSString *)format;

/// 判断当前时间是否小于等于某个时间
/// - Parameters:
///   - timeString: 时间
///   - format: 时间格式
+ (BOOL)isCurrentTimeLessOrEqualThan:(NSString *)timeString format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
