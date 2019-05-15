//
//  AEDynamicLabel.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/5/10.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEDynamicLabel.h"
#import "../UI_Component/NSString+AELabelWidthAndHeight.h"
#import "../UI_Component/UIFont+AEFonts.h"
#import "../UI_Component/UIView+AEGlowView.h"

static NSString *animationViewPosition = @"animationViewPosition";

@interface AEDynamicLabel () <CAAnimationDelegate> {
    CGFloat _width;
    CGFloat _height;
    
    CGFloat _animationViewWidth;
    CGFloat _animationViewHeight;
    
    BOOL    _stoped;
    UIView *_contentView;
}

@property (nonatomic, strong) UIView *animationView;

@end

@implementation AEDynamicLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _width = frame.size.width;
        _height = frame.size.height;
        
        self.speed = 1.f;
        self.direction = AEDynamicDirectionLeft;
        self.layer .masksToBounds = YES;
        self.animationView = [[UIView alloc] initWithFrame:CGRectMake(_width, 0, _width, _height)];
        [self addSubview:self.animationView];
    }
    
    return self;
}

- (void)addContentView:(UIView *)view {
    [_contentView removeFromSuperview];
    
    view.frame = view.bounds;
    _contentView = view;
    self.animationView.frame = view.bounds;
    [self.animationView addSubview:_contentView];
    
    _animationViewWidth = self.animationView.frame.size.width;
    _animationViewHeight = self.animationView.frame.size.height;
}

- (void)addText:(NSString *)text {
    NSString *string = [NSString stringWithFormat:@" %@ ", text];
    CGFloat   width  = [string widthWithStringAttribute:@{NSFontAttributeName : [UIFont HeitiSCWithFontSize:14.f]}];
    UILabel  *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    label.font       = [UIFont HeitiSCWithFontSize:14.f];
    label.text       = string;
    label.textColor  = self.;
    
    label.glowRadius            = @(2.f);
    label.glowOpacity           = @(1.f);
    label.glowColor             = [textColor colorWithAlphaComponent:0.86];
    label.glowDuration          = @(1.f);
    label.hideDuration          = @(3.f);
    label.glowAnimationDuration = @(2.f);
    [label createGlowLayer];
    [label insertGlowLayer];
    [label startGlowLoop];
}

- (void)startAnimation {
    [self.animationView.layer removeAnimationForKey:animationViewPosition];
    _stoped = NO;
    
    CGPoint pointRightCenter = CGPointMake(_width + _animationViewWidth / 2.f, _animationViewHeight / 2.f);
    CGPoint pointLeftCenter  = CGPointMake(-_animationViewHeight / 2.f, _animationViewHeight / 2.f);
    CGPoint fromPoint = self.direction == AEDynamicDirectionLeft ? pointRightCenter : pointLeftCenter;
    CGPoint toPoint = self.direction == AEDynamicDirectionLeft ? pointLeftCenter : pointRightCenter;
    
    self.animationView.center = fromPoint;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    [movePath addLineToPoint:toPoint];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = movePath.CGPath;
    moveAnimation.removedOnCompletion = YES;
    moveAnimation.duration = _animationViewWidth / 30.f * (1 / self.speed);
    moveAnimation.delegate = self;
    [self.animationView.layer addAnimation:moveAnimation forKey:animationViewPosition];
}

- (void)stopAnimation {
    _stoped = YES;
    [self.animationView.layer removeAnimationForKey:animationViewPosition];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.delegate && [self.delegate respondsToSelector:@selector(drawDynamicLabel:animationDidStopFinished:)]) {
        [self.delegate drawDynamicLabel:self animationDidStopFinished:flag];
    }
    
    if (flag && !_stoped) {
        [self stopAnimation];
    }
}

- (void)pauseAnimation {
    [self pauseLayer:self.animationView.layer];
}

- (void)resumeAnimation {
    [self resumeLayer:self.animationView.layer];
}

- (void)pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = layer.timeOffset;
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
