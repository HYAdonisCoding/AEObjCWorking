//
//  AECardView.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AECardModel;

NS_ASSUME_NONNULL_BEGIN

@interface AECardView : UIView
/// 数组
@property (nonatomic, copy) NSArray<AECardModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
