//
//  AEMObject.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEMObject.h"

@implementation AEMObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _value = 0;
    }
    return self;
}
- (void)increase {
    //直接为成员变量赋值
    [self willChangeValueForKey:@"value"];
    _value += 1;
    [self didChangeValueForKey:@"value"];
}
@end
