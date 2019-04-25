//
//  AEAuthenticeTool.m
//  Adam_20190424_TouchID_Demo
//
//  Created by Adam on 2019/4/24.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEAuthenticeTool.h"
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>


/**
 是否是X系列
 */
#define kIsIPhoneXSeries ((([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0f) && ([[[[UIApplication sharedApplication] delegate] window] safeAreaInsets].bottom > 0.0))? YES : NO)

@interface AEAuthenticeTool ()

/** 是否是第一次调用 */
@property (nonatomic, assign) BOOL isFirstVerify;

/** 上下文 */
@property (nonatomic, strong) LAContext *context;

/** 验证类型 */
@property (nonatomic, assign) HYAuthenticationVerifyType verifyType;
/** 类型字符串 */
@property (nonatomic, copy) NSString *typeString;

@end

@implementation AEAuthenticeTool

+(void)authenticatedByBiometryOrDevicePasscodeCompletionHandlers:(CompletionHandlers)completionHandlers {
    AEAuthenticeTool *tool = [AEAuthenticeTool new];
    tool.context = [[LAContext alloc] init];
    tool.isFirstVerify = YES;
    [tool authenticatedByBiometryOrDevicePasscodeCompletionHandlers:completionHandlers];
}


-(void)authenticatedByBiometryOrDevicePasscodeCompletionHandlers:(CompletionHandlers)completionHandlers {
    
    //开始验证
    [self authenticatedByBiometryOrDevicePasscodeVerifyWithContext:self.context completionHandlers:^(BOOL success, HYAuthenticationVerifyType type, NSString * _Nullable descString, NSError * _Nullable error) {
        if (success) {
            completionHandlers(YES, self.verifyType, @"Verify success", error);
        } else {
            [self callBackWithFaceIDOrTouchIDWithContext:self.context andError:error completionHandlers:^(BOOL success, HYAuthenticationVerifyType type, NSString * _Nullable descString, NSError * _Nullable error) {
                completionHandlers(success, type, descString, error);
            }];
        }
    }];
}

///开始验证
-(void)authenticatedByBiometryOrDevicePasscodeVerifyWithContext:(LAContext *)context completionHandlers:(CompletionHandlers)completionHandlers {
    
    self.verifyType = HYAuthenticationVerifyTypeTouchID;
    //判断是否是X系列
    if (@available(iOS 11.0, *)) {
        if (kIsIPhoneXSeries) {
            self.verifyType = HYAuthenticationVerifyTypeFaceID;
        }
    } else {
        // Fallback on earlier versions
    }
    if (!self.isFirstVerify) {
        self.verifyType = HYAuthenticationVerifyTypeSecretCode;
    }
    NSError *error;
    
    NSString *localizedReason = [NSString stringWithFormat:@"请使用%@验证", self.typeString];
    
    if ([context canEvaluatePolicy:(LAPolicyDeviceOwnerAuthentication) error:&error]) {
        [context evaluatePolicy:(LAPolicyDeviceOwnerAuthentication) localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error) {
            if (!self.isFirstVerify) {
                self.verifyType = HYAuthenticationVerifyTypeSecretCode;
            }
            if (success) {
                completionHandlers(YES, self.verifyType, @"verify success", error);
            } else {
                [self callBackWithFaceIDOrTouchIDWithContext:context andError:error completionHandlers:^(BOOL success, HYAuthenticationVerifyType type, NSString * _Nullable descString, NSError * _Nullable error1) {
                    completionHandlers(success, self.verifyType, descString, error1);
                }];
            }
        }];
    } else {
        self.verifyType = HYAuthenticationVerifyTypeNullID;
        
        //不支持验证
        completionHandlers(NO, self.verifyType, @"no support", error);
    }
}

///错误的系统回调
-(void)callBackWithFaceIDOrTouchIDWithContext:(LAContext *)context andError:(NSError *)error completionHandlers:(CompletionHandlers)completionHandlers {
    NSLog(@"%s - %@", __func__, @"here");
    
    if (!self.isFirstVerify) {
        self.verifyType = HYAuthenticationVerifyTypeSecretCode;
    } else {
        self.isFirstVerify = NO;
    }
    
    switch (error.code) {
            /// Authentication was not successful, because user failed to provide valid credentials.身份验证失败，因为用户无法提供有效的凭据。
        case LAErrorAuthenticationFailed: {
            if (self.verifyType != HYAuthenticationVerifyTypeSecretCode) {
                [self authenticatedByBiometryOrDevicePasscodeCompletionHandlers:^(BOOL success, HYAuthenticationVerifyType type, NSString * _Nullable descString, NSError * _Nullable error) {
                    completionHandlers(success, type, descString, error);
                }];
            }
            break;
        }
            /// Authentication was canceled by user (e.g. tapped Cancel button).用户取消了身份验证（例如点按了取消按钮）。
        case LAErrorUserCancel:
            completionHandlers(NO, self.verifyType, @"Authentication was canceled by user", error);
            break;
            /// Authentication was canceled, because the user tapped the fallback button (Enter Password).验证已取消，因为用户点击了后备按钮（输入密码）
        case LAErrorUserFallback: {
            [self authenticatedByBiometryOrDevicePasscodeCompletionHandlers:^(BOOL success, HYAuthenticationVerifyType type, NSString * _Nullable descString, NSError * _Nullable error) {
                completionHandlers(success, type, descString, error);
            }];
            break;
        }
            /// Authentication was canceled by system (e.g. another application went to foreground).系统取消了身份验证（例如，另一个应用程序转到了前台）。
        case LAErrorSystemCancel:
            completionHandlers(NO, self.verifyType, @"Authentication was canceled by system", error);
            break;
            /// Authentication could not start, because passcode is not set on the device.身份验证无法启动，因为设备上未设置密码。
        case LAErrorPasscodeNotSet:
            completionHandlers(NO, self.verifyType, @"Passcode is not set on the device", error);
            break;
            /// Authentication was canceled by application (e.g. invalidate was called while
            /// authentication was in progress).应用程序取消了身份验证（例如，在调用时调用了invalidate身份验证正在进行中）。
        case LAErrorAppCancel:
            completionHandlers(NO, self.verifyType, @"Authentication was canceled by application", error);
            break;
            /// LAContext passed to this call has been previously invalidated.传递给此调用的LAContext以前已失效。
        case LAErrorInvalidContext:
            completionHandlers(NO, self.verifyType, @"The context is invalid", error);
            break;
            /// Authentication could not start, because biometry is not available on the device.身份验证无法启动，因为设备上没有生物统计信息。
            
        case LAErrorBiometryNotAvailable:
            completionHandlers(NO, self.verifyType, @"biometry is not available on the device", error);
            break;
            /// Authentication could not start, because biometry has no enrolled identities.身份验证无法启动，因为生物统计没有注册的身份。
            /// Authentication was not successful, because there were too many failed biometry attempts and
            /// biometry is now locked. Passcode is required to unlock biometry, e.g. evaluating
            /// LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.身份验证不成功，因为有太多失败的生物测定尝试和生物测定现已锁定。需要密码来解锁生物测定，例如评估将要求输入密码作为先决条件。
        case LAErrorBiometryLockout: {
            [self authenticatedByBiometryOrDevicePasscodeCompletionHandlers:^(BOOL success, HYAuthenticationVerifyType type, NSString * _Nullable descString, NSError * _Nullable error) {
                completionHandlers(success, type, descString, error);
            }];
            break;
        }
        default:
            completionHandlers(NO, self.verifyType, @"Did not find error code on LAError object", error);
            break;
    }
}


- (void)setVerifyType:(HYAuthenticationVerifyType)verifyType {
    _verifyType = verifyType;
    NSLog(@"%@ = %lu", self.typeString, verifyType);
    
    switch (self.verifyType) {
        case HYAuthenticationVerifyTypeFaceID:
            self.typeString = @"FaceID";
            break;
        case HYAuthenticationVerifyTypeTouchID:
            self.typeString = @"TouchID";
            break;
        case HYAuthenticationVerifyTypeSecretCode:
            self.typeString = @"SecretCode";
            break;
        case HYAuthenticationVerifyTypeNullID:
            self.typeString = @"NullID";
            break;
    }
}

@end
