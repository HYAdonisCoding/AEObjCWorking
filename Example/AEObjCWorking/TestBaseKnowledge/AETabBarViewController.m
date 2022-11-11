//
//  AETabBarViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/10/17.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AETabBarViewController.h"
#import "AEKnowledgeViewController.h"

@implementation AETabBarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        AEKnowledgeViewController *controller1 = [[AEKnowledgeViewController alloc] init];
//        UINavigationController *controller1 = [[UINavigationController alloc] initWithRootViewController:root];
//        UIViewController *controller1 = [[UIViewController alloc] init];
        controller1.view.backgroundColor = [UIColor greenColor];
        controller1.tabBarItem.title = @"新闻";
        controller1.tabBarItem.image = [UIImage systemImageNamed:@"newspaper"];
        controller1.tabBarItem.selectedImage = [UIImage systemImageNamed:@"newspaper.fill"];
        
        UIViewController *controller2 = [[UIViewController alloc] init];
        controller2.tabBarItem.title = @"视频";
        controller2.view.backgroundColor = [UIColor redColor];
        controller2.tabBarItem.image = [UIImage systemImageNamed:@"video"];
        controller2.tabBarItem.selectedImage = [UIImage systemImageNamed:@"video.fill"];
        
        UIViewController *controller3 = [[UIViewController alloc] init];
        controller3.tabBarItem.title = @"收藏";
        controller3.view.backgroundColor = [UIColor blueColor];
        controller3.tabBarItem.image = [UIImage systemImageNamed:@"hand.thumbsup"];
        controller3.tabBarItem.selectedImage = [UIImage systemImageNamed:@"hand.thumbsup.fill"];
        
        UIViewController *controller4 = [[UIViewController alloc] init];
        controller4.tabBarItem.title = @"我的";
        controller4.view.backgroundColor = [UIColor brownColor];
        controller4.tabBarItem.image = [UIImage systemImageNamed:@"person"];
        controller4.tabBarItem.selectedImage = [UIImage systemImageNamed:@"person.fill"];
        
        [self setViewControllers:@[controller1, controller2, controller3, controller4]];
        
//        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
//
//        standardAppearance.backgroundColor = [UIColor blackColor];//根据自己的情况设置
//        standardAppearance.shadowColor = [UIColor clearColor];//也可以设置为白色或任何颜色
//        standardAppearance.backgroundImage = [self createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.65]];
//
//        standardAppearance.shadowImage = [self createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]];
//        //下面这行代码最关键
//        [standardAppearance configureWithTransparentBackground];
//
//        self.tabBar.standardAppearance = standardAppearance;

    }
    return self;
}
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);

    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);

    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return theImage;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]]];
    //背景图片
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.65]]];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    //设置为半透明
    self.tabBarController.tabBar.translucent = YES;
}
@end
