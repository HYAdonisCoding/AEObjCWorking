//
//  AEPopSheetController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEPopSheetController.h"

@interface AEPopSheetController ()<UITableViewDelegate, UITableViewDataSource>

/** 表格 */
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation AEPopSheetController

- (instancetype)initWithSourceView:(UIView *)sourceView datas:(NSArray *)datas contentWidth:(CGFloat)contentWidth andDirection:(UIPopoverArrowDirection)direction completionHandler:(AEPopSheetBlock)completionHandler {
    CGSize size = CGSizeMake(contentWidth, 40*datas.count);
    CGRect rect = CGRectMake(CGRectGetMidX(sourceView.bounds), CGRectGetMaxY(sourceView.bounds), 0, 5);
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    /// 防止显示范围不够导致异常
    if (direction == UIPopoverArrowDirectionUp && (height - CGRectGetMaxY(sourceView.frame)) < size.height && height != CGRectGetMaxY(sourceView.frame)) {
        direction = UIPopoverArrowDirectionDown;
        rect = CGRectMake(CGRectGetMidX(sourceView.bounds), CGRectGetMinY(sourceView.bounds), 0, -5);
    } else if (direction == UIPopoverArrowDirectionDown && (height - CGRectGetMaxY(sourceView.frame)) > size.height && height != CGRectGetMaxY(sourceView.frame)) {
        direction = UIPopoverArrowDirectionUp;
        rect = CGRectMake(CGRectGetMidX(sourceView.bounds), CGRectGetMaxY(sourceView.bounds), 0, 5);
    } else if (direction == UIPopoverArrowDirectionRight && (width - CGRectGetMaxX(sourceView.frame)) > size.width && width != CGRectGetMaxX(sourceView.frame)) {
        direction = UIPopoverArrowDirectionLeft;
        rect = CGRectMake(CGRectGetMaxX(sourceView.bounds), CGRectGetMidY(sourceView.bounds), 5, 0);
    } else if (direction == UIPopoverArrowDirectionLeft && (width - CGRectGetMaxX(sourceView.frame)) < size.width && width != CGRectGetMaxX(sourceView.frame)) {
        direction = UIPopoverArrowDirectionRight;
        rect = CGRectMake(CGRectGetMinX(sourceView.bounds), CGRectGetMidY(sourceView.bounds), -5, 0);
    }

    switch (direction) {
        case UIPopoverArrowDirectionUp:
        {
            rect = CGRectMake(CGRectGetMidX(sourceView.bounds), CGRectGetMaxY(sourceView.bounds), 0, 5);
        }
            break;
        case UIPopoverArrowDirectionDown:
        {
            rect = CGRectMake(CGRectGetMidX(sourceView.bounds), CGRectGetMinY(sourceView.bounds), 0, -5);
        }
        case UIPopoverArrowDirectionLeft:
            {
                rect = CGRectMake(CGRectGetMaxX(sourceView.bounds), CGRectGetMidY(sourceView.bounds), 5, 0);
            }
            break;
        case UIPopoverArrowDirectionRight:
            {
                rect = CGRectMake(CGRectGetMinX(sourceView.bounds), CGRectGetMidY(sourceView.bounds), -5, 0);
            }
            break;
        default:
            break;
    }
    self = [super initWithSourceView:sourceView bySourceRect:rect andContentSize:size andDirection:direction];
    if (self) {
        self.dataArray = datas;
    }
    return self;
}

#pragma mark -- Lazy Load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}
#pragma mark -- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor systemTealColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    NSInteger row = indexPath.row;
    
    cell.textLabel.text = self.dataArray[row];
//    cell.imageView.image = [UIImage imageNamed:self.dataArray[row].icon];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertController:selectRowNumber:)]) {
        
        [self.delegate alertController:self selectRowNumber:indexPath.row];
    }
    
    if (self.block) {
        self.block(indexPath.row, self.dataArray[indexPath.row]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    self.view.backgroundColor = [UIColor grayColor];
}
@end
