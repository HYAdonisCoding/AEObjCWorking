//
//  AEMCObject.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/17.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEMCObject.h"

@implementation AEMCObject

static NSThread *thread = nil;
// 标记是否需要继续事件循环
static BOOL runAways = YES;

+ (NSThread *)threadForDispatch {
    if (thread == nil) {
        @synchronized (self) {
            if (thread == nil) {
                // 线程创建
                thread = [[NSThread alloc] initWithTarget:self selector:@selector(runRquest) object:nil];
                [thread setName:@"com.imooc.thread"];
                [thread start];
            }
        }
    }
    return thread;
}

+ (void)runRquest {
    // 创建一个Source
    CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    
    // 创建RunLoop，同时向RunLoop的DefaultMode下面添加Source
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    // 如果可以运行
    while (runAways) {
        @autoreleasepool {
            // 令当前RunLoop运行在DefaultMode下面   1.0e10 自然对数 遥远的未来
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
        }
    }
    // 某一时机 静态变量runAways = NO时 可以保证跳出RunLoop,线程退出
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
}

@end
