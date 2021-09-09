//
//  AEAddressTCell.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AddressGray  [UIColor colorWithString:@"#333333"]


NS_ASSUME_NONNULL_BEGIN

@interface AEAddressTCell : UITableViewCell

@property (strong, nonatomic) UILabel *nameLabel;
//@property (strong, nonatomic) UIImageView *imageIcon;
@end

NS_ASSUME_NONNULL_END
