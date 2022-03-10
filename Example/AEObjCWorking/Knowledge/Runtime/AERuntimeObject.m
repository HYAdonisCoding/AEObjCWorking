//
//  AERuntimeObject.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AERuntimeObject.h"
#import <objc/runtime.h>

@implementation AERuntimeObject
+ (void)load {
    // 获取方法
    Method test1 = class_getInstanceMethod(self, @selector(test1));
    Method otherTest = class_getInstanceMethod(self, @selector(otherTest));
    // 交换
    method_exchangeImplementations(test1, otherTest);
}

- (void)test1 {
    NSLog(@"test1");
}
- (void)otherTest {
    [self otherTest];
    NSLog(@"otherTest");
}

void testIMP(void)
{
    NSLog(@"%@", @"test invoke");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(test)) {
        NSLog(@"%@", @"");
        // 动态添加test方法的实现
        class_addMethod(self, @selector(test), (IMP)testIMP, "v@:");
        return YES;
        //测试消息转发流程
//        return NO;
    }
    return [super resolveInstanceMethod:sel];
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        NSLog(@"%@", @"");
        return nil;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        NSLog(@"%@", @"");
        // v 代表返回值是void类型的 @代表第一个参数类型是id，即 self
        // : 代表第二个参数类型是SEL类型的 即 @selector(test)
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%@", @"");
}

@end
