//
//  AEPDFModel.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/2.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEPDFModel.h"

@implementation AEPDFModel
- (instancetype)initWithName:(NSString *)name
                        path:(NSString *)path
                      readed:(BOOL)readed {
    self = [super init];
    if (self) {
        self.name = name;
        self.path = path;
        self.readed = readed;
    }
    
    return self;
}
@end
