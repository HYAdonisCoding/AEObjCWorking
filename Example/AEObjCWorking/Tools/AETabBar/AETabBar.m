//
//  AETabBar.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/9.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AETabBar.h"
#import "AETabBarButton.h"
#import "AEBarView.h"

@interface AETabBar ()

/**
 * 上一次选中按钮
 */
@property (nonatomic, weak) UIButton *lastButton;
/**
 *  保存所有选项卡按钮
 */
@property (nonatomic, strong) NSMutableArray  *buttons;
/**
 *  当前选中的按钮
 */
@property (nonatomic, weak) UIButton  *selectedButton;

@end

@implementation AETabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tabBarView];
        [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.right.and.left.and.bottom.equalTo(self);
        }];
    }
    return self;
}

// 重写hitTest方法，让超出tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在tabbar里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.tabBarView.subviews) {
        // 把这个坐标从tabbar的坐标系转为subview的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在subView里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

#pragma mark ---G
- (AEBarView*)tabBarView {
    if(!_tabBarView){
        _tabBarView = [[AEBarView alloc] init];
    }
    return _tabBarView;
}
@end
