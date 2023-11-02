//
//  AECardTransformLayout.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AECardViewLayoutType) {
    AECardViewLayoutNormal,
    AECardViewLayoutLinear,
    AECardViewLayoutCoverflow,
};

@interface AECardTransformLayout : UICollectionViewFlowLayout

@end

NS_ASSUME_NONNULL_END
