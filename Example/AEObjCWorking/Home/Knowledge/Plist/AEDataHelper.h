//
//  AEDataHelper.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/8/3.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class AECardModel;

@interface AEDataHelper : AEBaseModel

+ (BOOL)saveUserInfoInDocument:(id)user;


+ (AECardModel *)getUserInfoInBundle;

+ (AECardModel *)getUserInfoInDocument;

@end

NS_ASSUME_NONNULL_END
