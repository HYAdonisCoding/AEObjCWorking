//
//  NSTimer+AEWeakTimer.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "NSTimer+AEWeakTimer.h"

@interface TimerWeakObject : NSObject
@property (nonatomic, weak) id target;
 
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;

- (void)fire:(NSTimer *)timer;
@end

@implementation TimerWeakObject

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
            [self.target performSelector:self.selector withObject:timer.userInfo];
        }
    } else {
        NSLog(@"原对象释放了");
        [self.timer invalidate];
    }
}

@end

@implementation NSTimer (AEWeakTimer)
- (void)dealloc {
    NSLog(@"NSTimer对象释放了");

}
+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    TimerWeakObject *obj = [[TimerWeakObject alloc] init];
    obj.target = aTarget;
    obj.selector = aSelector;
    obj.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:obj selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
    return obj.timer;
}
@end
