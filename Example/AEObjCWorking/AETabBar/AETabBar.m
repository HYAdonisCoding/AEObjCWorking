//
//  AETabBar.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/9.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AETabBar.h"
#import "AETabBarButton.h"

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
        self.backgroundColor = [UIColor whiteColor];
        // 1.设置添加按钮的frame
//        [self setupPlusBtnFrame];
    }
    return self;
}

#pragma mark - 设置子控件frame
- (void)layoutSubviews
{
#warning 一定要调用父类方法
    [super layoutSubviews];
    
    

    // 2.设置选项卡按钮的frame
    [self setupOtherBtnFrame];
}
/**
 *  设置选项卡按钮的frame
 */
- (void)setupOtherBtnFrame
{
    
    // 遍历数组设置选项卡frame
    // 计算宽度, 获取高度, 获取按钮的个数只需要执行一次即可
    int count = self.buttons.count;
    CGFloat btnWidth  = self.frame.size.width / (count);
    CGFloat btnHeigth = self.frame.size.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.buttons[i];
        btn.frame = CGRectMake( i * btnWidth, 0, btnWidth, btnHeigth);
        
        // 判断如果是到了中间一个按钮就增加一个按钮的宽度
//        if (i >= count / 2) {
//            btn.frame = CGRectMake((i + 1) * btnWidth, 0, btnWidth, btnHeigth);
//        }
        if (self.lastButton == btn) {
//            NSLog(@"%@ - %@", @"选中", btn);
//            [UIView animateWithDuration:0.25 animations:^{
//                btn.frame = CGRectMake( i * btnWidth, -btnHeigth*0.25, btnWidth, btnHeigth*1.3);
//            }];
            [UIView animateWithDuration:0.4 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
                btn.frame = CGRectMake( i * btnWidth, 0, btnWidth, btnHeigth);
                btn.selected = NO;
            } completion:^(BOOL finished) {
                self.selectedButton.selected = YES;
                self.selectedButton.frame = CGRectMake( i * btnWidth, -btnHeigth*0.25, btnWidth, btnHeigth*1.3);
            }];
        } else {
            NSLog(@"%@ - %@", @"未选中", btn);
        }
    }
}
///**
// *  设置添加按钮的frame
// */
//- (void)setupPlusBtnFrame
//{
//    // 2.设置宽高
//    // 2.1获取黄色图片的size
//    CGSize imageSize = self.plusBtn.currentBackgroundImage.size;
//    self.plusBtn.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
//
//    // 1.设置位置
//    self.plusBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
//
//
//}

#pragma mark - 添加按钮方法
- (void)addTabBarButton:(UITabBarItem *)item {
    // 1.创建按钮
    AETabBarButton *btn = [[AETabBarButton alloc] init];

    // 2.从UITabBarItem取出标题, 设置标题
    btn.item = item;

    [self addSubview:btn];

    // 设置按钮的tag
    btn.tag = self.buttons.count;

    // 3.每次添加完按钮后将按钮存储到数组中
    [self.buttons addObject:btn];

    // 4.监听按钮点击事件
    [btn addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchDown];

    // 5.设置默认选中的按钮
    if (self.buttons.count == 1) {
        // 选中某一个按钮就相当于点击某一个按钮
        [self buttonOnClick:btn];
    }
}

- (void)buttonOnClick:(UIButton *)btn {
    
    if (self.selectedButton == btn) {
        return;
    }
    // 0. 通知代理按钮被点击了
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedButtonfrom:to:)]) {
        [self.delegate tabBar:self selectedButtonfrom:self.selectedButton.tag to:btn.tag];
    }
    
    // 1.取消上一次选中的按钮
//    self.selectedButton.selected = NO;
    self.lastButton = self.selectedButton;
    // 2.选中当前按钮
//    btn.selected = YES;
    // 3.记录当前选中的按钮
    self.selectedButton = btn;
    
    [self layoutSubviews];
}

#pragma mark - 懒加载
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

//- (UIButton *)plusBtn
//{
//    if (_plusBtn == nil) {
//        UIButton *plusBtn = [[UIButton alloc] init];
//        // 1.2.设置背景图片
//        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
//        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
//        // 1.3.设置图标
//        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        // 1.4.添加
//        [self addSubview:plusBtn];
//        _plusBtn = plusBtn;
//
//    }
//    return _plusBtn;
//}
@end
