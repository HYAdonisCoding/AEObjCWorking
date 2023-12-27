//
//  AENavigationBarHeightManager.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/11/3.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AENavigationBarHeightManager.h"

@implementation AENavigationBarHeightManager {
    CGFloat _navigationBarHeightWithSafeArea; // 声明属性
}

+ (instancetype)sharedManager {
    static AENavigationBarHeightManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (CGFloat)navigationBarHeightWithSafeArea {
    CGFloat navigationBarHeight = 0.0;

    UIWindow *keyWindow = [[UIApplication sharedApplication].windows firstObject];
    UIViewController *topViewController = [self topNavigationControllerWithRootViewController:keyWindow.rootViewController];

    if (topViewController) {
        UINavigationBar *navigationBar = ((UINavigationController *)topViewController).topViewController.navigationController.navigationBar;

        if (navigationBar) {
            if (@available(iOS 11.0, *)) {
                UIEdgeInsets safeAreaInsets = topViewController.view.safeAreaInsets;
                navigationBarHeight = CGRectGetHeight(navigationBar.frame) + safeAreaInsets.top;
            } else {
                navigationBarHeight = CGRectGetHeight(navigationBar.frame);
            }
        }
    }

    return navigationBarHeight;
}

- (CGFloat)bottomSafeAreaHeight {
    CGFloat bottomSafeAreaHeight = 0.0;

    UIWindow *keyWindow = [[UIApplication sharedApplication].windows firstObject];
    UIViewController *topViewController = [self topNavigationControllerWithRootViewController:keyWindow.rootViewController];

    if (topViewController) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeAreaInsets = topViewController.view.safeAreaInsets;
            bottomSafeAreaHeight = safeAreaInsets.bottom;
        }
    }

    return bottomSafeAreaHeight;
}

- (UIWindow *)keyWindowForTopScene {
    for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
        if (windowScene.activationState == UISceneActivationStateForegroundActive) {
            for (UIWindow *window in windowScene.windows) {
                return window;
            }
        }
    }
    return nil;
}

- (UIViewController *)topNavigationControllerWithRootViewController:(UIViewController *)rootViewController {
    if (!rootViewController) {
        return nil;
    }

    if (rootViewController.presentedViewController) {
        return [self topNavigationControllerWithRootViewController:rootViewController.presentedViewController];
    }

    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        if (tabBarController.selectedViewController) {
            return [self topNavigationControllerWithRootViewController:tabBarController.selectedViewController];
        }
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
//        if (navigationController.visibleViewController) {
//            return navigationController.visibleViewController;
//        }
        return navigationController;
    }

    return rootViewController;
}
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if (!rootViewController) {
        return nil;
    }

    if (rootViewController.presentedViewController) {
        return [self topViewControllerWithRootViewController:rootViewController.presentedViewController];
    }

    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        if (tabBarController.selectedViewController) {
            return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
        }
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        if (navigationController.visibleViewController) {
            return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
        }
    }

    return rootViewController;
}

@end
