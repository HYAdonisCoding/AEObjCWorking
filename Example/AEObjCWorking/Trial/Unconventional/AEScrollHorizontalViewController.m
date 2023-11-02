//
//  AEScrollHorizontalViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/10/31.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEScrollHorizontalViewController.h"

@interface AEScrollHorizontalViewController ()

@end

@implementation AEScrollHorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configUI {
    [super configUI];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    CGFloat space = 10, width = 200;
    CGFloat left = 10;
    
    for (int i = 0; i < 10; i++) {
        UILabel *subView = [[UILabel alloc] init];
        subView.text = [NSString stringWithFormat:@"%d", i+ 1];
        subView.backgroundColor = ((i%2) != 0) ? UIColor.cyanColor : UIColor.yellowColor;
        [scrollView addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.top.mas_equalTo(scrollView.mas_top).offset(space);
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
            make.bottom.mas_equalTo(scrollView.mas_bottom);
            if (i == 9) {// 最后一个特殊处理
                make.right.mas_equalTo(scrollView.mas_right).offset(space);
            }
        }];
        left = (i+1)*width + space*(i+2);
    }
}

@end
