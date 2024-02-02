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

@end

@implementation AETextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
