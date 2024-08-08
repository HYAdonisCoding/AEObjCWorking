//
//  AEActivityViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/7/25.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AEActivityViewController.h"
#import "AEPageMenuController.h"

@interface AEActivityViewController ()<AEPageMenuControllerDelegate>
@property (nonatomic, strong) AEPageMenuController *pageMenuController;

@end

@implementation AEActivityViewController
//- (void)loadView {
//    [super loadView];
- (void)setPageMenu {
    NSMutableArray<UIViewController *> *controllers = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray<NSString *> *monthSymbols = [dateFormatter monthSymbols]; //subarrayWithRange:NSMakeRange(0, 3)];

    for (NSString *month in monthSymbols) {
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.title = month;
        viewController.view.backgroundColor = [UIColor greenColor];
        [controllers addObject:viewController];
    }
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;

    self.pageMenuController = [[AEPageMenuController alloc] initWithControllers:controllers menuStyle:AEPageMenuControllerStyleTab menuColors:@[[UIColor purpleColor], [UIColor orangeColor], [UIColor blueColor]] topBarHeight:statusBarHeight];
    self.pageMenuController.delegate = self;
    [self addChildViewController:self.pageMenuController];
    [self.view addSubview:self.pageMenuController.view];
    

    [self.pageMenuController didMoveToParentViewController:self];
    
    UIScrollView *topView = [self.pageMenuController getTheScrollView];
    [self.navigationController.view addSubview:topView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setPageMenu];
    self.navigationItem.title = @"";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - AEPageMenuControllerDelegate

- (void)pageMenuController:(AEPageMenuController *)pageMenuController willMoveToViewController:(UIViewController *)viewController atMenuIndex:(NSInteger)menuIndex {
    // Implement your code here
}

- (void)pageMenuController:(AEPageMenuController *)pageMenuController didMoveToViewController:(UIViewController *)viewController atMenuIndex:(NSInteger)menuIndex {
    // Implement your code here
}

- (void)pageMenuController:(AEPageMenuController *)pageMenuController didPrepareMenuItems:(NSArray<AEPageMenuItem *> *)menuItems {
    // XXX: For .hacka style
    NSUInteger i = 1;
    for (AEMenuItem * item in menuItems) {
      item.badgeValue = [NSString stringWithFormat:@"%zd", i++];
    }
}

- (void)pageMenuController:(AEPageMenuController *)pageMenuController didSelectMenuItem:(AEPageMenuItem *)menuItem atMenuIndex:(NSInteger)menuIndex {
//    menuItem.badgeValue = nil;  XXX: For .hacka style
}


@end
