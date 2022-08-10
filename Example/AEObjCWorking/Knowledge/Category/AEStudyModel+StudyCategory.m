//
//  AEStudyModel+StudyCategory.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/2/24.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEStudyModel+StudyCategory.h"

@implementation AEStudyModel (StudyCategory)

- (void)study:(NSString *)content {
    NSLog(@"继续研究%@", content);
}

- (void)studyHardWith:(NSString *)name {
    NSLog(@"跟着%@一起努力", name);
}

+ (NSString *)standard {
    return @"不忘初心 牢记使命";
}
@end
