//
//  AEAccount.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEAccount : AEBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;

@end

NS_ASSUME_NONNULL_END
