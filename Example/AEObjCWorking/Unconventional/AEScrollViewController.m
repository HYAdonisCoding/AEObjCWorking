//
//  AEScrollViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/25.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEScrollViewController.h"

@interface AEScrollViewController () {
    UIView *topView;
    UIView *topView1;
    UIView *topView2;
    UIView *topView3;
    UIView *topView4;
}
/// scrollView
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
    self.scrollView.scrollEnabled = YES;
    self.scrollView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.scrollView];
    
    topView = [UIView new];
    topView1 = [UIView new];
    topView2 = [UIView new];
    topView3 = [UIView new];

    topView4 = [UIView new];

    [self.scrollView addSubview:topView];
    [topView addSubview:topView1];
    [topView addSubview:topView2];
    [topView addSubview:topView3];

    [topView addSubview:topView4];

    
    topView.backgroundColor = [UIColor greenColor];
    topView1.backgroundColor = [UIColor redColor];
    topView2.backgroundColor = [UIColor magentaColor];
    topView3.backgroundColor = [UIColor orangeColor];
    topView4.backgroundColor = [UIColor cyanColor];

    CGFloat h = 200;
    CGFloat w = SCREEN_WIDTH/1.5;

    
    [topView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView);
        make.top.equalTo(topView.mas_top);
        make.height.equalTo(@(h));
        make.width.equalTo(@(w));
    }];
    
    [topView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView);
        make.top.equalTo(topView1.mas_bottom).with.offset(50);
        make.height.equalTo(@(h));
        make.width.equalTo(@(w));
    }];
    
    [topView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView);
        make.top.equalTo(topView2.mas_bottom).with.offset(50);
        make.height.equalTo(@(h));
        make.width.equalTo(@(w));
    }];
    
    [topView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView3.mas_right).offset(10);
        make.top.equalTo(topView3.mas_bottom).with.offset(50);
        make.height.equalTo(@(h));
        make.width.equalTo(@(w));
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
//        make.width.equalTo(self.scrollView.mas_width); // 需要设置宽度和scrollview宽度一样 仅仅上下滑动
        make.bottom.equalTo(topView4.mas_bottom).offset(20);// 这里放最后一个view的底部
        make.right.equalTo(topView4.mas_right);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}

@end
