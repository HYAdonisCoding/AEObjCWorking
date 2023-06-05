//
//  AESubTableTCell.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/2/14.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AESubTableTCell.h"

static const CGFloat cellHeight = 80.0f;
static const NSInteger cellNumber = 5;

#import "AESignalTCell.h"

@interface AESubTableTCell()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageIcon;

/// <#Description#>
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation AESubTableTCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor brownColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(19);
        }];
        
        self.imageIcon = [[UIImageView alloc] init];
        self.imageIcon.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imageIcon];
        [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(80);
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.right.mas_equalTo(self.titleLabel.mas_right);
        }];
        
        [self.tableView registerClass:[AESignalTCell class] forCellReuseIdentifier:NSStringFromClass([AESignalTCell class])];
    }
    
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = footerView;
        
        //隐藏自带的分割线
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 设置tableView背景色
        _tableView.backgroundColor = [UIColor whiteColor];
        //估算高度
        _tableView.estimatedRowHeight = 150;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageIcon.mas_bottom).offset(10);
            make.height.mas_equalTo(cellHeight * cellNumber);
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.right.mas_equalTo(self.titleLabel.mas_right);
            make.bottom.mas_equalTo(-10);
        }];
    }
    return _tableView;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AESignalTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AESignalTCell class]) forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"%02ld", (long)indexPath.row];

    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
