//
//  AEProgressController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/9/26.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AEProgressController.h"
#import "AERoundedProgressView.h"

@interface AEProgressController ()

@end

@implementation AEProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // 创建并添加自定义圆角进度条
    AERoundedProgressView *progressView = [[AERoundedProgressView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 20)];
    progressView.progress = 0.3; // 初始进度
    [self.view addSubview:progressView];
    
    // 模拟网络进度更新
    [self performSelector:@selector(simulateProgress:) withObject:progressView afterDelay:1.0];
    [self checkAllAlertsWithJson:@{
        @"victimsFlag": @"1",
        @"RemindDate": @"1",
        @"payeeCheckFlag": @"0",
        @"sharescreenFlag": @"1",
        @"victimsShareFlag": @"1",
        @"isYLJ": @"1",
    } requestDic:@{} completion:^{
        NSLog(@"弹框流程结束");
    }];
}

// 模拟网络进度
- (void)simulateProgress:(AERoundedProgressView *)progressView {
    [UIView animateWithDuration:2.0 animations:^{
        progressView.progress = 0.8;
    }];
}


- (void)checkAllAlertsWithJson:(NSDictionary *)json requestDic:(NSDictionary *)requestDic completion:(void(^)(void))completion {
    // 创建包含所有弹框条件的数组，每个元素是一个字典，包含条件标识和提示信息
    NSArray *alertConditions = @[
        @{@"flagKey": @"victimsFlag", @"message": json[@"victimsData"] ?: @"诈骗警告"},
        @{@"flagKey": @"RemindDate", @"message": @"短时间内多次转账相同金额"},
        @{@"flagKey": @"payeeCheckFlag", @"message": @"收款账户异常"},
        @{@"flagKey": @"sharescreenFlag", @"message": @"屏幕共享警告"},
        @{@"flagKey": @"victimsShareFlag", @"message": @"复合弹框警告"},
        @{@"flagKey": @"isYLJ", @"message": @"养老金提醒"}
    ];
    
    // 递归调用检查每一个条件
    [self checkAlertAtIndex:0 withConditions:alertConditions json:json requestDic:requestDic completion:completion];
}

- (void)checkAlertAtIndex:(NSInteger)index withConditions:(NSArray *)conditions json:(NSDictionary *)json requestDic:(NSDictionary *)requestDic completion:(void(^)(void))completion {
    // 判断数组是否越界
    if (index >= conditions.count) {
        // 所有弹框判断完毕后的处理逻辑
        if (completion) {
            completion();
        }
        return;
    }
    
    // 获取当前的条件
    NSDictionary *currentCondition = conditions[index];
    NSString *flagKey = currentCondition[@"flagKey"];
    NSString *message = currentCondition[@"message"];
    
    // 判断是否需要弹框
    if ([[json valueForKey:flagKey] isEqualToString:@"1"]) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
        
        [vc addAction:[UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            // 继续检查下一个条件
            [self checkAlertAtIndex:index + 1 withConditions:conditions json:json requestDic:requestDic completion:completion];
        }]];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    } else {
        // 当前条件不满足，继续检查下一个条件
        [self checkAlertAtIndex:index + 1 withConditions:conditions json:json requestDic:requestDic completion:completion];
    }
}
@end
