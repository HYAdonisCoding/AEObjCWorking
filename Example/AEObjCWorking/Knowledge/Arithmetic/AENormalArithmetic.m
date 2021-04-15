//
//  AENormalArithmetic.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/15.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AENormalArithmetic.h"

@implementation AENormalArithmetic
/* *************求一个无序数组的中位数************* */
int partSort(int a[], int start, int end)
{
    int low = start;
    int high = end;
    /// 选取关键字
    int key = a[end];
    while (low < high) {
        //左边找比key大的值
        while (low < high && a[low] <= key) {
            ++low;
        }
        /// 右边找比key小的值
        while (low < high && a[high] >= key) {
            --high;
        }
        if (low < high) {
            /// 找到后交换左右的值
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    return low;
}

int findMedian(int a[_Nullable], int aLen)
{
    int low = 0;
    int high = aLen - 1;
    int mid = (aLen - 1) / 2;
    int div = partSort(a, low, high);
    while (div != mid) {
        if (mid < div) {
            /// 左半区间找
            div = partSort(a, low, div - 1);
        } else {
            /// 右半区间找
            div = partSort(a, div + 1, high);
        }
    }
    return a[mid];
}


/* *************求一个无序数组的中位数************* */


/* *************查找第一个只出现一次的字符************* */
char findFirstChar(char *cha)
{
    char result = '\0';
    // 定义一个数组 用来存储各个字母出现次数
    int array[256];
    // 对数组进行初始化操作
    for (int i = 0; i < 256; i++) {
        array[i] = 0;
    }
    // 定义一个指针 指向当前字符串头部
    char *p = cha;
    // 便利每个字符
    while (*p != '\0') {
        /// 在字母对应存储位置 进行出现次数+1操作
        array[*(p++)]++;
    }
    /// 将p指针重新指向字符串头部
    p = cha;
    /// 便利每个字母的出现次数
    while (*p != '\0') {
        // 遇到第一个出现次数为1的字符,打印结果
        if (array[*p] == 1) {
            result = *p;
            break;
        }
        // 繁殖继续向后遍历
        p++;
    }
    return result;
}
/* *************查找第一个只出现一次的字符************* */


/* *************将有序数组a和b的值合并到一个数组result当中，且仍然保持有序************* */
void mergeList(int a[], int aLen, int b[], int bLen, int result[])
{
    /// 遍历数组a的指针
    int p = 0;
    /// 遍历数组b的指针
    int q = 0;
    // 记录当前存储位置
    int i = 0;
    /// 任意数组没有达到边界则进行遍历
    while (p < aLen && q < bLen) {
        /// 如果a数组对应位置的值小于b数组对应位置
        if (a[p] <= b[q]) {
            /// 存储a数组的值
            result[i] = a[p];
            // 移动a数组的遍历指针
            p++;
        } else {
            /// 存储b数组的值
            result[i] = b[q];
            /// 移动b数组的遍历指针
            q++;
        }
        // 指向合并结果的下一个存储位置
        i++;
    }
    // 如果a数组有剩余
    while (p < aLen) {
        // 将a数组剩余部分拼接到合并结果的后面
        result[i] = a[p++];
        i++;
    }
    // 如果b数组有剩余
    while (q < bLen) {
        // 将b数组剩余部分拼接到合并结果的后面
        result[i] = b[q++];
        i++;
    }
}

/* *************将有序数组a和b的值合并到一个数组result当中，且仍然保持有序************* */



/* *************字符串反转************* */
void char_reverse(char* cha)
{
    // 指向第一个字符
    char* begin = cha;
    // 指向最后一个字符
    char* end = cha + strlen(cha) - 1;
    while (begin < end) {
        /// 交换前后两个字符,同时移动指针
        char* temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
}
/* *************字符串反转************* */

@end
