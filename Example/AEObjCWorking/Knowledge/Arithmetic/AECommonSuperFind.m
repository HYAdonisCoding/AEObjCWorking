//
//  AECommonSuperFind.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/15.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AECommonSuperFind.h"


@implementation AECommonSuperFind

- (NSArray<UIView *> *)findCommonSuperView:(UIView *)view other:(UIView *)viewOther {
    /// 保存结果的数组
    NSMutableArray *result = [NSMutableArray array];
    /// 查找第一个视图的所有父视图
    NSArray *arrayOne = [self findSuperViews:view];
    /// 查找第二个视图的所有父视图
    NSArray *arrayOther = [self findSuperViews:viewOther];
    int i = 0;
    /// 越界限制条件
    while (i < MIN((int)arrayOne.count, (int)arrayOther.count)) {
        /// 倒序方式获取各个视图的父视图
        UIView *superOne = [arrayOne objectAtIndex:arrayOne.count - i - 1];
        UIView *superOther = [arrayOne objectAtIndex:arrayOther.count - i - 1];
        /// 比较如果相等则为共同父视图
        if (superOne == superOther) {
            [result addObject:superOne];
            i++;
        } else {
            /// 如果不相等,则结束遍历
            break;
        }
    }
    return result;
}
- (NSArray <UIView *> *)findSuperViews:(UIView *)view {
    /// 初始化为第一父视图
    UIView *temp = view.superview;
    /// 保存结果的数组
    NSMutableArray *result = [NSMutableArray array];
    while (temp) {
        [result addObject:temp];
        /// 顺着superview指针一直向上查找
        temp = temp.superview;
    }
    return result;
}
@end
