//
//  AEBaseView.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEBaseView : UIView
/**
 是否有子视图在滚动
 
 @param view 视图
 @return 是否滚动
 */
- (BOOL)anySubViewScrolling:(UIView *)view;


/**
 播放声音或者振动
 */
- (void)playSystemSound;

@end

NS_ASSUME_NONNULL_END
