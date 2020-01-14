//
//  AEMainTabBarViewController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/9.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEMainTabBarViewController.h"
#import "AETabBar.h"
#import "AETabBarItem.h"

@interface AEMainTabBarViewController ()<AETabBarDelegate>

/// 按钮
@property (nonatomic, strong) AETabBar *mainTabBar;
@end

@implementation AEMainTabBarViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Do any additional setup after loading the view.
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor redColor];
        UIViewController *vc1 = [UIViewController new];
        vc1.view.backgroundColor = [UIColor orangeColor];
        UIViewController *vc2 = [UIViewController new];
        vc2.view.backgroundColor = [UIColor yellowColor];
        UIViewController *vc3 = [UIViewController new];
        vc3.view.backgroundColor = [UIColor greenColor];
        UIViewController *vc4 = [UIViewController new];
        vc4.view.backgroundColor = [UIColor blueColor];
        self.viewControllers = @[vc, vc1, vc2, vc3, vc4];
        if (@available(iOS 13.0, *)) {
            [self addOneChildVc:vc title:@"主页" image:[UIImage systemImageNamed:@"house"] selectedImage:[UIImage systemImageNamed:@"house.fill"]];
            [self addOneChildVc:vc1 title:@"我的" image:[UIImage systemImageNamed:@"person"] selectedImage:[UIImage systemImageNamed:@"person.fill"]];
            [self addOneChildVc:vc2 title:@"222" image:[UIImage systemImageNamed:@"plus.circle"] selectedImage:[UIImage systemImageNamed:@"plus.circle.fill"]];
            [self addOneChildVc:vc3 title:@"热门" image:[UIImage systemImageNamed:@"flame"] selectedImage:[UIImage systemImageNamed:@"flame.fill"]];
            [self addOneChildVc:vc4 title:@"bolt" image:[UIImage systemImageNamed:@"bolt"] selectedImage:[UIImage systemImageNamed:@"bolt.fill"]];
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}
/**
 *  添加一个子控制器
 *
 *  @param childVc           需要添加的子控制器
 *  @param title             需要调节自控制器的标题
 *  @param imageName         需要调节自控制器的默认状态的图片
 *  @param selectedImageName 需要调节自控制器的选中状态的图片
 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    // 1.设置子控制器的属性
    childVc.title = title;
    
    childVc.tabBarItem.image = image;
    
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    // 2.将自控制器添加到tabbar控制器中
    [self addChildViewController:childVc];
    
    // 3.调用自定义tabBar的添加按钮方法, 创建一个与当前控制器对应的按钮
    [self.mainTabBar addTabBarButton: childVc.tabBarItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTabBar = [[AETabBar alloc] init];
    self.mainTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:self.mainTabBar];
    self.mainTabBar.delegate = self;
    self.selectedIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 遍历系统的tabbar移除不需要的控件
    for (UIView *subView in self.tabBar.subviews) {
        // UITabBarButton私有API, 普通开发者不能使用
        if ([subView isKindOfClass:[UIControl class]]) {
            // 判断如果子控件时UITabBarButton, 就删除
            [subView removeFromSuperview];
        }
    }
}


- (void)itemAction:(id)sender {
    NSLog(@"%@", @"desc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tabBar:(nonnull AETabBar *)tabBar selectedButtonfrom:(NSInteger)from to:(NSInteger)to {
    NSLog(@"从第%ld控制器切换到第%ld控制器",(long)from,(long)to);
     // 切换控制器
     self.selectedIndex = to;
}


@end
