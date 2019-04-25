//
//  HYAuthenticeTool.h
//  Adam_20190424_TouchID_Demo
//
//  Created by Adonis_HongYang on 2019/4/24.
//  Copyright © 2019 Nikoyo (China）Electronics Systems Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 ID 验证枚举
 */
typedef NS_ENUM(NSUInteger, HYAuthenticationVerifyType) {
    HYAuthenticationVerifyTypeFaceID,
    HYAuthenticationVerifyTypeTouchID,
    HYAuthenticationVerifyTypeSecretCode,
    HYAuthenticationVerifyTypeNullID
};


/**
 回调

 @param success 成功否
 @param type 类型
 @param descString 描述
 @param error 错误
 */
typedef void(^CompletionHandlers)(BOOL success, HYAuthenticationVerifyType type, NSString * _Nullable descString, NSError * _Nullable error);


NS_ASSUME_NONNULL_BEGIN

@interface HYAuthenticeTool : NSObject

+ (void)authenticatedByBiometryOrDevicePasscodeCompletionHandlers:(CompletionHandlers)completionHandlers;


@end

NS_ASSUME_NONNULL_END
