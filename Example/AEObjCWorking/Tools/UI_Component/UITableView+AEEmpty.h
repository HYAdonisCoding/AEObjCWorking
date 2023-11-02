//
//  UITableView+AEEmpty.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/28.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (AEEmpty)
- (void)showMessage:(NSString *)message count:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END
