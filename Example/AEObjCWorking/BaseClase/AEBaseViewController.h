//
//  AEBaseViewController.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEBaseViewController : UIViewController
- (NSString *)testString;

/// 配置页面
- (void)configUI;


/// 配置事件
- (void)configEvent;

/// 创建一个ImageView
- (UIImageView *)createImageView;
@end

NS_ASSUME_NONNULL_END
