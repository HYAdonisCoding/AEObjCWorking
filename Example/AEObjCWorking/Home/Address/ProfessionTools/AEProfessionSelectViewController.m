//
//  AEProfessionSelectViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEProfessionSelectViewController.h"
#import "AEProfessionSelectView.h"

@interface AEProfessionSelectViewController ()

/// 回调
@property (nonatomic, copy) AEAddressSelectBlock chooseBlock;

/// 标题
@property (nonatomic, copy) NSString *centerTitle;

/// <#Description#>
@property (nonatomic, strong) AEProfessionSelectView *selectView;
@end

@implementation AEProfessionSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self show];
}
- (void)show {
    self.selectView.title = self.centerTitle;
//    if (self.city.length > 0) {
//        NSArray *arr = [[self.city stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@"="];
//        self.selectView.titleIDMarr = arr.mutableCopy;
//        self.selectView.isChangeAddress = YES;
//    }

    [self.view addSubview:[self.selectView initAddressView]];
    
    WK(weakSelf);
    [self.selectView addAnimateCompationHandler:^(NSString * _Nullable titleAddress, NSString * _Nullable titleID) {
        if (titleAddress.length > 0) {
            if (weakSelf.chooseBlock) {
                weakSelf.chooseBlock(titleAddress, titleID);
            }
        }
        [weakSelf dismissViewControllerAnimated:YES completion:^{
                    //
        }];
    }];
}

- (instancetype)initWithTitle:(NSString *)title province:(NSString *)province city:(NSString *)city district:(NSString *)district {
    self = [super init];
    if (self) {
        self.centerTitle = title;
//        self.province = province;
//        self.city = city;
//        self.district = district;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return self;
}

+ (instancetype)standardView:(NSString *)profession code:(NSString *)code completionHandler:(AEAddressSelectBlock)chooseLocationBlock {
    AEProfessionSelectViewController *vc = [[self alloc] initWithTitle:@"职业" province:profession city:code district:code];
    vc.chooseBlock = chooseLocationBlock;

    
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

- (AEProfessionSelectView *)selectView {

    if (!_selectView) {
        _selectView = [[AEProfessionSelectView alloc] init];
        _selectView.defaultHeight = SCREEN_HEIGHT*0.6;
        _selectView.titleScrollViewH = 37;
    }
    
    return _selectView;
}

@end
