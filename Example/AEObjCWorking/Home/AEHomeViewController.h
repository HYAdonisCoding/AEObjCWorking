//
//  AEHomeViewController.h
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEHomeViewController : AEBaseViewController<UITableViewDelegate, UITableViewDataSource>
/** 数据 */
@property (nonatomic, copy) NSArray *dataArray;
/** 页面 */
@property (nonatomic, copy) NSArray *controllerArray;
/** 列表 */
@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
