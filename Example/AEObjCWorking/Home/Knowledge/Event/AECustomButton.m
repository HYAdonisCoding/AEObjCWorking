//
//  AECustomButton.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AECustomButton.h"

@implementation AECustomButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.userInteractionEnabled ||
        [self isHidden] ||
        self.alpha <= 0.01) {
        return nil;
    }
    if ([self pointInside:point withEvent:event]) {
        /// 遍历当前对象的子视图
        __block UIView *hit = nil;
        [self.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           /// 坐标转换
            CGPoint vonvertPoint = [self convertPoint:point toView:obj];
            /// 调用子视图的hittest方法
            hit = [obj hitTest:vonvertPoint withEvent:event];
            /// 如果找到了接收时间的对象,则停止遍历
            if (hit) {
                *stop = YES;
            }
        }];
        if (hit) {
            return hit;
        } else {
            return self;
        }
    } else {
        return nil;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    
    CGFloat x2 = self.frame.size.width /2;
    CGFloat y2 = self.frame.size.height / 2;
    
    double dis = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    if (dis <= self.frame.size.width / 2) {
        return YES;
    }
    else {
        return NO;;
    }
}
@end
