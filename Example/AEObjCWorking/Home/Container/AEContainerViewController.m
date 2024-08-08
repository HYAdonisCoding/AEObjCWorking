//
//  AEContainerViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/7/23.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AEContainerViewController.h"
#import "AEPageMenuController.h"


@interface AEContainerViewController ()<AEPageMenuControllerDelegate>
@property (nonatomic, strong) AEPageMenuController *pageMenuController;
@end

@implementation AEContainerViewController


- (void)setup {
    self.title = @"PageMenuKit Frameworks";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray<UIViewController *> *controllers = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray<NSString *> *monthSymbols = [[dateFormatter monthSymbols] subarrayWithRange:NSMakeRange(0, 3)];

    for (NSString *month in monthSymbols) {
        UIViewController *viewController = [[UIViewController alloc] init];
        viewController.title = month;
        [controllers addObject:viewController];
    }

    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;

    self.pageMenuController = [[AEPageMenuController alloc] initWithControllers:controllers menuStyle:AEPageMenuControllerStyleTab menuColors:@[[UIColor purpleColor], [UIColor orangeColor], [UIColor blueColor]] topBarHeight:statusBarHeight];
//    [[AEPageMenuController alloc] initWithControllers:controllers menuStyle:AEPageMenuControllerStyleTab
//                                                                     menuColors:@[[UIColor purpleColor], [UIColor orangeColor], [UIColor blueColor]]
//                                                                     startIndex:1
//                                                                  topBarHeight:statusBarHeight];

    self.pageMenuController.delegate = self;
    [self addChildViewController:self.pageMenuController];
    [self.view addSubview:self.pageMenuController.view];
    [self.pageMenuController didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
