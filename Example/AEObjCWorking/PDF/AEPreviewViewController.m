//
//  AEPreviewViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/2.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEPreviewViewController.h"
#import "AEPDFModel.h"
#import <PDFKit/PDFKit.h>

@interface AEPreviewViewController ()<PDFViewDelegate>

@property (nonatomic, strong) PDFView *pdfView;

@property (nonatomic, assign) NSInteger rowPreview;
@property (nonatomic, strong) UIView *toolbar;
/// 下一页按钮
@property (nonatomic, strong) UIButton *nextBtn;

/// 上一页按钮 上一份
@property (nonatomic, strong) UIButton *preBtn;

/// 当前阅读时间 滑至最后一页，完整阅读协议内容（3s）
@property (nonatomic, assign) NSInteger currentTimes;

@property (nonatomic, copy) DataUpdateBlock dataUpdateBlock;


@property (nonatomic, strong) dispatch_source_t timer;


@property (nonatomic, assign) NSInteger totalPages;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSArray<AEPDFModel *> *pages;

@end

@implementation AEPreviewViewController

#pragma mark -
#pragma mark - Life Cycle Mothod
- (instancetype)initAllPages:(NSArray<AEPDFModel *> *)pages
                 currentPage:(NSInteger)currentPage
             completeHandler:(nonnull DataUpdateBlock)completeHandler{
    self = [super init];
    if (self) {
        self.pages = pages;
        self.currentPage = currentPage;
        self.dataUpdateBlock = completeHandler;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 监听 currentPageChanged 事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handlePageChangeNotification:)
                                                 name:PDFViewPageChangedNotification
                                               object:self.pdfView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:PDFViewPageChangedNotification
                                                  object:self.pdfView];
    
    if (![self.navigationController.viewControllers containsObject:self]) {
        // 用户正在返回上一个页面
        NSLog(@"用户返回上一个页面");
        dispatch_source_cancel(self.timer);
        self.timer = nil;
        if (self.dataUpdateBlock) {
            self.dataUpdateBlock(self.pages);
        }
    }
}

#pragma mark -
#pragma mark - Private Mothod

- (void)configUI {
    [super configUI];
    
    [self refreshrightBarButtonItem];
    
    // 创建 PDFView
    self.pdfView = [[PDFView alloc] initWithFrame:CGRectZero];
    self.pdfView.delegate = self;
    
    // 加载 PDF 文件
    NSURL *url = [NSURL fileURLWithPath:self.pages[self.currentPage].path];
    PDFDocument *document = [[PDFDocument alloc] initWithURL:url];
    self.pdfView.document = document;
    
    // 添加 PDFView 到视图
    [self.view addSubview:self.pdfView];
    [self.pdfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-[self getHeight]);
    }];
    
    // 获取总页数
    self.totalPages = document.pageCount;
    
    if (self.totalPages <= 1) {
        self.pages[self.currentPage].scrollBottom = YES;
    }
    // 滚动到首页
    [self goToFirstPage];
    
    [self defaultToolbar];
    if (!self.pages[self.currentPage].readed) {
        [self startTiming];
    }
}

- (void)refreshrightBarButtonItem {
    self.navigationItem.title = self.pages[self.currentPage].name;
    
    NSString *tips = [NSString stringWithFormat:@"第%ld/%lu份", (long)self.currentPage+1, (unsigned long)self.pages.count];
    UIBarButtonItem *customButton = [[UIBarButtonItem alloc] initWithTitle:tips style:UIBarButtonItemStylePlain target:self action:@selector(openIn:)];
    self.navigationItem.rightBarButtonItem = customButton;
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



- (void)defaultToolbar {
    CGFloat height = [self getHeight];
    // 创建自定义的底部工具栏
    UIView *toolbar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - height, self.view.bounds.size.width, height)];
    toolbar.backgroundColor = [UIColor colorWithString:@"#ffcc00"];
    [self.view addSubview:toolbar];
    
    self.toolbar = toolbar;
    // 将按钮添加到工具栏
    if (self.currentPage == 0) {
        self.preBtn.frame = CGRectZero;
        [self.toolbar addSubview:self.preBtn];
        [self.toolbar addSubview:self.nextBtn];
    } else {
        self.nextBtn.frame = CGRectMake(self.preBtn.bounds.size.width, 0, self.view.bounds.size.width - self.preBtn.bounds.size.width, height);
        [self.toolbar addSubview:self.preBtn];
        [self.toolbar addSubview:self.nextBtn];
    }
}

/// 倒计时
- (void)startTiming {
    self.currentTimes = 3;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateCountdown];
        });
    });
    dispatch_resume(timer);
    self.timer = timer;
}

- (void)updateCountdown {
    // 更新倒计时时间
    self.currentTimes--;
    
    if (self.currentTimes >= 0) {
        // 更新倒计时标签文本
        [self.nextBtn setTitle:[@"请滑至最后一页，完整阅读协议内容" stringByAppendingFormat:@"（%ld）", self.currentTimes] forState:(UIControlStateNormal)];

    } else {
        // 倒计时结束，停止定时器
        if (self.currentPage == self.pages.count - 1) {
            [self.nextBtn setTitle:@"我以阅读并同意此协议" forState:(UIControlStateNormal)];
        } else
        if (self.pages[self.currentPage].scrollBottom) {
            self.pages[self.currentPage].readed = YES;
            [self.nextBtn setTitle:@"我以阅读并同意此协议，下一份" forState:(UIControlStateNormal)];
        } else {
            [self.nextBtn setTitle:@"请滑至最后一页，完整阅读协议内容" forState:(UIControlStateNormal)];
        }
    }
}

- (void)configToolbar:(BOOL)scrollBottom {
    if (scrollBottom) {
        self.pages[self.currentPage].scrollBottom = YES;
        if (self.currentTimes <= 0) {
            self.pages[self.currentPage].readed = YES;
        }
    }
    if (self.currentPage == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            // 不展示上一份
            self.preBtn.frame = CGRectZero;
            
            self.nextBtn.frame = self.toolbar.bounds;
            [self.nextBtn setTitle:@"我以阅读并同意此协议，下一份" forState:(UIControlStateNormal)];
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            // 展示上一份
            self.preBtn.frame = CGRectMake(0, 0, 100, self.toolbar.bounds.size.height);
            self.nextBtn.frame = CGRectMake(self.preBtn.bounds.size.width, 0, self.view.bounds.size.width - self.preBtn.bounds.size.width, self.preBtn.bounds.size.height);
        }];
    }
    
}



- (void)handlePageChangeNotification:(NSNotification *)notification {
    PDFView *pdfView = notification.object;
    NSInteger currentPage = [pdfView.document indexForPage:pdfView.currentPage];
    // 判断是否到达最后一页
    if (currentPage == self.totalPages - 1) {
        NSLog(@"已经浏览到最后一页");
        [self configToolbar: YES];
    }
}



/// 去首页
- (void)goToFirstPage {
    PDFView *pdfView = self.pdfView;
    PDFDocument *pdfDocument = self.pdfView.document;
    if (pdfDocument != nil && pdfDocument.pageCount > 0) {
        PDFPage *firstPage = [pdfDocument pageAtIndex:0];
        CGRect firstPageBounds = [firstPage boundsForBox:kPDFDisplayBoxCropBox];
        [pdfView goToPage:firstPage];
        [pdfView goToRect:firstPageBounds onPage:firstPage];
    }
}

/// 后一页
- (void)nextPage:(id)sender {
    if (self.currentTimes > 0 || !self.pages[self.currentPage].scrollBottom) {
        return;
    }
    // 倒计时到了，并且也滚动到底部了
    self.pages[self.currentPage].readed = YES;
    
    if (self.currentPage < self.pages.count - 1) {
        self.currentTimes = 3;
        self.currentPage += 1;
        // 加载 PDF 文件
        NSURL *url = [NSURL fileURLWithPath:self.pages[self.currentPage].path];
        PDFDocument *document = [[PDFDocument alloc] initWithURL:url];
        self.pdfView.document = document;
        // 获取总页数
        self.totalPages = document.pageCount;
        if (self.totalPages <= 1) {
            self.pages[self.currentPage].scrollBottom = YES;
        }
        // 滚动到首页
        [self goToFirstPage];
        
        [self refreshrightBarButtonItem];
        if (!self.pages[self.currentPage].readed) {
            [self startTiming];
        }
        [self configToolbar: NO];
    } else {
        // 已经最后一页
        
        NSLog(@"已经最后一页");
        NSLog(@"用户返回上一个页面");
        dispatch_source_cancel(self.timer);
        self.timer = nil;
        [self.navigationController popViewControllerAnimated:YES];
        if (self.dataUpdateBlock) {
            self.dataUpdateBlock(self.pages);
        }
    }
}

/// 前一页
- (void)prePage:(id)sender {
    if (self.currentPage > 0) {
        self.currentPage -= 1;
        // 加载 PDF 文件
        NSURL *url = [NSURL fileURLWithPath:self.pages[self.currentPage].path];
        PDFDocument *document = [[PDFDocument alloc] initWithURL:url];
        self.pdfView.document = document;
        // 滚动到首页
        [self goToFirstPage];
        [self refreshrightBarButtonItem];
        if (!self.pages[self.currentPage].readed) {
            [self startTiming];
        }
        [self configToolbar: NO];
    }
}

- (void)openIn:(id)sender {
    NSLog(@"%@", sender);
}

#pragma mark -
#pragma mark - Lazy Load

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        // 创建工具栏按钮
        _nextBtn = [[UIButton alloc] initWithFrame:self.toolbar.bounds];
        [_nextBtn setTitle:@"请滑至最后一页，完整阅读协议内容" forState:(UIControlStateNormal)];
        _nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _nextBtn.titleLabel.numberOfLines = 0; // 设置为 0 表示自动换行
        _nextBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping; // 按单词换行
        [_nextBtn addTarget:self action:@selector(nextPage:) forControlEvents:(UIControlEventTouchUpInside)];
//        [_nextBtn setBackgroundColor:[UIColor colorWithString:@"#ffcc00"]];
        
    }
    return _nextBtn;
}



- (UIButton *)preBtn {
    if (!_preBtn) {
        // 创建工具栏按钮
        _preBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, self.toolbar.bounds.size.height)];
        [_preBtn setTitle:@"上一份" forState:(UIControlStateNormal)];
        [_preBtn addTarget:self action:@selector(prePage:) forControlEvents:(UIControlEventTouchUpInside)];
        [_preBtn setBackgroundColor:[UIColor magentaColor]];
    }
    return _preBtn;
}

@end
