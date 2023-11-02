//
//  AECardTransformLayout.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AECardTransformLayout.h"

@implementation AECardTransformLayout

- (instancetype)init {
    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}



#pragma mark - layout

//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return _layout.layoutType == AECardViewLayoutNormal ? [super shouldInvalidateLayoutForBoundsChange:newBounds] : YES;
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [super layoutAttributesForElementsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    return attributes;
}

#pragma mark - transform

//- (void)initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes layoutType:(AECardViewLayoutType)layoutType {
//    switch (layoutType) {
//        case AECardViewLayoutLinear:
//            [self applyLinearTransformToAttributes:attributes scale:_layout.minimumScale alpha:_layout.minimumAlpha];
//            break;
//        case AECardViewLayoutCoverflow:
//        {
//            [self applyCoverflowTransformToAttributes:attributes angle:_layout.maximumAngle alpha:_layout.minimumAlpha];
//            break;
//        }
//        default:
//            break;
//    }
//}

//- (void)applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes layoutType:(AECardViewLayoutType)layoutType {
//    switch (layoutType) {
//        case AECardViewLayoutLinear:
//            [self applyLinearTransformToAttributes:attributes];
//            break;
//        case AECardViewLayoutCoverflow:
//            [self applyCoverflowTransformToAttributes:attributes];
//            break;
//        default:
//            break;
//    }
//}

#pragma mark - LinearTransform

//- (void)applyLinearTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes {
//    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
//    if (collectionViewWidth <= 0) {
//        return;
//    }
//    CGFloat centetX = self.collectionView.contentOffset.x + collectionViewWidth/2;
//    CGFloat delta = ABS(attributes.center.x - centetX);
//    CGFloat scale = MAX(1 - delta/collectionViewWidth*_layout.rateOfChange, _layout.minimumScale);
//    CGFloat alpha = MAX(1 - delta/collectionViewWidth, _layout.minimumAlpha);
//    [self applyLinearTransformToAttributes:attributes scale:scale alpha:alpha];
//}

//- (void)applyLinearTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes scale:(CGFloat)scale alpha:(CGFloat)alpha {
//    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
//    if (_layout.adjustSpacingWhenScroling) {
//        TYTransformLayoutItemDirection direction = [self directionWithCenterX:attributes.center.x];
//        CGFloat translate = 0;
//        switch (direction) {
//            case TYTransformLayoutItemLeft:
//                translate = 1.15 * attributes.size.width*(1-scale)/2;
//                break;
//            case TYTransformLayoutItemRight:
//                translate = -1.15 * attributes.size.width*(1-scale)/2;
//                break;
//            default:
//                // center
//                scale = 1.0;
//                alpha = 1.0;
//                break;
//        }
//        transform = CGAffineTransformTranslate(transform,translate, 0);
//    }
//    attributes.transform = transform;
//    attributes.alpha = alpha;
//}

#pragma mark - CoverflowTransform

//- (void)applyCoverflowTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes{
//    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
//    if (collectionViewWidth <= 0) {
//        return;
//    }
//    CGFloat centetX = self.collectionView.contentOffset.x + collectionViewWidth/2;
//    CGFloat delta = ABS(attributes.center.x - centetX);
//    CGFloat angle = MIN(delta/collectionViewWidth*(1-_layout.rateOfChange), _layout.maximumAngle);
//    CGFloat alpha = MAX(1 - delta/collectionViewWidth, _layout.minimumAlpha);
//    [self applyCoverflowTransformToAttributes:attributes angle:angle alpha:alpha];
//}

//- (void)applyCoverflowTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes angle:(CGFloat)angle alpha:(CGFloat)alpha {
//    TYTransformLayoutItemDirection direction = [self directionWithCenterX:attributes.center.x];
//    CATransform3D transform3D = CATransform3DIdentity;
//    transform3D.m34 = -0.002;
//    CGFloat translate = 0;
//    switch (direction) {
//        case TYTransformLayoutItemLeft:
//            translate = (1-cos(angle*1.2*M_PI))*attributes.size.width;
//            break;
//        case TYTransformLayoutItemRight:
//            translate = -(1-cos(angle*1.2*M_PI))*attributes.size.width;
//            angle = -angle;
//            break;
//        default:
//            // center
//            angle = 0;
//            alpha = 1;
//            break;
//    }
//
//    transform3D = CATransform3DRotate(transform3D, M_PI*angle, 0, 1, 0);
//    if (_layout.adjustSpacingWhenScroling) {
//        transform3D = CATransform3DTranslate(transform3D, translate, 0, 0);
//    }
//    attributes.transform3D = transform3D;
//    attributes.alpha = alpha;
//
//}

@end
