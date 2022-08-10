//
//  AETabBar.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/9.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AETabBar;

@protocol AETabBarDelegate <NSObject>

/**
 *  当自定义tabBar的按钮被点击之后的监听方法
 *
 *  @param tabBar 触发事件的控件
 *  @param from   上一次选中的按钮的tag
 *  @param to     当前选中按钮的tag
 */
- (void)tabBar:(AETabBar *)tabBar selectedButtonfrom:(NSInteger)from to:(NSInteger)to;

@end

@interface AETabBar : UITabBar

/**
 *  根据模型创建对应控制器的对应按钮
 *
 *  @param item 数据模型(图片/选中图片/标题)
 */
- (void)addTabBarButton:(UITabBarItem *)item;

@property (nonatomic, weak) id<AETabBarDelegate> _Nullable delegate;

@end

NS_ASSUME_NONNULL_END
