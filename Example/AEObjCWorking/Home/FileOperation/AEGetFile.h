//
//  AEGetFile.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/3/1.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"

typedef void(^PDFBlock)(UIImage *icon, NSData *data, NSString *path, NSString *directory);

NS_ASSUME_NONNULL_BEGIN

@interface AEGetFile : AEBaseModel
/// 选择PDF或图片
- (void)choosePdfAndPicture;

/// <#Description#>
@property (nonatomic, copy) PDFBlock block;

@end

NS_ASSUME_NONNULL_END
