//
//  AENotification.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/11/23.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 推送管理类
@interface AENotification : NSObject
+ (AENotification *)notificationManager;

- (void)checkNotificationAuthorization:(void (^)(BOOL granted))completionHandler;
@end

NS_ASSUME_NONNULL_END
