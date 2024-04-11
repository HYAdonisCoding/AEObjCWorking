//
//  AETools.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/12/27.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AETools.h"

@implementation AETools{
    BOOL _lastResultValid;/// 上一次判断的结果
    BOOL _lastResult;/// 上一次判断的结果
}

+ (instancetype)sharedInstance {
    static AETools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AETools alloc] init];
    });
    return instance;
}

- (BOOL)judgeShowOrHideBar {
    // 如果上次的结果已经赋值了，直接返回上次的结果
    if (_lastResultValid) {
        return _lastResult;
    }
    // 否则，在这里添加您的逻辑判断
    BOOL result = YES;
    // 检查当天是否已经返回为 YES，如果是，则直接返回 NO
    NSDate *lastShownDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastShownDate"];
    if (lastShownDate && [self isSameDay:lastShownDate asDate:[NSDate date]]) {
        result = NO;
        // 更新上次的结果
        _lastResult = result;
        _lastResultValid = YES;
        return result;
    }
    [self setLocationBarShown];
    // 更新上次的结果
    _lastResult = result;
    _lastResultValid = YES;
    return result;
}

// 检查两个日期是否是同一天
- (BOOL)isSameDay:(NSDate *)date1 asDate:(NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date1];
    NSDateComponents *components2 = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date2];
    return (components1.year == components2.year &&
            components1.month == components2.month &&
            components1.day == components2.day);
}

- (void)setLocationBarShown {
    // 设置当天已经展示了位置栏
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastShownDate"];
}

// 清空本地缓存
+ (void)clearLocalCaches {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasShownGuide"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 清理cache文件夹下的缓存文件
    
}

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
