//
//  AEMCObject.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/17.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEMCObject : AEBaseModel
+ (NSThread *)threadForDispatch;
@end

NS_ASSUME_NONNULL_END
