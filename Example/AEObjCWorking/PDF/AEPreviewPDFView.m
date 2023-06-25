//
//  AEPreviewPDFView.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/25.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEPreviewPDFView.h"
#import <PDFKit/PDFKit.h>
#import "AEPDFModel.h"



@interface AEPreviewPDFView ()<PDFViewDelegate>

@property (nonatomic, strong) PDFView *pdfView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 背景视图
@property (nonatomic, strong) UIView *addAddressView;

@property (nonatomic, copy) preview_block compationHandler;
@end

@implementation AEPreviewPDFView




- (void)addAnimate {
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self.addAddressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(self.defaultHeight);
            make.width.mas_equalTo(SCREEN_WIDTH);
            
        }];
    }];
}
- (void)addAnimateCompationHandler:(void (^)(id _Nonnull))compationHandler {
    self.compationHandler = compationHandler;
    [self addAnimate];
}

- (void)tapBtnAndcancelBtnClick {
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self.addAddressView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(SCREEN_HEIGHT);
            make.height.mas_equalTo(self.defaultHeight);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (self.compationHandler) {
            self.compationHandler(@"0");
        }
        [self removeFromSuperview];
    }];
}
- (nonnull UIView *)initAddressView {
    self.addAddressView = [[UIView alloc] initWithFrame:CGRectZero];
    self.addAddressView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.addAddressView];
    [self.addAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(SCREEN_HEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.defaultHeight);
//        make.height.mas_equalTo(_defaultHeight);
    }];
    
    UILabel * titleLabel = [[UILabel alloc] init];//[[UILabel alloc]initWithFrame:CGRectMake(50, 10, SCREEN_WIDTH - 100, 30)];
    titleLabel.text = self.model.name;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithString:@"#000000"];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.addAddressView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(20, 10, 30, 30);
    cancelBtn.tag = 1;
    [cancelBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(tapBtnAndcancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addAddressView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(30);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(30);
    }];

    
    // 创建 PDFView
    self.pdfView = [[PDFView alloc] initWithFrame:CGRectZero];
    self.pdfView.delegate = self;

    // 加载 PDF 文件
    NSURL *url = [NSURL fileURLWithPath:self.model.path];
    PDFDocument *document = [[PDFDocument alloc] initWithURL:url];
    self.pdfView.document = document;
    // 延迟2秒执行防止终端报错
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.pdfView.autoScales = YES;
    });


    // 添加 PDFView 到视图
    [self.addAddressView addSubview:self.pdfView];
    [self.pdfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBtnAndcancelBtnClick)];
//    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    self.frame = [UIScreen mainScreen].bounds;
    return self;
}

@end
