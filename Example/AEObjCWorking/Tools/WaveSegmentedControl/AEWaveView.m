//
//  AEWaveView.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/7/23.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AEWaveView.h"

@implementation AEWaveView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.waveHeight = 20.0;
        self.waveFrequency = 1.5;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    [wavePath moveToPoint:CGPointMake(0, height / 2)];
    
    for (CGFloat x = 0; x <= width; x++) {
        CGFloat y = self.waveHeight * sinf(self.waveFrequency * (x / width) * M_PI * 2) + height / 2;
        [wavePath addLineToPoint:CGPointMake(x, y)];
    }
    
    [wavePath addLineToPoint:CGPointMake(width, height)];
    [wavePath addLineToPoint:CGPointMake(0, height)];
    [wavePath closePath];
    
    [[UIColor blueColor] setFill];
    [wavePath fill];
}

- (void)startAnimating {
    [self setNeedsDisplay];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.frame;
        frame.origin.y -= self.waveHeight;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = self.frame;
            frame.origin.y += self.waveHeight;
            self.frame = frame;
        } completion:nil];
    }];
}


@end
