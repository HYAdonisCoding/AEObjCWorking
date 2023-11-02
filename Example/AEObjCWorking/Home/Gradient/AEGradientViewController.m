//
//  AEGradientViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/5/12.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEGradientViewController.h"

@interface AEGradientViewController ()

/// <#Description#>
@property (nonatomic, strong) UIView *gradientView;
@end

@implementation AEGradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self colorNotEqualization];
}
// 颜色不均
- (void)colorNotEqualization1 {
    UIView *gradientView = [[UIView alloc] init];
//    gradientView.frame = CGRectMake(20, 80, 50, 500);
    gradientView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:gradientView];
    [gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(50, 500));
    }];
//    self.gradientView = gradientView;
    
    UIView *gradientView1 = [[UIView alloc] init];
    gradientView1.backgroundColor = [UIColor purpleColor];
    [gradientView addSubview:gradientView1];
    [gradientView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(gradientView.mas_centerY);
            make.left.right.bottom.mas_equalTo(0);
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        // 0%-50%从绿、黄、橙到红渐变，50%以后为紫色
        gradientLayer.colors =
        @[(__bridge id)[UIColor greenColor].CGColor,
          (__bridge id)[UIColor yellowColor].CGColor,
          (__bridge id)[UIColor orangeColor].CGColor,
          (__bridge id)[UIColor redColor].CGColor];
        gradientLayer.locations = @[@0, @0.33, @0.67, @1];
        gradientLayer.startPoint = CGPointMake(0.5, 1);
        gradientLayer.endPoint = CGPointMake(0.5, 0);
        gradientLayer.frame = CGRectMake(0, 0, 50, 500/2);
        [gradientView1.layer addSublayer:gradientLayer];
    });
    
    
    // 添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"0%    0.0, 1.0, 0.0 RGB";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.bottom.mas_equalTo(gradientView.mas_bottom);
    }];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    // 246/255 190/255 65/255
    label1.text = @"25%    1.0, 0.7, 0.3 RGB";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_bottom).offset(-125);
    }];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label2.text = @"50%    1.0, 0.0, 0.0 RGB";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_centerY);
    }];
    UILabel *label21 = [[UILabel alloc] initWithFrame:CGRectZero];
    // 175/255 36/255 67/255
    label21.text = @"75%    1.0, 0.2, 0.3 RGB";
    [self.view addSubview:label21];
    [label21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_centerY).offset(-125);
    }];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
    label3.text = @"100%    0.5, 0.0, 0.5 RGB";
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.top.mas_equalTo(gradientView.mas_top);
    }];
}
// 颜色不均
- (void)colorNotEqualization {
    UIView *gradientView = [[UIView alloc] init];
//    gradientView.frame = CGRectMake(20, 80, 50, 500);
    [self.view addSubview:gradientView];
    [gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(50, 500));
    }];
    self.gradientView = gradientView;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        // 0%-50%从绿、黄、橙到红渐变，50%以后为紫色
        gradientLayer.colors =
        @[(__bridge id)[UIColor greenColor].CGColor,
          (__bridge id)[UIColor yellowColor].CGColor,
          (__bridge id)[UIColor orangeColor].CGColor,
          (__bridge id)[UIColor redColor].CGColor,
//          (__bridge id)[UIColor purpleColor].CGColor,
          (__bridge id)[UIColor purpleColor].CGColor];
        gradientLayer.locations = @[@0, @0.2, @0.4, @0.5, @1];
        gradientLayer.startPoint = CGPointMake(0.5, 1);
        gradientLayer.endPoint = CGPointMake(0.5, 0);
        gradientLayer.frame = CGRectMake(0, 0, 50, 500);
        [self.gradientView.layer addSublayer:gradientLayer];
    });
    
    
    // 添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"0%    0.0, 1.0, 0.0 RGB";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.bottom.mas_equalTo(gradientView.mas_bottom);
    }];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    // 246/255 190/255 65/255
    label1.text = @"25%    1.0, 0.7, 0.3 RGB";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_bottom).offset(-125);
    }];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    
    label2.text = @"50%    1.0, 0.0, 0.0 RGB";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_centerY);
    }];
    UILabel *label21 = [[UILabel alloc] initWithFrame:CGRectZero];
    label21.text = @"75%    0.5, 0.0, 0.5 RGB";
    [self.view addSubview:label21];
    [label21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_centerY).offset(-125);
    }];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
    label3.text = @"100%    0.5, 0.0, 0.5 RGB";
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.top.mas_equalTo(gradientView.mas_top);
    }];
}

// 颜色均分
- (void)colorEqualization {
    UIView *gradientView = [[UIView alloc] init];
//    gradientView.frame = CGRectMake(20, 80, 50, 500);
    [self.view addSubview:gradientView];
    [gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(50, 500));
    }];
    self.gradientView = gradientView;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        // 0%-50%从绿、黄、橙到红渐变，50%以后为紫色
        gradientLayer.colors =
        @[(__bridge id)[UIColor greenColor].CGColor,
          (__bridge id)[UIColor yellowColor].CGColor,
          (__bridge id)[UIColor orangeColor].CGColor,
          (__bridge id)[UIColor redColor].CGColor,
          (__bridge id)[UIColor purpleColor].CGColor];
        gradientLayer.locations = @[@0, @0.25, @0.5, @0.75, @1.0];
        gradientLayer.startPoint = CGPointMake(0.5, 1);
        gradientLayer.endPoint = CGPointMake(0.5, 0);
        gradientLayer.frame = CGRectMake(0, 0, 50, 500);
        [self.gradientView.layer addSublayer:gradientLayer];
    });
    
    
    // 添加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"0%    0.0, 1.0, 0.0 RGB";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.bottom.mas_equalTo(gradientView.mas_bottom);
    }];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.text = @"25%    1.0, 1.0, 0.0 RGB";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_bottom).offset(-125);
    }];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.text = @"50%    1.0, 0.5, 0.0 RGB";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_centerY);
    }];
    UILabel *label21 = [[UILabel alloc] initWithFrame:CGRectZero];
    // 175/255 70/255 70/255
    label21.text = @"75%    1.0, 0.0, 0.0 RGB";
    [self.view addSubview:label21];
    [label21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.centerY.mas_equalTo(gradientView.mas_centerY).offset(-125);
    }];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
    label3.text = @"100%    0.5, 0.0, 0.5 RGB";
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gradientView.mas_right).offset(20);
        make.top.mas_equalTo(gradientView.mas_top);
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
