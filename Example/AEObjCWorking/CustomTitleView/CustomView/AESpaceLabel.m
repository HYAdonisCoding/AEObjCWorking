//
//  AESpaceLabel.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/14.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AESpaceLabel.h"

@implementation AESpaceLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {5, 5, 5, 5};
    if (self.insets.left != 0 ||
        self.insets.right != 0 ||
        self.insets.top != 0 ||
        self.insets.bottom != 0) {
        insets = self.insets;
    }
    [super drawTextInRect: UIEdgeInsetsInsetRect(rect, insets)];
}


@end
