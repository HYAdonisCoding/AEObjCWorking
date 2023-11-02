//
//  AEPreviewPDFViewController.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/25.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class AEPDFModel;

@interface AEPreviewPDFViewController : AEBaseViewController

- (instancetype)initWithModel:(AEPDFModel *)model;

@end

NS_ASSUME_NONNULL_END
