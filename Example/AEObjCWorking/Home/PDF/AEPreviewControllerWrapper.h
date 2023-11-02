//
//  AEPreviewControllerWrapper.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/2.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEPreviewControllerWrapper : NSObject

@property (nonatomic, strong) QLPreviewController *previewController;

- (instancetype)initWithPreviewController:(QLPreviewController *)previewController;
- (UIViewController *)viewControllerAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
