//
//  AEConvenientTool.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEConvenientTool : AEBaseModel
+ (NSString *)uuid;
+ (void)ae_customLog:(id)data;

///随机颜色
+ (UIColor *)randomColor;
///随机汉字
+ (NSMutableString*)randomCreatChinese:(NSInteger)count;

/// 智能排序
/// @param dataArray 数据源
/// @param sectionArray 分组数据 方法结束后进行回写
/// @param sectionTitlesArray 分组标题数据 方法结束后进行回写
/// @param propertyName 要排序的属性
+ (void)sortWithDataArray:(NSArray * _Nonnull)dataArray sectionArray:(NSArray *_Nonnull* _Nonnull)sectionArray sectionTitlesArray:(NSArray *_Nonnull* _Nonnull)sectionTitlesArray propertyName:(NSString *)propertyName;
@end

NS_ASSUME_NONNULL_END
