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

    ///随机颜色
+ (UIColor *)randomColor;
    ///随机汉字
+ (NSMutableString*)randomCreatChinese:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
