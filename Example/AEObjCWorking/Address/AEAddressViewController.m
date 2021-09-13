//
//  AEAddressViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEAddressViewController.h"
#import "AEAddressSelectView.h"
#import "AEAddressSelectViewController.h"

@interface AEAddressViewController ()
/// <#DESC#>
@property (nonatomic, strong) UIButton *aButton;
/// <#DESC#>
@property (nonatomic, strong) AEAddressSelectView *aView;


@end

@implementation AEAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.aButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.aButton setTitle:@"请选择" forState:(UIControlStateNormal)];
    [self.aButton setTitleColor:[UIColor purpleColor] forState:(UIControlStateNormal)];
    [self.aButton addTarget:self action:@selector(selectAddress:) forControlEvents:(UIControlEventTouchUpInside)];
    self.aButton.frame = CGRectMake(0, 100, SCREEN_WIDTH, 200);
    [self.view addSubview:self.aButton];
    
//    [self.view addSubview:[self.aView initAddressView]];
}

- (void)selectAddress:(UIButton *)btn {
//    if ([btn.currentTitle isEqualToString:@"请选择"]) {
//        self.aView.isChangeAddress = NO;
//    } else {
//        self.aView.isChangeAddress = YES;
//    }
//
//    WK(weakSelf);
//    [self.aView addAnimateCompationHandler:^(NSString * _Nullable titleAddress, NSString * _Nullable titleID) {
//        if (titleAddress.length > 0) {
//            [weakSelf.aButton setTitle:titleAddress forState:(UIControlStateNormal)];
//        }
//    }];
    
    WK(weakSelf);
    NSString * titleAddress, *titleID;
    if ([btn.currentTitle isEqualToString:@"请选择"]) {
        self.aView.isChangeAddress = NO;
    } else {
        self.aView.isChangeAddress = YES;
        NSArray *arr = [btn.currentTitle componentsSeparatedByString:@"\n"];
        if (arr.count > 1) {
            titleAddress = arr[0];
            titleID = arr[1];
        }
    }
    NSLog(@"%@\n%@", titleAddress, titleID);
    AEAddressSelectViewController *vc = [AEAddressSelectViewController standardLocationViewWithProvince:titleAddress city:titleID district:@"" completionHandler:^(NSString * _Nullable titleAddress, NSString * _Nullable titleID) {
        if (titleAddress.length > 0) {
            [weakSelf.aButton setTitle:[titleAddress stringByAppendingFormat:@"\n%@", titleID] forState:(UIControlStateNormal)];
        }
    }];
    //全屏幕覆盖
//   vc.modalPresentationStyle = UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
//   //设置弹出动画：淡入淡出
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve; 
    [self presentViewController:vc animated:YES completion:^{
            //
    }];
}


- (AEAddressSelectView *)aView {
    if (!_aView) {
        _aView = [[AEAddressSelectView alloc] init];
        _aView.title = @"请选择所在地区";
//        _aView.delegate = self;
        _aView.defaultHeight = SCREEN_HEIGHT*0.72;
        _aView.titleScrollViewH = 37;
    }
    return _aView;
}
@end
