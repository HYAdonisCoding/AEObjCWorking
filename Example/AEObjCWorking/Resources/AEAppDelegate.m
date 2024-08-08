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
#import "AEMainTabBarController.h"
//#import <GoogleMobileAds/GoogleMobileAds.h>
#import "AESplashViewController.h"
#import "AEGuideViewController.h"

#import "AEContainerViewController.h"
@implementation AEAppDelegate
// MARK: - Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startApp) name:@"startApp" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterApp) name:@"enterApp" object:nil];
    
    // Override point for customization after application launch.
//    GADMobileAds *ads = [GADMobileAds sharedInstance];
//    [ads initializationStatus];
//    ads.requestConfiguration.testDeviceIdentifiers = @[@"ca-app-pub-3940256099942544/5575463023", @"ca-app-pub-3940256099942544/2934735716"];
//    [ads startWithCompletionHandler:^(GADInitializationStatus * _Nonnull status) {
//        NSLog(@"status.adapterStatusesByClassName: %@", status.adapterStatusesByClassName);
//    }];
    
   
    [UIImage ae_imageSwizzldMethedWith:YES];
    [UIButton ae_buttonSwizzldMethedWith:YES];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 获取 UserDefaults 中的标志位
    BOOL hasShownGuide = [[NSUserDefaults standardUserDefaults] boolForKey:@"HasShownGuide"];
    
    // 根据标志位决定进入引导页还是直接进入开屏页
    if (!hasShownGuide) {
        // 进入引导页
        AEGuideViewController *guideViewController = [[AEGuideViewController alloc] init];
        self.window.rootViewController = guideViewController;
    } else {
        // 进入开屏页或者主界面
        AESplashViewController *splashScreenViewController = [[AESplashViewController alloc] init];
        self.window.rootViewController = splashScreenViewController;
    }
    
    
    // 设置这个窗口有主窗口并显示
    [self.window makeKeyAndVisible];

    
    return YES;
}

// 进入App
- (void)enterApp {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasShownGuide"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 进入开屏页或者主界面
    AESplashViewController *splashScreenViewController = [[AESplashViewController alloc] init];
    self.window.rootViewController = splashScreenViewController;
}

// 进入首页
- (void)startApp {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    AEMainTabBarController *tabBarController = [[AEMainTabBarController alloc] init];

    self.window.rootViewController = tabBarController;
    // 设置这个窗口有主窗口并显示
    [self.window makeKeyAndVisible];
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
