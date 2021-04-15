//
//  AEArithmeticViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/15.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEArithmeticViewController.h"
#import "AENormalArithmetic.h"
#import "AEReverseList.h"
#import "AEBaseView.h"
#import "AECommonSuperFind.h"
@interface AEArithmeticViewController ()

@end

@implementation AEArithmeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AEBaseView *view1;
    AEBaseView *view2;
    AEBaseView *view3;
    for (int i = 0; i < 11; i++) {
        AEBaseView *view = [AEBaseView new];
        view.backgroundColor = [UIColor yellowColor];
        view.layer.borderWidth = 1;
        view.frame = CGRectMake(10+i*10, 100+i*10, 100, 100);
        if (i == 0) {
            
            [self.view addSubview:view];
        } else {
            [view3 addSubview:view];
        }
        view3 = view;
        if (i == 9) {
            view1 = view;
        }
    }
    for (int i = 0; i < 11; i++) {
        AEBaseView *view = [AEBaseView new];
        view.backgroundColor = [UIColor greenColor];
        view.layer.borderWidth = 1;
        view.frame = CGRectMake(20-i*10, 100+i*10, 100, 100);
        if (i == 0) {
            
            [self.view addSubview:view];
        } else {
            [view3 addSubview:view];
        }
        view3 = view;
        if (i == 9) {
            view2 = view;
        }
    }
    AECommonSuperFind *find = [AECommonSuperFind new];
    NSArray *resultArray = [find findCommonSuperView:view1 other:view2];
    NSLog(@"resultArray- %lu: %@", (unsigned long)resultArray.count, resultArray);
    
    // 无序数组查找中位数
    int list[10] = {12,3,10,8,6,7,11,13,9};
    // 3 6 7 8 9 10 11 12 13
    //         ^
    int median = findMedian(list, 10);
    printf("the median is %d \n", median);
    
    // 查找第一个只出现一次的字符
    char cha[] = "gabaccdeff";
    char fc = findFirstChar(cha);
    printf("this char is %c \n", fc);
    
    //// 有序数组归并
    int a[5] = {1,4,6,7,9};
    int b[8] = {2,3,5,6,8,10,11,12};
    
    // 用于存储归并结果
    int result[13];
    // 归并操作
    mergeList(a, 5, b, 8, result);
    // 打印归并结果
    printf("merge result is ");
    for (int i = 0; i < 13; i++) {
        printf("%d ", result[i]);
    }
    
    // 字符串反转
    char ch[] = "hello,world";
    char_reverse(ch);
    printf("\nreverse result is %s \n", ch);

    // 单链表反转
    struct Node* head = constructList();
    printList(head);
    printf("---------\n");
    struct Node* newHead = reverseList(head);
    printList(newHead);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
