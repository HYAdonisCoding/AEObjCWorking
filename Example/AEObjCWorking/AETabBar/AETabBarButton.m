//
//  AETabBarButton.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/14.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AETabBarButton.h"

#define TabBarButtonRatio 0.6

@implementation AETabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置按钮图片居中显示
        self.imageView.contentMode = UIViewContentModeCenter;
        // 设置按钮标题居中显示
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 设置按钮的字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        // 设置标题颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮选中状态的文字颜色
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}


// 控制器图片的位置
// contentRect 就是当前按钮的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height * TabBarButtonRatio;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
// 控制器标题的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = self.frame.size.height * TabBarButtonRatio;
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height - titleY;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted
{
    // 禁止父类做一些复杂操作, 让按钮立刻就高亮
    //    [super setHighlighted:highlighted];
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    // 设置按钮显示的内容
    [self setTitle:item.title forState:UIControlStateNormal];
    // 设置默认状态的图片
    [self setImage:item.image forState:UIControlStateNormal];
    // 设置选中状态的图片
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}

@end
