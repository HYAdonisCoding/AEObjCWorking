//
//  AEStudyModel.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/2/24.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEStudyModel.h"

@interface AEStudyModel ()


//@property (nonatomic, retain) id obj;

@end

@implementation AEStudyModel

//- (void)setObj:(id)obj {
//    if (_obj != obj) {
//        [_obj release];
//        _obj = [obj retain];
//    }
//}

- (void)study:(NSString *)content {
    NSLog(@"%@", content);
}
@end
