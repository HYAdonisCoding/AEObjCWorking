//
//  AEScrollViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/25.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEScrollViewController.h"

@interface AEScrollViewController ()


@end

@implementation AEScrollViewController

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
    CGFloat space = 10, height = 100, width = SCREEN_WIDTH - space*2;
    CGFloat top = 10;
    
    for (int i = 0; i < 10; i++) {
        UILabel *subView = [[UILabel alloc] init];
        subView.backgroundColor = ((i%2) != 0) ? UIColor.cyanColor : UIColor.yellowColor;
        [scrollView addSubview:subView];
        if ((i%2) != 0) {
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(SCREEN_WIDTH+space);
                make.top.mas_equalTo(scrollView.mas_top).offset(top);
                make.size.mas_equalTo(CGSizeMake(width, height));
                make.right.mas_equalTo(scrollView.mas_right).offset(-space);
                if (i == 9) {
                    make.bottom.mas_equalTo(scrollView.mas_bottom).offset(space);
                }
            }];
        } else {
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(space);
                make.top.mas_equalTo(scrollView.mas_top).offset(top);
                make.size.mas_equalTo(CGSizeMake(width, height));
            }];
        }
        top = (i+1)*height + space*(i+2);
    }
}

@end
