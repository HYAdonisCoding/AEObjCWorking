//
//  AESubTableTCell.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/2/14.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AESubTableTCell : UITableViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic,strong) NSIndexPath  *indexPath;
@end

NS_ASSUME_NONNULL_END
