//
//  AEUserCenter.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/17.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEUserCenter : AEBaseModel
- (id)AE_objectForKey:(NSString *)key;
- (void)AE_setObject:(id)obj forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
