//
//  AEGuideViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/2/2.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AEGuideViewController.h"

@interface AEGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *enterAppButton;
@property (nonatomic, assign) NSInteger imageCount;
@end

@implementation AEGuideViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)configUI {
    [super configUI];
    self.imageCount = 4;
    // 创建 UIScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.imageCount, self.view.bounds.size.height);
    
    // 添加引导页图片
    for (NSInteger i = 0; i < self.imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        NSString *imageName = [NSString stringWithFormat:@"guide_image_%ld", (long)i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
    
    // 创建 UIPageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 20)];
    self.pageControl.numberOfPages = self.imageCount;
    self.pageControl.currentPage = 0;
    [self.pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // 添加跳过按钮
    UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    skipButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    skipButton.layer.cornerRadius = 5.0;
    [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    // 将 UI 元素添加到视图
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:skipButton];
    [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 40));
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
    }];
    
    // 在引导页的最后一页添加一个进入 App 的按钮
    UIButton *enterAppButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [enterAppButton addTarget:self action:@selector(skipButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [enterAppButton setTitle:@"立即体验" forState:UIControlStateNormal];
    enterAppButton.titleLabel.font = [UIFont systemFontOfSize:22];
    enterAppButton.layer.cornerRadius = 5.0;
    [enterAppButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    enterAppButton.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:enterAppButton];
    [enterAppButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-100, 50));
        make.right.mas_equalTo(-50);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-50);
    }];
    self.enterAppButton = enterAppButton;
    NSLog(@"Button color set: %@", enterAppButton.backgroundColor);
    self.enterAppButton.hidden = YES;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScrollButton color set: %@", self.enterAppButton.backgroundColor);

    // 更新 PageControl 的当前页码
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = currentPage;
    if (currentPage == self.imageCount-1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.enterAppButton.hidden = NO;
            self.enterAppButton.backgroundColor = [UIColor orangeColor];
        });
    } else {
        self.enterAppButton.hidden = YES;
        self.enterAppButton.backgroundColor = [UIColor orangeColor];
    }
}

- (void)pageControlValueChanged:(UIPageControl *)pageControl {
    // PageControl 值改变时，滑动到相应的页面
    NSInteger targetPage = pageControl.currentPage;
    CGFloat xOffset = targetPage * self.view.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
    
}

- (void)skipButtonTapped {
    // 处理跳过按钮点击事件，可以在此处保存用户引导状态，然后跳转到主界面
    NSLog(@"跳过按钮被点击");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enterApp" object:nil];
}


@end
