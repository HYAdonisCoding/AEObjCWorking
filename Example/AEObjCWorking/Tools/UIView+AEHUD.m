//
//  UIView+AEHUD.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/7.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "UIView+AEHUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define kTimer 0.9

@implementation UIView (AEHUD)

static char timerKey;

- (void)setTimer:(dispatch_source_t)timer {
    objc_setAssociatedObject(self, &timerKey, timer, OBJC_ASSOCIATION_RETAIN);
    
    // dispatch_source_t timer = objc_getAssociatedObject(self, &timerKey);
}

- (void)show {
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
}

- (void)hide {
    [SVProgressHUD dismiss];
}

- (void)showProgress:(NSString *)info success:(void(^)(void))success {
    [SVProgressHUD showProgress:0 status:info];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    CGFloat __block progress = 0.0f;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.15 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (progress < 1) {
            progress += (1 / (info.length * kTimer));
            NSLog(@"progress: %f", progress);
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showProgress:progress status:info];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                if (success) {
                    success();
                }
            });
            dispatch_source_cancel(timer);
            self.timer = nil;
            
        }
    });
    dispatch_resume(timer);
    
    [self setTimer:timer];
}

- (void)showSuccess:(NSString *)info success:(void(^)(void))success {
    [SVProgressHUD showSuccessWithStatus:info];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(info.length * kTimer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
        if (success) {
            success();
        }
    });
}

- (void)showError:(NSString *)info success:(void(^)(void))success {
    [SVProgressHUD showErrorWithStatus:info];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(info.length * kTimer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
        if (success) {
            success();
        }
    });
}


@end
