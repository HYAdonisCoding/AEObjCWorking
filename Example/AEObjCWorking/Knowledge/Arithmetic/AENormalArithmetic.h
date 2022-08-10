//
//  AENormalArithmetic.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/15.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface AENormalArithmetic : AEBaseModel
/// 求一个无序数组的中位数
int findMedian(int a[_Nullable], int aLen);

// 查找第一个只出现一次的字符
char findFirstChar(char* cha);

// 将有序数组a和b的值合并到一个数组result当中，且仍然保持有序
void mergeList(int a[], int aLen, int b[], int bLen, int result[]);

/* *************字符串反转************* */
void char_reverse(char* cha);
@end

NS_ASSUME_NONNULL_END
