//
//  AEGCDViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/17.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEGCDViewController.h"
#import "AEUserCenter.h"


@interface AEGCDViewController () {
    AEUserCenter *center;
}

@end

@implementation AEGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self test1];
//    center = [[AEUserCenter alloc] init];
//
//    for (int i = 0; i < 100; i++) {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [center AE_setObject:@(i) forKey:[NSString stringWithFormat:@"%d", i]];
//            NSLog(@"%@", [NSString stringWithFormat:@"%d", i]);
//
//    });
//    }
//    for (int i = 0; i < 100; i++) {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [center AE_setObject:@(i) forKey:[NSString stringWithFormat:@"%03d", i]];
//            NSLog(@"%@", [NSString stringWithFormat:@"%03d", i]);
//    });
//    }
//    NSLog(@"%@", center);
    
    [self test3];
}
- (void)test3 {
    NSLog(@"%@", @"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", @"2");
        [self performSelector:@selector(printLog) withObject:nil afterDelay:0];
        NSLog(@"%@", @"4");
    });
    NSLog(@"%@", @"5");
}
- (void)printLog { NSLog(@"%@", @"3"); }
- (void)test2 {
    NSLog(@"%@", @"1");
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", @"2");
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@", @"3");
        });
        NSLog(@"%@", @"4");
    });
    NSLog(@"%@", @"5");
}

// 同步串行 没有问题
- (void)test1 {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [self testSomething];
    });
}

/// 死锁 原因队列引起的循环等待
- (void)test {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self testSomething];
    });
}
- (void)testSomething {
    NSLog(@"%@", @"来了");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"%@", [center AE_objectForKey:[NSString stringWithFormat:@"%d", i]]);
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"%@", [center AE_objectForKey:[NSString stringWithFormat:@"%03d", i]]);

        }
    });
    NSLog(@"%@", center);
}

@end
