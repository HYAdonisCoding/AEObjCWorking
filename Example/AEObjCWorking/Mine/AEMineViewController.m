//
//  AEMineViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/10/31.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEMineViewController.h"


@interface AEMineViewController ()

@end
@implementation AEMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)configEvent {
    [super configEvent];
    
    self.dataArray = [self getLocalJsonData:@"mine_data"];
    if (self.dataArray.count <= 0) {
        
        self.dataArray = @[@"AEScrollViewController",];
    }
}

- (void)configUI {
    [super configUI];
    
    // 创建一个按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightButtonTapped)];
    
    // 将按钮设置为导航栏的右侧按钮
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)rightButtonTapped {
    // 按钮被点击时的处理逻辑
    NSLog(@"右侧按钮被点击");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"清空本地缓存？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AETools clearLocalCaches];
    }];
    [alert addAction:action];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
