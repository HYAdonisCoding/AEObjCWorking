//
//  UIButton+EnlargeArea.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/10/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeArea)
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end

NS_ASSUME_NONNULL_END
