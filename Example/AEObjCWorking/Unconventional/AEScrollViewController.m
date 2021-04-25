//
//  AEScrollViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/25.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEScrollViewController.h"

@interface AEScrollViewController ()
/// <#Description#>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation AEScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self configLayoutSubviews];
}

- (void)configLayoutSubviews {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.scrollView];
    
    UIView *topView = [UIView new];
    UIView *topView1 = [UIView new];
    UIView *topView2 = [UIView new];
    UIView *topView3 = [UIView new];
    [self.scrollView addSubview:topView];
    [self.scrollView addSubview:topView1];
    [self.scrollView addSubview:topView2];
    [self.scrollView addSubview:topView3];

    topView.backgroundColor = [UIColor greenColor];
    topView1.backgroundColor = [UIColor redColor];
    topView2.backgroundColor = [UIColor magentaColor];
    topView3.backgroundColor = [UIColor orangeColor];

    CGFloat h = 200;
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.scrollView);
        make.height.equalTo(@(h));
    }];
    
    [topView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom).with.offset(50);
        make.height.equalTo(@(h));
    }];
    
    [topView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(topView1.mas_bottom).with.offset(50);
        make.height.equalTo(@(h));
    }];
    
    [topView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(topView2.mas_bottom).with.offset(50);
        make.height.equalTo(@(h));
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.edges.equalTo(self.view);

        make.bottom.mas_equalTo(topView3.mas_bottom);
    }];
}

@end
