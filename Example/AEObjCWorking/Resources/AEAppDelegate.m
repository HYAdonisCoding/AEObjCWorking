//
//  AEAppDelegate.m
//  AEObjCWorking
//
//  Created by HYAdonisCoding on 04/25/2019.
//  Copyright (c) 2021 HYAdonisCoding. All rights reserved.
//

#import "AEAppDelegate.h"
#import "UIImage+AEBlackAndWhite.h"
#import "UIButton+EnlargeArea.h"
#import "AEHomeViewController.h"
#import "AEUnconventionalViewController.h"
#import "AEMineViewController.h"
#import "AEMainTabBarController.h"

@implementation AEAppDelegate
// MARK: - Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [UIImage ae_imageSwizzldMethedWith:YES];
    [UIButton ae_buttonSwizzldMethedWith:YES];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    AEMainTabBarController *tabBarController = [[AEMainTabBarController alloc] init];
//    AEHomeViewController *firstViewController = [[AEHomeViewController alloc] init];
//    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:firstViewController];
//    firstViewController.title = @"Home";
//
//    AEUnconventionalViewController *secondViewController = [[AEUnconventionalViewController alloc] init];
//    secondViewController.title = @"Trial";
//    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:secondViewController];
//    
//    AEMineViewController *thridViewController = [[AEMineViewController alloc] init];
//    thridViewController.title = @"Mine";
    
//    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:thridViewController];
//    
//    tabBarController.viewControllers = @[nav1, nav2, nav3];
    
//    [tabBarController addOneChildVc:nav1 title:@"主页" image:[UIImage systemImageNamed:@"house"] selectedImage:[UIImage systemImageNamed:@"house.fill"]];
//    
//    [tabBarController addOneChildVc:nav2 title:@"热门" image:[UIImage systemImageNamed:@"flame"] selectedImage:[UIImage systemImageNamed:@"flame.fill"]];
//    
//    [tabBarController addOneChildVc:nav3 title:@"我的" image:[UIImage systemImageNamed:@"person"] selectedImage:[UIImage systemImageNamed:@"person.fill"]];

    self.window.rootViewController = tabBarController;
    // 设置这个窗口有主窗口并显示
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// MARK: - Push Notitfication
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //尽量收敛到GTNotification中实现
    //注册成功
    NSLog(@"deviceToken:%@ ", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //注册失败
}


@end
