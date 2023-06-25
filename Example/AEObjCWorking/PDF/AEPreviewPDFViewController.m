//
//  AEPreviewPDFViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/25.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEPreviewPDFViewController.h"
#import "AEPDFModel.h"
#import "AEPreviewPDFView.h"

@interface AEPreviewPDFViewController ()

@property (nonatomic, strong) AEPreviewPDFView *previewPDFView;
@property (nonatomic, strong) AEPDFModel *model;

@end

@implementation AEPreviewPDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self show];
}

- (void)configEvent {
    [super configEvent];
    
}

- (void)configUI {
    [super configUI];
    
    
}
- (CGFloat)getHeight {
    CGFloat tabBarHeight = 0.0;
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (window) {
        if (@available(iOS 11.0, *)) {
            tabBarHeight = window.safeAreaInsets.bottom;
        }
    }
    return tabBarHeight + 49;
}

- (void)show {

    self.previewPDFView.model = self.model;
    [self.view addSubview:[self.previewPDFView initAddressView]];
    WK(weakSelf);
    [self.previewPDFView addAnimateCompationHandler:^(id  _Nonnull data) {
        [weakSelf dismissViewControllerAnimated:YES completion:^{
                            //
        }];
    }];


}

- (instancetype)initWithModel:(AEPDFModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
    }
    return self;
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


- (AEPreviewPDFView *)previewPDFView {
    if (!_previewPDFView) {
        _previewPDFView = [[AEPreviewPDFView alloc] init];
        _previewPDFView.defaultHeight = SCREEN_HEIGHT*0.72;
        _previewPDFView.titleScrollViewH = 37;
    }
    
    return _previewPDFView;
}

@end
