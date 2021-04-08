//
//  AEMCBlock.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEMCBlock.h"

@implementation AEMCBlock
// 全局变量
int global_var = 4;
// 静态全局变量
static int static_global_var = 5;

- (void)method {
    int multipier = 6;
    int(^Block)(int) = ^(int num) {
        return num*multipier;
    };
    multipier = 4;
    
    NSLog(@"result is %d", Block(2));
}
/* block 不截获全局变量 静态全局变量 静态局部变量 截获局部变量*/
- (void)method1 {
    
    int(^Block)(int) = ^(int num) {
        return num*global_var;
    };
    global_var = 5;
    
    NSLog(@"result is %d", Block(2));
}

- (void)method2 {
    
    int(^Block)(int) = ^(int num) {
        return num*static_global_var;
    };
    static_global_var = 15;
    
    NSLog(@"result is %d", Block(2));
}

@end
