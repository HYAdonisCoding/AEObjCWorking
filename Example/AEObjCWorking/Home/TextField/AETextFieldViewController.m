//
//  AETextFieldViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/1/16.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AETextFieldViewController.h"
#import "AETextField.h"


@interface AETextFieldViewController ()
@property (strong, nonatomic) NSMutableDictionary *customerGroupResourcesDictionary;
@end

@implementation AETextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"judgeShowOrHideBar: %hhd", [[AETools sharedInstance] judgeShowOrHideBar]);
    
    self.customerGroupResourcesDictionary = @{}.mutableCopy;
    self.customerGroupResourcesDictionary[@"userId"] = @{@"N": @1}.mutableCopy;
    [self rest3];
}
- (void)configUI {
    [super configUI];
    UIColor *backgroundColor = [UIColor orangeColor];
    UITextField *tf = [[UITextField alloc] init];
    tf.backgroundColor = backgroundColor;
    [self.view addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(10);
        make.left.height.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    UITextField *tf1 = [[UITextField alloc] init];
    tf1.backgroundColor = backgroundColor;
    [self.view addSubview:tf1];
    [tf1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tf.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(24);
    }];
    
    AETextField *aetf = [[AETextField alloc] initWithCursorHeight:16];
    aetf.backgroundColor = backgroundColor;
    [self.view addSubview:aetf];
    [aetf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tf1.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(24);
    }];
}

- (void)rest {
    self.customerGroupResourcesDictionary = @{}.mutableCopy;
    self.customerGroupResourcesDictionary[@"userId"] = @{};
    NSMutableDictionary *customerGroupResourcesDic = self.customerGroupResourcesDictionary[@"userId"];
    NSLog(@"%@", customerGroupResourcesDic);
    self.customerGroupResourcesDictionary[@"userId"] = @{@"A": @"123456"};
//    customerGroupResourcesDic = @{@"A": @"123456"};
    NSLog(@"%@", customerGroupResourcesDic);
    
//    self.customerGroupResourcesDictionary[@"userId"] = customerGroupResourcesDic;
    
}
- (void)rest2 {
    // 初始化 customerGroupResourcesDic 为一个空字典
    NSMutableDictionary *customerGroupResourcesDic = [NSMutableDictionary dictionary];
    
    // 将 customerGroupResourcesDic 赋值给 self.customerGroupResourcesDictionary[@"userId"]
    customerGroupResourcesDic = self.customerGroupResourcesDictionary[@"userId"];
    
    // 打印初始值
    NSLog(@"%@", customerGroupResourcesDic);
    
    // 修改 self.customerGroupResourcesDictionary[@"userId"] 中的值
    self.customerGroupResourcesDictionary[@"userId"] = @{@"A": @"123456"};
    
    // 打印修改后的值
    NSLog(@"%@", customerGroupResourcesDic);
}

- (void)rest3 {
    
    // 直接赋值，使用引用而不是复制
    NSMutableDictionary *customerGroupResourcesDic = self.customerGroupResourcesDictionary[@"userId"];
    
    // 打印初始值
    NSLog(@"%@", customerGroupResourcesDic);
    
    // 直接修改 self.customerGroupResourcesDictionary[@"userId"] 中的值
    [self.customerGroupResourcesDictionary[@"userId"] removeAllObjects];
    [self.customerGroupResourcesDictionary[@"userId"] addEntriesFromDictionary:@{@"A": @"123456"}];
    
    // 打印修改后的值
    NSLog(@"%@", customerGroupResourcesDic);

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
