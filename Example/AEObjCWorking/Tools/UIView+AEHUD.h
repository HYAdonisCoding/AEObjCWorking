//
//  UIView+AEHUD.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/7.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AEHUD)
- (void)show;

- (void)hide;

- (void)showProgress:(NSString *)info success:(void(^)(void))success;

- (void)showSuccess:(NSString *)info success:(void(^)(void))success;

- (void)showError:(NSString *)info success:(void(^)(void))success;

@end

NS_ASSUME_NONNULL_END
