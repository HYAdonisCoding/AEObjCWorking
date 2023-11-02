//
//  AENotification.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/11/23.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AENotification.h"
#import <UserNotifications/UserNotifications.h>

@interface AENotification ()<UNUserNotificationCenterDelegate>
/// 推送选项
@property (nonatomic, assign) UNAuthorizationOptions options;

@end

@implementation AENotification
// MARK: - Public Method
+ (AENotification *)notificationManager {
    static AENotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        
    });
    return manager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay;
    }
    return self;
}

- (void)checkNotificationAuthorization:(void (^)(BOOL granted))completionHandler {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    [center requestAuthorizationWithOptions:(self.options) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 本地推送
            [self _pushLocalNotification];
        }
        if (completionHandler) {
            completionHandler(granted);
        }
    }];
}

// MARK: - Pritive Method
- (void)_pushLocalNotification {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.badge = @(1);
        content.title = @"进修时间";
        content.body = @"从头再来开发一款完美的APP";
        content.sound = [UNNotificationSound defaultSound];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10.f repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"_pushLocalNotification" content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                    //
                    NSLog(@"error - %@", error.localizedDescription);
        }];
}

// MARK: - UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert);
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
        //处理badge展示逻辑
        //点击之后根据业务逻辑处理
        //[UIApplication sharedApplication].applicationIconBadgeNumber = 100;

        //处理业务逻辑
        completionHandler();
}
@end
