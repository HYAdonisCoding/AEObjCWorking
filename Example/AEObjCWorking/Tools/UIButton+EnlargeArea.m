//
//  UIButton+EnlargeArea.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/10/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "UIButton+EnlargeArea.h"
#import <objc/runtime.h>
#import "UIImage+AEBlackAndWhite.h"

@implementation UIButton (EnlargeArea)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
      return [super hitTest:point withEvent:event];
    }
   return CGRectContainsPoint(rect, point) ? self : nil;
}

// MARK: - gray image
+ (void)ae_buttonSwizzldMethedWith:(BOOL)changeGray {
    if (changeGray == false) {
        return;
    }
    
    Class class = [self class];
    
    SEL originalSelector = @selector(setBackgroundColor:);
    SEL swizzledSelector = @selector(ae_setButtonBackgroundColor:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


- (void)ae_setButtonBackgroundColor:(UIColor *)color {
   UIColor * newColor = [self changeGrayWithColor:[UIColor redColor] Red:1.0 green:0.0 blue:0.0 alpha:1.0];
    [self ae_setButtonBackgroundColor:newColor];
    
}
- (UIColor *)changeGrayWithColor:(UIColor *)color Red:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    CGFloat gray = r * 0.299 +g * 0.587 + b * 0.114;
    UIColor *grayColor = [UIColor colorWithWhite:gray alpha:a];
    return  grayColor;
}

- (void)sd_setImageWithURL:(NSURL *)url forState:(UIControlState)state {
    [self sd_setImageWithURL:url forState:state completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self setImage:image.grayImage forState:(state)];
    }];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [super pointInside:point withEvent:event];
    
    // 获取bounds 实际大小
    CGRect bounds = self.bounds;
    if (self.clickArea) {
        CGFloat area = [self.clickArea floatValue];
//        CGFloat widthDelta = MAX(area * bounds.size.width - bounds.size.width, .0);
//        CGFloat heightDelta = MAX(area * bounds.size.height - bounds.size.height, .0);
//        //扩大bounds
//        bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
        
        // 使用 CGRectInset 扩展热区
        CGRect expandedBounds = CGRectInset(self.bounds, -area, -area);
            
        // 检查触摸点是否在扩展的热区内
        return CGRectContainsPoint(expandedBounds, point);

    }
    // 点击的点在新的bounds 中 就会返回YES
    return CGRectContainsPoint(bounds, point);
}

- (void)setClickArea:(NSString *)clickArea {
    objc_setAssociatedObject(self, @selector(clickArea), clickArea, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)clickArea {
    return objc_getAssociatedObject(self, @selector(clickArea));
}

@end
