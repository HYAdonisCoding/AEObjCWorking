//
//  AEHitView.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/9/6.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEHitView.h"
#import "UIButton+EnlargeArea.h"

//static NSNumber *area = [NSNumber numberWithFloat:10.0f];
@implementation AEHitView

- (instancetype)init {
    self = [super init];
    if (self) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:button];
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
            make.center.mas_equalTo(0);
        }];
        [button setBackgroundColor:[UIColor cyanColor]];
        button.clickArea = @"100";
    }
    return self;
}

- (void)btnClicked:(UIButton *)sender {
    NSLog(@"%@--%@", [self class], @"点击了");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.userInteractionEnabled ||
        [self isHidden] ||
        self.alpha <= 0.01) {
        return nil;
    }
    for (UIView *obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            CGFloat expandedInset = -100; // 指定要扩展的热区大小
            CGRect b = obj.bounds;
            CGRect expandedBounds = CGRectInset(b, expandedInset, expandedInset);
            if (CGRectContainsPoint(expandedBounds, point)) {
                // 触摸点在扩展的热区内，可以响应事件
                return obj;
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

@end
