//
//  AETextField.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/1/16.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AETextField.h"

@interface AETextField ()

@property (nonatomic, assign) CGFloat cursorHeight;

@end

@implementation AETextField

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCursorHeight:(CGFloat)cursorHeight {
    self = [super init];
    if (self) {
        self.cursorHeight = cursorHeight;
    }
    return self;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [super caretRectForPosition:position];
    if (self.cursorHeight > 1) {
        // 调整光标的高度
        originalRect.size.height = self.cursorHeight;
        originalRect.origin.y = (self.frame.size.height - self.cursorHeight) * 0.5;
    }

    return originalRect;
}


@end
