//
//  AEUserCenter.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/17.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEUserCenter.h"

@interface AEUserCenter() {
    // 定义一个并发队列
    dispatch_queue_t concurrent_queue;
    // 用户数据中心, 可能多个线程需要数据访问
    NSMutableDictionary *userCenterDic;
}

@end

// 多读单写模型
@implementation AEUserCenter

- (instancetype)init {
    self = [super init];
    if (self) {
        // 创建并发队列
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        userCenterDic = [NSMutableDictionary dictionary];
    }
    return self;
}
- (id)AE_objectForKey:(NSString *)key {
    __block id obj;
    // 同步读取指定数据 立刻返回调用结果
    dispatch_sync(concurrent_queue, ^{
        obj = [userCenterDic objectForKey:key];
    });
    return obj;
}
- (void)AE_setObject:(id)obj forKey:(NSString *)key {
    // 异步栅栏调用设置数据
    dispatch_barrier_async(concurrent_queue, ^{
        [userCenterDic setObject:obj forKey:key];
    });
}
@end
