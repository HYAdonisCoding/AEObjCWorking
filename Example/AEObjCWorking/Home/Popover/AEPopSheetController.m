//
//  AEPopSheetController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEPopSheetController.h"
/// 行高
static CGFloat const rowHeight = 40;
/// 间隙
static CGFloat const space = 2;

@interface AEPopSheetController ()<UITableViewDelegate, UITableViewDataSource>

/** 表格 */
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation AEPopSheetController

- (instancetype)initWithSourceView:(UIView *)sourceView datas:(NSArray *)datas contentWidth:(CGFloat)contentWidth andDirection:(UIPopoverArrowDirection)direction completionHandler:(AEPopSheetBlock)completionHandler {
    CGSize size = CGSizeMake(contentWidth, rowHeight*datas.count);
    CGRect rect = CGRectMake(CGRectGetMidX(sourceView.bounds), CGRectGetMaxY(sourceView.bounds), 0, space);
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if (size.height > height - 88) {
        size.height = height - 88;
    }
    /// 上下左右距离
    CGFloat up = height - CGRectGetMinY(sourceView.frame), down = height - CGRectGetMaxY(sourceView.frame), left = width - CGRectGetMinX(sourceView.frame), right = width - CGRectGetMaxX(sourceView.frame);
    /// 防止显示范围不够导致异常
    if (direction == UIPopoverArrowDirectionUp) {
        if (down < size.height && height != CGRectGetMaxY(sourceView.frame)) {
            direction = UIPopoverArrowDirectionDown;
            if (up < size.height) {
                if (right > size.width) {
                    direction = UIPopoverArrowDirectionLeft;
                } else {
                    direction = UIPopoverArrowDirectionRight;
                }
            }

        }
    } else if (direction == UIPopoverArrowDirectionDown) {
        if (up > size.height && height != CGRectGetMaxY(sourceView.frame)) {
            direction = UIPopoverArrowDirectionUp;
            if (down < size.height) {
                if (right > size.width) {
                    direction = UIPopoverArrowDirectionLeft;
                } else {
                    direction = UIPopoverArrowDirectionRight;
                }
            }
        } else if (down < size.height && height != CGRectGetMaxY(sourceView.frame)) {
            if (down < size.height) {
                if (right > size.width) {
                    direction = UIPopoverArrowDirectionLeft;
                } else {
                    direction = UIPopoverArrowDirectionRight;
                }
            }
        }
    } else if (direction == UIPopoverArrowDirectionRight && right > size.width && width != CGRectGetMaxX(sourceView.frame)) {
        direction = UIPopoverArrowDirectionLeft;    } else if (direction == UIPopoverArrowDirectionLeft && left < size.width && width != CGRectGetMaxX(sourceView.frame)) {
        direction = UIPopoverArrowDirectionRight;
    }  else if (direction == UIPopoverArrowDirectionRight && right > size.width && width != CGRectGetMaxX(sourceView.frame)) {
            direction = UIPopoverArrowDirectionLeft;    } else if (direction == UIPopoverArrowDirectionLeft && left < size.width && width != CGRectGetMaxX(sourceView.frame)) {
                direction = UIPopoverArrowDirectionRight;
    }
            
    switch (direction) {
        case UIPopoverArrowDirectionUp:
        {
            rect = CGRectMake(CGRectGetMidX(sourceView.bounds), CGRectGetMaxY(sourceView.bounds), 0, space);
        }
            break;
        case UIPopoverArrowDirectionDown:
        {
            rect = CGRectMake(CGRectGetMidX(sourceView.bounds), CGRectGetMinY(sourceView.bounds), 0, -space);
        }
        case UIPopoverArrowDirectionLeft:
            {
                rect = CGRectMake(CGRectGetMaxX(sourceView.bounds), CGRectGetMidY(sourceView.bounds), space, 0);
            }
            break;
        case UIPopoverArrowDirectionRight:
            {
                rect = CGRectMake(CGRectGetMinX(sourceView.bounds), CGRectGetMidY(sourceView.bounds), -space, 0);
            }
            break;
        default:
            break;
    }
    self = [super initWithSourceView:sourceView bySourceRect:rect andContentSize:size andDirection:direction];
    if (self) {
        self.dataArray = datas;
        self.block = completionHandler;
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
        _tableView.backgroundColor = self.backViewColor ?: [UIColor whiteColor];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.direction == UIPopoverArrowDirectionUp) {
                make.top.mas_equalTo(13);
            } else {
                make.top.mas_equalTo(0);
            }
            make.left.right.bottom.mas_equalTo(0);
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
    cell.backgroundColor = self.backViewColor ?: [UIColor whiteColor];
    cell.textLabel.textColor = self.textColor ?: [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    NSInteger row = indexPath.row;
    
    cell.textLabel.text = self.dataArray[row];
//    cell.imageView.image = [UIImage imageNamed:self.dataArray[row].icon];
    cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
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
    return rowHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    self.tableView.scrollEnabled = self.scrollable;
    self.view.backgroundColor =  self.backViewColor ?: [UIColor whiteColor];
}
@end
