//
//  AELifeViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/10/22.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AELifeViewController.h"

@interface AELifeViewController ()

@end

@implementation AELifeViewController

#pragma mark --- life circle

// 非storyBoard(xib或非xib)都走这个方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%s", __FUNCTION__);
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    
    }
    return self;
}

// 如果连接了串联图storyBoard 走这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
     NSLog(@"%s", __FUNCTION__);
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

// xib 加载 完成
- (void)awakeFromNib {
    [super awakeFromNib];
     NSLog(@"%s", __FUNCTION__);
}

// 加载视图(默认从nib)
- (void)loadView {
    NSLog(@"%s", __FUNCTION__);
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor redColor];
}

//视图控制器中的视图加载完成，viewController自带的view加载完成
- (void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    
    [self configUI];
}


//视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewWillAppear:animated];
}

// view 即将布局其 Subviews
- (void)viewWillLayoutSubviews {
    NSLog(@"%s", __FUNCTION__);
    [super viewWillLayoutSubviews];
}

// view 已经布局其 Subviews
- (void)viewDidLayoutSubviews {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLayoutSubviews];
}

//视图已经出现
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidAppear:animated];
}

//视图将要消失
- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewWillDisappear:animated];
}

//视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super viewDidDisappear:animated];
}

//出现内存警告  //模拟内存警告:点击模拟器->hardware-> Simulate Memory Warning
- (void)didReceiveMemoryWarning {
    NSLog(@"%s", __FUNCTION__);
    [super didReceiveMemoryWarning];
}

// 视图被销毁
- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark ---Method
- (void)configUI {
    self.view.backgroundColor = [UIColor purpleColor];
    CGFloat space = 20;
    CGFloat height = 40;
    for (int i = 0; i < 6; i++) {
        UIButton *a = [UIButton buttonWithType:(UIButtonTypeCustom)];
        a.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:a];
        [a mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset((i+1)*space+i*height);
            make.height.mas_equalTo(height);
            make.left.mas_equalTo(space);
            make.right.mas_equalTo(-space);
        }];
        [a setTitle:[NSString stringWithFormat:@"按钮%d", i+1] forState:(UIControlStateNormal)];
        if (i%2 == 0) {
            [a addTarget:self action:@selector(pushVCAction) forControlEvents:(UIControlEventTouchUpInside)];
        } else {
            [a addTarget:self action:@selector(presentVCAction) forControlEvents:(UIControlEventTouchUpInside)];
        }
    }
    [self addObserver:self.navigationController forKeyPath:@"viewControllers" options:(NSKeyValueObservingOptionNew) context:nil];
    [self addObserver:self forKeyPath:@"presentingViewController" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"observeValueForKeyPath --- %@", keyPath);
}

- (void)pushVCAction {
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)presentVCAction {
    CGFloat space = 20;
    CGFloat height = 40;
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    UIButton *a = [UIButton buttonWithType:(UIButtonTypeCustom)];
    a.backgroundColor = [UIColor orangeColor];
    [vc.view addSubview:a];
    [a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(vc.mas_topLayoutGuideBottom).offset(space+height);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(space);
        make.right.mas_equalTo(-space);
    }];
    [a setTitle:@"按钮返回" forState:(UIControlStateNormal)];

    [a addTarget:self action:@selector(dismissVCAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (void)dismissVCAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
