//
//  AECardViewCCell.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AECardViewCCell : UICollectionViewCell

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;

/// 详细
@property (nonatomic, strong) UILabel *detailLabel;

@end

NS_ASSUME_NONNULL_END
