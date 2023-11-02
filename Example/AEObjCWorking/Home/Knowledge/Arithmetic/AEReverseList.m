//
//  AEReverseList.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/15.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEReverseList.h"

@implementation AEReverseList
struct Node* reverseList(struct Node *head)
{
    // 定义遍历指针,初始化为头结点
    struct Node *p = head;
    /// 反转后的链表头部
    struct Node *newH = NULL;
    
    // 遍历链表
    while (p != NULL) {
        /// 记录下一个结点
        struct Node *temp = p->next;
        // 当前结点的next指向链表头部
        p->next = newH;
        /// 更改新链表头部为当前结点
        newH = p;
        // 移动指针p
        p = temp;
    }
    // 返回反转后的链表头结点
    return newH;
}
struct Node* constructList(void)
{
    // 头结点定义
    struct Node *head = NULL;
    // 记录当前尾结点
    struct Node *cur = NULL;
    
    for (int i = 1; i < 5; i++) {
        struct Node *node = malloc(sizeof(struct Node));
        node->data = i;
        node->next = NULL;
        // 头结点为空，新结点即为头结点
        if (head == NULL) {
            head = node;
        }
        else {
            /// 当前结点的next为新结点
            cur->next = node;
        }
        // 设置当前结点为新结点
        cur = node;
    }
    return head;
}
void printList(struct Node *head)
{
    struct Node* temp = head;
    while (temp != NULL) {
        printf("node is %d \n", temp->data);
        temp = temp->next;
    }
}
@end
