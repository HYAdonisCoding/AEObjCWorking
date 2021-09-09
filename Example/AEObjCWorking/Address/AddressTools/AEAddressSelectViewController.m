//
//  AEAddressSelectViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEAddressSelectViewController.h"
#import "AEAddressSelectView.h"

@interface AEAddressSelectViewController ()
/// 回调
@property (nonatomic, copy) HYChooseLocationBlock chooseLocationBlock;

/// 标题
@property (nonatomic, copy) NSString *centerTitle;

@property (nonatomic, copy) NSString * address;

@property (nonatomic,strong) NSMutableArray * tableViews;//有几个tableView

@property (nonatomic,strong) NSArray * dataSouce;

/// <#DESC#>
@property (nonatomic, strong) AEAddressSelectView *addressSelectView;

@end

@implementation AEAddressSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:[self.addressSelectView initAddressView]];
    
    [self.addressSelectView addAnimateCompationHandler:^(NSString * _Nullable titleAddress, NSString * _Nullable titleID) {
        if (titleAddress.length > 0) {
            
        }
    }];
}

+ (instancetype)standardLocationViewWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district completionHandler:(HYChooseLocationBlock)chooseLocationBlock {
    AEAddressSelectViewController *vc = [[self alloc] init];
    
    vc.centerTitle = @"城市地区选择";
    vc.chooseLocationBlock = chooseLocationBlock;
//    vc.province = province;
//    vc.city = city;
//    vc.district = district;
    
    return vc;
    
}


- (AEAddressSelectView *)addressSelectView {
    if (!_addressSelectView) {
        _addressSelectView = [[AEAddressSelectView alloc] init];
        _addressSelectView.title = @"请选择所在地区";
//        _aView.delegate = self;
        _addressSelectView.defaultHeight = SCREEN_HEIGHT*0.72;
        _addressSelectView.titleScrollViewH = 37;
    }
    
    return _addressSelectView;
}

@end
