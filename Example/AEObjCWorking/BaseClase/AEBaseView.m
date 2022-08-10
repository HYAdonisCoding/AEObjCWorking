//
//  AEBaseView.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEBaseView.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation AEBaseView

    //滚动时不允许确认
- (BOOL)anySubViewScrolling:(UIView *)view {
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)view;
        
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    
    for (UIView *theSubView in view.subviews) {
        if ([self anySubViewScrolling:theSubView]) {
            return YES;
        }
    }
    return NO;
}

- (void)playSystemSound {
        //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  // 震动
        // 普通短震，3D Touch 中 Peek 震动反馈
    AudioServicesPlaySystemSound(1519);
        // 普通短震，3D Touch 中 Pop 震动反馈
        //AudioServicesPlaySystemSound(1520);
        // 连续三次短震
        //AudioServicesPlaySystemSound(1521);
    
    
        //    AudioServicesPlaySystemSound(1000);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
