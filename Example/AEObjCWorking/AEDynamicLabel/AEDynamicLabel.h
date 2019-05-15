//
//  AEDynamicLabel.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/5/10.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEBaseView.h"

@class AEDynamicLabel;

typedef NS_ENUM(NSUInteger, AEDynamicDirection) {
    AEDynamicDirectionLeft,
    AEDynamicDirectionRight,
};

@protocol AEDynamicLabelDelegate <NSObject>
@optional
- (void)drawDynamicLabel:(AEDynamicLabel *_Nullable)dynamicLabel animationDidStopFinished:(BOOL)finished;


@end
NS_ASSUME_NONNULL_BEGIN

@interface AEDynamicLabel : AEBaseView
    /// 代理
@property (nonatomic, weak) id<AEDynamicLabelDelegate> delegate;

//+ (instancetype)sharedWithText:(NSString *)text speed:(double)speed frame:(CGRect)frame;
//
//    /// 文字
//@property (nonatomic, copy) NSString *text;

/**
 *  Marquee's speed.
 */
@property (nonatomic) CGFloat                    speed;

/**
 *  Marquee's direction.
 */
@property (nonatomic) AEDynamicDirection  direction;

/**
 *  Add the contentView to show.
 *
 *  @param view The ContentView.
 */
- (void)addContentView:(UIView *)view;

/**
 *  Start the animation.
 */
- (void)startAnimation;

/**
 *  Stop the animation.
 */
- (void)stopAnimation;

/**
 *  Pause the animation.
 */
- (void)pauseAnimation;

/**
 *  Resume the animation.
 */
- (void)resumeAnimation;


#pragma mark - 自定义设置

/// 文字颜色 
@property (nonatomic, strong) <#TYPE#> *<#name#>;

@end

NS_ASSUME_NONNULL_END
