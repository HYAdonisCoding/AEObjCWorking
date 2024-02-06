//
//  AEConvertRectViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/2/14.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEConvertRectViewController.h"
#import "AEMutileLineTCell.h"
#import "AESubTableTCell.h"

@interface AEConvertRectViewController ()
@end

@implementation AEConvertRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configUI {
    [super configUI];
    
//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(0);
//    }];
}

- (void)configEvent {
    self.dataArray = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    [self.tableView registerClass:[AEMutileLineTCell class] forCellReuseIdentifier:NSStringFromClass([AEMutileLineTCell class])];
    [self.tableView registerClass:[AESubTableTCell class] forCellReuseIdentifier:NSStringFromClass([AESubTableTCell class])];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ((indexPath.row%2) != 0) {
        AESubTableTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AESubTableTCell class]) forIndexPath:indexPath];
        NSString *string = self.dataArray[indexPath.row];
        cell.title = string;
        cell.indexPath = indexPath;
        return cell;
    }
    AEMutileLineTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AEMutileLineTCell class]) forIndexPath:indexPath];
    NSString *string = self.dataArray[indexPath.row];
    cell.title = string;
    cell.indexPath = indexPath;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"展示了第 %ld 行, visibleCells: %@, indexPathsForVisibleRows: %@", (long)indexPath.row, [tableView visibleCells], [tableView indexPathsForVisibleRows]);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"即将展示第 %ld 行, visibleCells: %@, indexPathsForVisibleRows: %@", (long)indexPath.row, [tableView visibleCells], [tableView indexPathsForVisibleRows]);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AEHomeDidScorll" object:self userInfo:@{@"tableView": self.tableView}];
}

@end
