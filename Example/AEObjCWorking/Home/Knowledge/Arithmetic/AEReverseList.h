//
//  AEReverseList.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/15.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

// 定义一个链表
struct Node {
    int data;
    struct Node *next;
};

@interface AEReverseList : AEBaseModel
// 链表反转
struct Node* reverseList(struct Node *head);
// 构造一个链表
struct Node* constructList(void);
// 打印链表中的数据
void printList(struct Node *head);

@end

NS_ASSUME_NONNULL_END
