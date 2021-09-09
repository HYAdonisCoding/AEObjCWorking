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
@property (nonatomic, copy) AEAddressSelectBlock chooseLocationBlock;

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
    [self show];
}


- (void)show {
    [self.view addSubview:[self.addressSelectView initAddressView]];
    
    WK(weakSelf);
    [self.addressSelectView addAnimateCompationHandler:^(NSString * _Nullable titleAddress, NSString * _Nullable titleID) {
        if (titleAddress.length > 0) {
            if (weakSelf.chooseLocationBlock) {
                weakSelf.chooseLocationBlock(titleAddress, titleID);
            }
        }
        [weakSelf dismissViewControllerAnimated:YES completion:^{
                    //
        }];
    }];
}

+ (instancetype)standardLocationViewWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district completionHandler:(AEAddressSelectBlock)chooseLocationBlock {
    AEAddressSelectViewController *vc = [[self alloc] init];
    
    vc.centerTitle = @"请选择所在地区";
    vc.chooseLocationBlock = chooseLocationBlock;

    
    return vc;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return self;
}


- (AEAddressSelectView *)addressSelectView {
    if (!_addressSelectView) {
        _addressSelectView = [[AEAddressSelectView alloc] init];
        _addressSelectView.title = self.centerTitle;
//        _aView.delegate = self;
        _addressSelectView.defaultHeight = SCREEN_HEIGHT*0.72;
        _addressSelectView.titleScrollViewH = 37;
    }
    
    return _addressSelectView;
}

@end
