//
//  AEWaveSegmentedControl.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/7/23.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AEWaveSegmentedControl.h"

@implementation AEWaveSegmentedControl

- (instancetype)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    if (self) {
        // 去除默认选中颜色及背景边框
        [self removeBorders];
    }
    return self;
}

- (void)removeBorders {
    self.tintColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.selectedSegmentTintColor = [UIColor clearColor];
    
    NSDictionary *normalAttributes = @{
        NSForegroundColorAttributeName: [UIColor blackColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16]
    };
    
    NSDictionary *selectedAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont systemFontOfSize:16]
    };
    
    [self setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    [self setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置波浪形状的属性
    CGFloat waveHeight = rect.size.height;
    CGFloat waveLength = rect.size.width / self.numberOfSegments;
    
    for (NSUInteger i = 0; i < self.numberOfSegments; i++) {
        CGRect segmentRect = [self frameForSegmentAtIndex:i];
        
        // 绘制波浪形状
        UIBezierPath *wavePath = [UIBezierPath bezierPath];
        [wavePath moveToPoint:CGPointMake(segmentRect.origin.x, segmentRect.size.height)];
        
        for (CGFloat x = segmentRect.origin.x; x <= CGRectGetMaxX(segmentRect); x += waveLength) {
            [wavePath addQuadCurveToPoint:CGPointMake(x + waveLength, segmentRect.size.height)
                             controlPoint:CGPointMake(x + waveLength / 2, segmentRect.size.height - waveHeight*2)];
        }
        
        [wavePath addLineToPoint:CGPointMake(segmentRect.origin.x, segmentRect.size.height)];
        
        // 设置波浪颜色
        UIColor *waveColor = (i == self.selectedSegmentIndex) ? [UIColor purpleColor] : [[UIColor purpleColor] colorWithAlphaComponent:0.5];
        [waveColor setFill];
        
        CGContextSaveGState(context);
        CGContextAddPath(context, wavePath.CGPath);
        CGContextClip(context);
        CGContextFillRect(context, segmentRect);
        CGContextRestoreGState(context);
    }
//    // 获取当前选中的索引
//    NSInteger selectedSegmentIndex = self.selectedSegmentIndex;
//    
//    if (selectedSegmentIndex != UISegmentedControlNoSegment) {
//        // 获取选中的段的框架
//        CGRect selectedSegmentFrame = [self frameForSegmentAtIndex:selectedSegmentIndex];
//        
//        // 绘制波浪形状
//        UIBezierPath *wavePath = [UIBezierPath bezierPath];
//        CGFloat waveHeight = selectedSegmentFrame.size.height; // 波浪高度
//        CGFloat waveLength = selectedSegmentFrame.size.width; // 波浪长度
//        
//        // 波浪起点
//        [wavePath moveToPoint:CGPointMake(selectedSegmentFrame.origin.x, selectedSegmentFrame.size.height)];
//        
//        // 绘制波浪
//        for (CGFloat x = selectedSegmentFrame.origin.x; x <= CGRectGetMaxX(selectedSegmentFrame); x += waveLength) {
//            [wavePath addQuadCurveToPoint:CGPointMake(x + waveLength, selectedSegmentFrame.size.height)
//                             controlPoint:CGPointMake(x + waveLength / 2, selectedSegmentFrame.size.height - waveHeight)];
//        }
//        
//        [[UIColor blueColor] setFill]; // 设置波浪颜色
//        [wavePath fill];
//    }
}

- (CGRect)frameForSegmentAtIndex:(NSUInteger)segment {
    CGFloat segmentWidth = self.frame.size.width / self.numberOfSegments;
    return CGRectMake(segmentWidth * segment, 0, segmentWidth, self.frame.size.height);
}
- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    [super setSelectedSegmentIndex:selectedSegmentIndex];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.layer addAnimation:[self waveAnimation] forKey:@"waveAnimation"];
        
    } completion:^(BOOL finished) {
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

- (CAKeyframeAnimation *)waveAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.0, @1.1, @1.0];
    animation.keyTimes = @[@0, @0.5, @1];
    animation.duration = 0.3;
    return animation;
}

@end
