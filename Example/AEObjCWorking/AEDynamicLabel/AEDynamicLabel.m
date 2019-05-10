//
//  AEDynamicLabel.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/5/10.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEDynamicLabel.h"

static CGFloat space = 1;

@interface AEDynamicLabel () <CAAnimationDelegate>

    /// label
@property (nonatomic, strong) UILabel *label;

@end

@implementation AEDynamicLabel

+ (instancetype)sharedWithText:(NSString *)text speed:(double)speed frame:(CGRect)frame {
    AEDynamicLabel *aeLabel = [[AEDynamicLabel alloc] initWithFrame:frame];
    aeLabel.speed = speed;
    aeLabel.text = text;
    return aeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeInterface];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self makeInterface];
    }
    return self;
}



- (void)makeInterface {
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    [self.label sizeToFit];
    self.label.textColor = [UIColor purpleColor];
    self.label.backgroundColor = [UIColor clearColor];
    [self addSubview:self.label];

    
    //给内容view的layer添加一个mask层, 并且设置其范围为整个view的bounds, 这样就让超出view的内容不会显示出来
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.mask = maskLayer;
    
    //给label添加动画
    CAKeyframeAnimation* keyFrame = [CAKeyframeAnimation animation];
    keyFrame.keyPath = @"transform.translation.x";
    keyFrame.values = @[@(0), @(-space), @(0)];
    keyFrame.repeatCount = NSIntegerMax;
    keyFrame.duration = self.speed * self.text.length;
    keyFrame.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.5 :0.5]];
    keyFrame.delegate = self;
    [self.label.layer addAnimation:keyFrame forKey:nil];
}


- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

@end
