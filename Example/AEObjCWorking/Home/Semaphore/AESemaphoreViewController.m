//
//  AESemaphoreViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/12/4.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AESemaphoreViewController.h"

@interface AESemaphoreViewController ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation AESemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundColor: [UIColor magentaColor]];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 50));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
    }];
}
- (void)semaphoreTest {
    // 创建信号量
    self.semaphore = dispatch_semaphore_create(0);
    NSLog(@"1");
    // 等待信号量，直到被释放
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"2");
    // 在这里执行你想要延迟执行的操作
    [self createNext];
    NSLog(@"3");
}

- (void)btnClicked {
    if (!self.semaphore) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              [self semaphoreTest];
          });
    } else {
        if (self.semaphore) {
            dispatch_semaphore_signal(self.semaphore);
        }
    }
    NSLog(@"btnClicked");
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if (self.semaphore) {
        dispatch_semaphore_signal(self.semaphore);
    }
    NSLog(@"touchesBegan");
}

- (void)createNext {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor magentaColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }];
    });
    
}
@end
