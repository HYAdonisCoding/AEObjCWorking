//
//  AEStudyModel+StudyCategory.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/2/24.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEStudyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEStudyModel (StudyCategory)
- (void)study:(NSString *)content;
- (void)studyHardWith:(NSString *)name;
+ (NSString *)standard;
@end

NS_ASSUME_NONNULL_END
