//
//  AECustomTitleView.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/3/10.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AECustomTitleView : UIView

+ (instancetype)defaultTitleViewWith:(NSString *)title imageName:(NSString *)imageName tapAction:(NSString *(^)(id data))tapAction;
+ (instancetype)defaultTitleViewWith:(NSString *)title imageName:(NSString *)imageName completeHandler:(void(^)(AECustomTitleView* view, id data))completeHandler;

- (void)updateTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
