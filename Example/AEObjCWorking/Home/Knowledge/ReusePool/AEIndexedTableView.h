//
//  AEIndexedTableView.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol IndexedTableViewDataSource <NSObject>

// 获取一个tableview的字母索引条数据的方法
- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;


/// 选中了一个
/// @param section 组
/// @param title 标题
- (void)didSelectSectionAt:(NSInteger)section forTitle:(NSString *)title;

@end

@interface AEIndexedTableView : UITableView
/// 侧边栏代理
@property (nonatomic, weak) id<IndexedTableViewDataSource> indexedDataSource;
@end

NS_ASSUME_NONNULL_END
