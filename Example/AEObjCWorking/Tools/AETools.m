//
//  AETools.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/12/27.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AETools.h"

@implementation AETools


//判断当前时间是否在某个区间
+ (BOOL)isCurrentTimeBetweenStartTime:(NSString *)startStr andEndTime:(NSString *)endStr format:(NSString *)format{
    /// 开始、结束时间都有
    if (startStr.length > 0 &&
        endStr.length > 0) {
        return ([self isCurrentTimeGreaterOrEqualThan:startStr format:format] &&
                       [self isCurrentTimeLessOrEqualThan:endStr format:format]);
    } else
        /// 有开始、没有结束时间
    if (startStr.length > 0 &&
        endStr.length <= 0) {
        return [self isCurrentTimeGreaterOrEqualThan:startStr format:format];
        
    } else
        /// 没有开始、有结束时间
    if (startStr.length <= 0 &&
        endStr.length > 0) {
        return [self isCurrentTimeLessOrEqualThan:endStr format:format];
    }
    return NO;
}


/// 判断当前时间是否大于等于某个时间
/// - Parameters:
///   - timeString: 时间
///   - format: 时间格式
+ (BOOL)isCurrentTimeGreaterOrEqualThan:(NSString *)timeString format:(NSString *)format {
    return [self compareCurrentTimeAnd:timeString WithFormatter:format] != NSOrderedAscending;
}

/// 判断当前时间是否小于等于某个时间
/// - Parameters:
///   - timeString: 时间
///   - format: 时间格式
+ (BOOL)isCurrentTimeLessOrEqualThan:(NSString *)timeString format:(NSString *)format {
    return [self compareCurrentTimeAnd:timeString WithFormatter:format] != NSOrderedDescending;
}

//比较给定时间和当前时间先后关系
+ (NSComparisonResult)compareCurrentTimeAnd:(NSString *)timeString WithFormatter:(NSString *)formatter {
    //获取当前时间
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.locale = [NSLocale systemLocale];
    dateFormat.calendar =[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [dateFormat setDateFormat:formatter];
    NSString *todayStr = [dateFormat stringFromDate:today];//将当前日期时间转换成字符串
    return [todayStr compare:timeString];
}

@end
