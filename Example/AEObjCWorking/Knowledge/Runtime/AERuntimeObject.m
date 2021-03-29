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

void testIMP(void)
{
    NSLog(@"%@", @"invoke");
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
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%@", @"");
}

@end
