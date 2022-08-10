//
//  NSString+AELabelWidthAndHeight.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/5/14.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AELabelWidthAndHeight)
#pragma mark - StringAttribute.

/**
 *  Get the string's height with the fixed width.
 *
 *  @param attribute String's attribute, eg. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 *  @param width     Fixed width.
 *
 *  @return String's height.
 */
- (CGFloat)heightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute fixedWidth:(CGFloat)width;

/**
 *  Get the string's width.
 *
 *  @param attribute String's attribute, eg. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 *
 *  @return String's width.
 */
- (CGFloat)widthWithStringAttribute:(NSDictionary <NSString *, id> *)attribute;

/**
 *  Get a line of text height.
 *
 *  @param attribute String's attribute, eg. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 *
 *  @return String's width.
 */
+ (CGFloat)oneLineOfTextHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute;

#pragma mark - Font.

/**
 *  Get the string's height with the fixed width.
 *
 *  @param font  String's font.
 *  @param width Fixed width.
 *
 *  @return String's height.
 */
- (CGFloat)heightWithStringFont:(UIFont *)font fixedWidth:(CGFloat)width;

/**
 *  Get the string's width.
 *
 *  @param font  String's font.
 *
 *  @return String's width.
 */
- (CGFloat)widthWithStringFont:(UIFont *)font;

/**
 *  Get a line of text height.
 *
 *  @param font  String's font.
 *
 *  @return String's width.
 */
+ (CGFloat)oneLineOfTextHeightWithStringFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
