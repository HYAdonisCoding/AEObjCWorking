//
//  AECustomTitleViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/3/10.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AECustomTitleViewController.h"
#import "AECustomTitleView.h"
#import "UIButton+AEImagePlace.h"

@interface AECustomTitleViewController () {
    UIButton *_button;
}

@end

@implementation AECustomTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"消息中心";
    title = @"消息中心(100000000000)";
//    AECustomTitleView *view = [AECustomTitleView defaultTitleViewWith:title imageName:@"broom_icon" tapAction:^NSString * _Nonnull(id  _Nonnull data) {
//
//        NSLog(@"sender clicked %@", data);
//
//        return @"消息中心";
//    }];

//    self.navigationItem.titleView = view;
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(SCREEN_WIDTH - 100);
//    }];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"broom_icon-1"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(broomAction) forControlEvents:(UIControlEventTouchUpInside)];
    button.backgroundColor = [UIColor purpleColor];
    
    self.navigationItem.titleView = button;
    [button sizeToFit];
    [button layoutButtonStyle:(AEButtonEdgeInsetsStyleRight) space:4];
    _button = button;
}

- (void)broomAction {
    [_button setTitle:@"消息中心" forState:(UIControlStateNormal)];
    [_button layoutButtonStyle:(AEButtonEdgeInsetsStyleRight) space:4];

}
@end
