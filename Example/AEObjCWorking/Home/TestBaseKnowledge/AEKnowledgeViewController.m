//
//  AEKnowledgeViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/10/17.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEKnowledgeViewController.h"
#import "UIButton+EnlargeArea.h"

@interface TestView : UIView

@end

@implementation TestView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];
}
- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
}
- (void)didMoveToWindow {
    [super didMoveToWindow];
}
@end

@interface AEKnowledgeViewController ()
/// 测试
@property (nonatomic, strong) UIButton *checkBtn;
@end

@implementation AEKnowledgeViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog([AEConvenientTool uuid]);//18656A54-78F2-4F0F-BE98-3211CF0D5813
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestView *view = [[TestView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(150, 150, 100, 100);
    [self.view addSubview:view];;
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(psuhController)];
    [view addGestureRecognizer:tapGr];
    
    UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackAction)];
    tapgest.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapgest];
    [self.view addSubview:({
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkBtn addTarget:self action:@selector(checkBtnAgreeAction:) forControlEvents:UIControlEventTouchUpInside];
//        [checkBtn setImage:[UIImage imageNamed:@"delegate_disagree"] forState:UIControlStateNormal];
//        [checkBtn setImage:[UIImage imageNamed:@"delegate_agree"] forState:UIControlStateSelected];
        checkBtn.backgroundColor = [UIColor brownColor];
//        checkBtn.frame = CGRectMake(150, 350, 20, 20);
        self.checkBtn = checkBtn;
        checkBtn;
    })];
   
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(150);
            make.left.mas_equalTo(150);
            make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.checkBtn setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];

}
- (void)tapBackAction {
    NSLog(@"%@", @"UITapGestureRecognizer");
}
- (void)checkBtnAgreeAction:(UIButton *)sender {
    NSLog(@"%@", @"点击了");
}
- (void)psuhController {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = @"内容";
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"square.and.arrow.up.fill"] style:(UIBarButtonItemStylePlain) target:self action:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)dealloc {
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
