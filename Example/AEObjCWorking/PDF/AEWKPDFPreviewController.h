//
//  AEWKPDFPreviewController.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/5.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEBaseViewController.h"
@class AEPDFModel;

NS_ASSUME_NONNULL_BEGIN

@interface AEWKPDFPreviewController : AEBaseViewController

- (instancetype)initAllPages:(NSArray<AEPDFModel *> *)pages
                 currentPage:(NSInteger)currentPage
             completeHandler:(nonnull DataUpdateBlock)completeHandler;
@end

NS_ASSUME_NONNULL_END
