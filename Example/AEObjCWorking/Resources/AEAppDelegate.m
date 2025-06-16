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
// 弹框检查函数
NSString *determinePopup(BOOL payeeCheckFlag_1, BOOL isYLJ_2, BOOL victimsFlag_3, BOOL RemindDate_4, BOOL sharescreenFlag_5) {
    NSMutableArray<NSString *> *results = [NSMutableArray array];
    
    // 第一组判断：1 和 2 的组合
    BOOL group1Triggered = NO;
    if (payeeCheckFlag_1 && isYLJ_2) {
        [results addObject:@"2"];
        group1Triggered = YES;
    }
    
    // 第二组判断：3、4、5 的组合
    BOOL group2Triggered = NO;
    if ((victimsFlag_3 && sharescreenFlag_5) || (victimsFlag_3 && RemindDate_4 && sharescreenFlag_5)) {
        [results addObject:@"6"];
        group2Triggered = YES;
    } else if (victimsFlag_3 && RemindDate_4) {
        [results addObject:@"3"];
        group2Triggered = YES;
    }
    
    // 判断其他单独情况（如果第一组或第二组没有完全覆盖到）
    if (!group1Triggered) {
        if (payeeCheckFlag_1) {
            [results addObject:@"1"];
        }
        if (isYLJ_2) {
            [results addObject:@"2"];
        }
    }
    
    if (!group2Triggered) {
        if (victimsFlag_3) {
            [results addObject:@"3"];
        }
        if (RemindDate_4) {
            [results addObject:@"4"];
        }
        if (sharescreenFlag_5) {
            [results addObject:@"5"];
        }
    }
    
    // 如果没有符合条件的弹框，返回无弹框
    if (results.count == 0) {
        return @"0";
    }
    
    // 返回弹框结果
    return [[results sortedArrayUsingComparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString * _Nonnull obj2) {
        return [obj1 integerValue] > [obj2 integerValue];
    }] componentsJoinedByString:@", "];
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
    
    // 枚举所有 32 种情况
            for (int i = 0; i < 32; i++) {
                BOOL payeeCheckFlag_1 = (i & 1) != 0;
                BOOL isYLJ_2 = (i & 2) != 0;
                BOOL victimsFlag_3 = (i & 4) != 0;
                BOOL RemindDate_4 = (i & 8) != 0;
                BOOL sharescreenFlag_5 = (i & 16) != 0;

                // 计算弹框结果
                NSString *result = determinePopup(payeeCheckFlag_1, isYLJ_2, victimsFlag_3, RemindDate_4, sharescreenFlag_5);

                // 打印输入值和结果
                NSLog(@"组合 %d: 1=%d, 2=%d, 3=%d, 4=%d, 5=%d -> 弹框结果: %@",
                    i + 1, payeeCheckFlag_1, isYLJ_2, victimsFlag_3, RemindDate_4, sharescreenFlag_5, result);
            }
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    AEMainTabBarController *tabBarController = [[AEMainTabBarController alloc] init];

    self.window.rootViewController = tabBarController;
    // 设置这个窗口有主窗口并显示
    [self.window makeKeyAndVisible];
    [self test];
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



#pragma mark - test question
/**
 其中关键问题是 performSelector:afterDelay: 的实现机制：

 performSelector:afterDelay: 本质是往当前线程的 RunLoop 添加一个 Timer 任务。⚠️ 但 GCD 创建的 子线程默认没有开启 RunLoop，所以这个 selector 永远不会被调用。
 ✅ 正确使用方式

 如果你真的想让 test1 被调用，有几个办法：

 方法一：加到主线程执行（推荐）
 dispatch_async(dispatch_get_main_queue(), ^{
     [self performSelector:@selector(test1) withObject:nil afterDelay:0];
 });
 方法二：手动启动子线程的 RunLoop（不推荐，一般不这么搞）
 [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(test1) userInfo:nil repeats:NO];
 [[NSRunLoop currentRunLoop] run];
 */
- (void)test {
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSLog(@"test question - 1");
        [self performSelector:@selector(test1) withObject:nil afterDelay:.0];
        NSLog(@"test question - 3");
       
        
    });
}

- (void)test1 {
    NSLog(@"test question - 2");
}
@end
