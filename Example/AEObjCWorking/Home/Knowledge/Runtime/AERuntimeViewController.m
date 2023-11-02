//
//  AERuntimeViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AERuntimeViewController.h"
#import "AERuntimeObject.h"
#import "AEAccount.h"

@interface AERuntimeViewController ()

@end

@implementation AERuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AERuntimeObject *runtimeObject = [[AERuntimeObject alloc] init];
    // 调用test方法，只有声明，没有实现
    [runtimeObject test];
    /// 方法交换
    [runtimeObject test1];
    
    
    AEAccount *account = [[AEAccount alloc] init];
    account.name = @"imooc";
    account.sex = @"男";
    account.birthday = @"2017-01-01";
}

/*
#pragma mark - runtime
 数据结构
 类对象与元类对象
 消息传递
 方法缓存
 消息转发
 Method-Swizzling
 动态添加方法
 动态方法结息
*/

@end
