//
//  AEPopSheetController.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEPopoverController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AEPopSheetBlock)(NSInteger index, id object);

@protocol AEPopSheetDelegate <NSObject>

- (void)alertController:(UIViewController *)alertController selectRowNumber:(NSInteger)number;

@end



@interface AEPopSheetController : AEPopoverController

/** 代理 */
@property (nonatomic, weak) id<AEPopSheetDelegate> delegate;

/** 数据源 */
@property (nonatomic, strong) NSArray *dataArray;

/// 回调
@property (nonatomic, copy) AEPopSheetBlock block;

@end

NS_ASSUME_NONNULL_END
