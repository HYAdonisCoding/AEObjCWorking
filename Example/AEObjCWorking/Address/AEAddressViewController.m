//
//  AEAddressViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEAddressViewController.h"
#import "AEAddressSelectView.h"

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
    [self.view addSubview:[self.aView initAddressView]];
}

- (void)selectAddress:(UIButton *)btn {
    if ([btn.currentTitle isEqualToString:@"请选择"]) {
        self.aView.isChangeAddress = NO;
    } else {
        self.aView.isChangeAddress = YES;
    }
    
    
    [self.aView addAnimate];
}


- (AEAddressSelectView *)aView {
    if (!_aView) {
        _aView = [[AEAddressSelectView alloc] init];
        _aView.title = @"请选择所在地区";
//        _aView.delegate1 = self;
        _aView.defaultHeight = SCREEN_HEIGHT*0.72;
        _aView.titleScrollViewH = 37;
    }
    return _aView;
}
@end
