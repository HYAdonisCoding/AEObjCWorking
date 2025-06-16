//
//  AERoundedProgressView.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/9/26.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AERoundedProgressView.h"

@interface AERoundedProgressView ()
@property (nonatomic, strong) UIView *progressBarView;  // 用于显示进度的视图

@end

@implementation AERoundedProgressView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupProgressBarWithFrame:frame];
    }
    return self;
}

// 初始化进度条样式
- (void)setupProgressBarWithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor lightGrayColor];   // 设置进度条的背景颜色
    self.layer.cornerRadius = 0;  // 确保父视图没有圆角
    self.clipsToBounds = YES;     // 裁剪子视图超出部分
    
    // 创建显示进度的子视图
    self.progressBarView = [[UIView alloc] initWithFrame:frame];
    self.progressBarView.backgroundColor = [UIColor blueColor];  // 进度条颜色
    [self addSubview:self.progressBarView];
    
    self.progress = 0.0;  // 默认进度
}

// 更新进度
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self updateProgressBar];
}

// 动态更新进度条的宽度和右侧圆角遮罩
- (void)updateProgressBar {
    CGFloat progressViewWidth = self.bounds.size.width;
    CGFloat progressViewHeight = self.bounds.size.height;
    
    // 根据当前进度更新进度条的宽度
    CGFloat progressWidth = progressViewWidth * self.progress;
    self.progressBarView.frame = CGRectMake(0, 0, progressWidth, progressViewHeight);
    
    // 确保右侧有圆角，左侧保持直角
    UIRectCorner corners = (self.progress < 1.0) ? (UIRectCornerTopRight | UIRectCornerBottomRight) : UIRectCornerAllCorners;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.progressBarView.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(progressViewHeight / 2, progressViewHeight / 2)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.progressBarView.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // 应用遮罩
    self.progressBarView.layer.mask = maskLayer;
}

@end
