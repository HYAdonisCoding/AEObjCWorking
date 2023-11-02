//
//  AEProfessionSearchTCell.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEProfessionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEProfessionSearchTCell : UITableViewCell

/// 数据
@property (nonatomic, strong) AEProfessionSearchModel *searchModel;

@end

NS_ASSUME_NONNULL_END
