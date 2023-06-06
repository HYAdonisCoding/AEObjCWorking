//
//  AEWKPDFPreviewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/5.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEWKPDFPreviewController.h"
#import "AEPDFModel.h"
#import <WebKit/WebKit.h>

@interface AEWKPDFPreviewController () <WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>
/// 显示pdf
@property (nonatomic, strong) WKWebView *webView;

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

@implementation AEWKPDFPreviewController

#pragma mark -
#pragma mark - Life Cycle Mothod
- (instancetype)initAllPages:(NSArray<AEPDFModel *> *)pages
                 currentPage:(NSInteger)currentPage
             completeHandler:(nonnull DataUpdateBlock)completeHandler {
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
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    if (![self.navigationController.viewControllers containsObject:self]) {
        // 用户正在返回上一个页面
        NSLog(@"用户返回上一个页面");
        if (self.timer) {
            dispatch_source_cancel(self.timer);
            self.timer = nil;
        }
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
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    // 加载 PDF 文件
    NSURL *url = [NSURL fileURLWithPath:self.pages[self.currentPage].path];
    NSURL *parentUrl = [NSURL fileURLWithPath:[self.pages[self.currentPage].path stringByDeletingLastPathComponent]];
    [self.webView loadFileURL:url allowingReadAccessToURL:parentUrl];
    

    // 添加 PDFView 到视图
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-[self getHeight]);
    }];
    

    
    if (self.totalPages <= 1) {
        self.pages[self.currentPage].scrollBottom = YES;
    }
    // 滚动到首页
    [self goToFirstPage];
    
    [self defaultToolbar];
    if (!self.pages[self.currentPage].readed) {
        [self startTiming];
    }
    
    // 设置UIScrollViewDelegate
//      UIScrollView *scrollView = self.webView.scrollView;
//      scrollView.delegate = self;
    [self setupScrollObserver];
}

- (void)disablePageOverlay {
    // 获取WKWebView的UIScrollView
    UIScrollView *scrollView = self.webView.scrollView;
    
    // 找到左上角的浮窗视图
    UIView *overlayView = [self findPageOverlayInView:scrollView];
    
    // 隐藏左上角的浮窗视图
    if (overlayView) {
        overlayView.hidden = YES;
    }
}

- (UIView *)findPageOverlayInView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"WKPDFPageNumberIndicator")]) {
            return subview;
        }
        
        UIView *foundView = [self findPageOverlayInView:subview];
        if (foundView) {
            return foundView;
        }
    }
    
    return nil;
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
    // 更新倒计时时间
    self.currentTimes--;
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
//    PDFView *pdfView = notification.object;
//    NSInteger currentPage = [pdfView.document indexForPage:pdfView.currentPage];
//    // 判断是否到达最后一页
//    if (currentPage == self.totalPages - 1) {
//        NSLog(@"已经浏览到最后一页");
//        [self configToolbar: YES];
//    }
}



/// 去首页
- (void)goToFirstPage {

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
        NSURL *parentUrl = [NSURL fileURLWithPath:[self.pages[self.currentPage].path stringByDeletingLastPathComponent]];
        [self.webView loadFileURL:url allowingReadAccessToURL:parentUrl];
        // 获取总页数

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
        NSURL *parentUrl = [NSURL fileURLWithPath:[self.pages[self.currentPage].path stringByDeletingLastPathComponent]];
        [self.webView loadFileURL:url allowingReadAccessToURL:parentUrl];
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
#pragma mark - WKNavigationDelegate

//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//
//    [webView evaluateJavaScript:@"setTimeout(function() {this.document.getElementById('pdf').scrollHeight / this.document.getElementById('pdf').clientHeight;}, 1000);" completionHandler:^(id _Nullable totalPages, NSError * _Nullable error) {
//        if (error == nil) {
//            NSLog(@"Total Pages: %@", totalPages);
//        }
//    }];
//
////    [webView evaluateJavaScript:@"this.document.getElementById('pdf').scrollHeight / this.document.getElementById('pdf').clientHeight;" completionHandler:^(id _Nullable totalPages, NSError * _Nullable error) {
////        if (error == nil) {
////            NSLog(@"Total Pages: %@", totalPages);
////        }
////    }];
//
//    [webView evaluateJavaScript:@"setTimeout(function() {this.scrollY / this.document.getElementById('pdf').clientHeight + 1;}, 1000);" completionHandler:^(id _Nullable currentPage, NSError * _Nullable error) {
//        if (error == nil) {
//            NSLog(@"currentPage: %@", currentPage);
//        }
//    }];
////    [webView evaluateJavaScript:@"this.scrollY / this.document.getElementById('pdf').clientHeight + 1;" completionHandler:^(id _Nullable currentPage, NSError * _Nullable error) {
////        if (error == nil) {
////            NSLog(@"currentPage: %@", currentPage);
////        }
////    }];
//}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取PDF的总页数
    [self getTotalPagesInPDF:^(NSInteger totalPages) {
        NSLog(@"Total Pages: %ld", (long)totalPages);
        
        // 获取当前显示的页数
        NSInteger currentPage = [self getCurrentPageInPDF];
        NSLog(@"Current Page: %ld", (long)currentPage);
        if (currentPage > 0 && currentPage == totalPages) {
            [self configToolbar: YES];
        }
    }];
    
}

#pragma mark - Helper Methods
- (void)setupScrollObserver {
    [self.webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UIScrollView *scrollView = (UIScrollView *)object;
        CGFloat contentHeight = scrollView.contentSize.height;
        CGFloat visibleHeight = scrollView.bounds.size.height;
        CGFloat offset = scrollView.contentOffset.y;
        
        CGFloat bottomOffset = contentHeight - visibleHeight - offset;
        CGFloat threshold = 10.0; // 设置一个阈值，表示距离底部多少距离时认为滚动到了最后一页底部
        
        if (bottomOffset <= threshold) {
            // 滚动到了最后一页底部
            NSLog(@"滚动到了最后一页底部");
            [self configToolbar: YES];
        }
    }
}


- (void)getTotalPagesInPDF:(void(^)(NSInteger page))completionHandler {
    NSString *script = @"document.querySelectorAll('body > div[data-page-number]').length";
    script = @"setTimeout(function() {this.document.getElementById('pdf').scrollHeight / this.document.getElementById('pdf').clientHeight;}, 1000);";
    script = @"document.readyState";
    
    [self.webView evaluateJavaScript:script completionHandler:^(id result, NSError *error) {
        if (!error && [result isKindOfClass:[NSString class]]) {
                    NSString *readyState = (NSString *)result;
                    if ([readyState isEqualToString:@"complete"]) {
                        NSString *script = @"document.getElementsByTagName('body')[0].childElementCount";
                        script = @"document.getElementsByTagName('body')[0].getBoundingClientRect().height / window.innerHeight";
                        [self.webView evaluateJavaScript:script completionHandler:^(id result, NSError *error) {
                            if (!error) {
                                NSInteger totalPages = [result integerValue];
                                NSLog(@"Total Pages: %ld", (long)totalPages);
                                completionHandler(totalPages);
                            } else {
                                NSLog(@"Error evaluating JavaScript: %@", error);
                                completionHandler(-1);
                            }
                        }];
                    } else {
                        // PDF尚未加载完成，可以在此处等待或尝试延迟执行获取页数的操作
                        completionHandler(-2);
                    }
                } else {
                    NSLog(@"Error evaluating JavaScript: %@", error);
                    completionHandler(-1);
                }
    }];
}

- (NSInteger)getCurrentPageInPDF {
    // 获取当前滚动位置的偏移量
    CGFloat offsetY = self.webView.scrollView.contentOffset.y;
    
    // 获取PDF的一页高度
    CGFloat pageHeight = self.webView.bounds.size.height;
    
    // 计算当前显示的页数
    NSInteger currentPage = ceil(offsetY / pageHeight) + 1;
    
    return currentPage;
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
