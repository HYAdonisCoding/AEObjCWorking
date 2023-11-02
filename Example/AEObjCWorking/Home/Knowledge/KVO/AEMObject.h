//
//  AEMObject.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEMObject : AEBaseModel
/// 值
@property (nonatomic, assign) int value;
- (void)increase;

@end

NS_ASSUME_NONNULL_END
