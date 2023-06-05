//
//  AEPreviewControllerWrapper.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/2.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEPreviewControllerWrapper.h"

@implementation AEPreviewControllerWrapper

- (instancetype)initWithPreviewController:(QLPreviewController *)previewController {
    self = [super init];
    if (self) {
        self.previewController = previewController;
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        return self.previewController;
    }
    return nil;
}
@end
