//
//  AEMainTabBarController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/9.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEMainTabBarController.h"
#import "AETabBar.h"
#import "AEBarView.h"
#import "AEHomeViewController.h"
#import "AEUnconventionalViewController.h"
#import "AEMineViewController.h"
#import "AENavigationViewController.h"
#import "AEActivityViewController.h"

@interface AEMainTabBarController ()

/// 按钮
@property (nonatomic, strong) AETabBar *customTabBar;
@end

@implementation AEMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
//    [self setValue:self.customTabBar forKey:@"tabBar"];
    
    [self initViewControllers];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.selectedIndex = 3;
//    });
}

-(void)initViewControllers{
    NSMutableArray * viewControllers = [NSMutableArray new];
    
    AEHomeViewController *firstViewController = [[AEHomeViewController alloc] init];
    AEUnconventionalViewController *secondViewController = [[AEUnconventionalViewController alloc] init];
    AEMineViewController *mineVC = [[AEMineViewController alloc] init];
    AEActivityViewController *activity = [[AEActivityViewController alloc] init];
    
    [viewControllers addObject:[self addChildViewController:firstViewController title:@"Home" imageNamed:@"house"]];

    [viewControllers addObject:[self addChildViewController:secondViewController title:@"Trial" imageNamed:@"flame"]];
    [viewControllers addObject:[self addChildViewController:activity title:@"Activity" imageNamed:@"figure.run"]];
    [viewControllers addObject:[self addChildViewController:mineVC title:@"Mine" imageNamed:@"person"]];
    

    self.viewControllers = viewControllers;
}
// 添加某个 childViewController
- (UINavigationController *)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed{
    AENavigationViewController *nav = [[AENavigationViewController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage systemImageNamed:imageNamed];
    nav.tabBarItem.selectedImage = [UIImage systemImageNamed:[NSString stringWithFormat:@"%@.fill", imageNamed]];
    return nav;
}

-(void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    [super setViewControllers:viewControllers];
    [self.customTabBar.tabBarView initButtonWithViewControllers:viewControllers];
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    self.customTabBar.tabBarView.selectIndex = selectedIndex;
}
#pragma mark ---G
- (AETabBar *)customTabBar{
    if(!_customTabBar){
        _customTabBar = [[AETabBar alloc] init];
        __weak __typeof(self) _self = self;
        _customTabBar.tabBarView.selectBlock = ^(NSInteger index) {
             _self.selectedIndex = index;
        };
        /*中间按钮*/
        _customTabBar.tabBarView.haveCenterButton = YES;
        _customTabBar.tabBarView.centerImage =[UIImage imageNamed:@"plus"];
        _customTabBar.tabBarView.selectCenterBlock = ^{
            NSLog(@"中间按钮点击了");
        };
    }
    return _customTabBar;
}

@end
