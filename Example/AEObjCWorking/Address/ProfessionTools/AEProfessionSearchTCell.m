//
//  AEProfessionSearchTCell.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEProfessionSearchTCell.h"

@interface AEProfessionSearchTCell ()
@property (nonatomic, strong) UILabel *selectFirstLabel;

@property (nonatomic, strong) UILabel *selectSecondaryLabel;
/// 图标
@property (nonatomic, strong) UIImageView *iconImageView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation AEProfessionSearchTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self selectFirstLabel];
        [self selectSecondaryLabel];
        [self iconImageView];
        [self titleLabel];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSearchModel:(AEProfessionSearchModel *)searchModel {
    _searchModel = searchModel;
    self.selectFirstLabel.text = searchModel.profession1;
    self.selectSecondaryLabel.text = searchModel.profession2;
    self.titleLabel.text = searchModel.profession3;
    NSRange range = NSRangeFromString(searchModel.mark);
    if ([searchModel.profession3 substringWithRange:range].length > 0) {
        
        
        NSMutableAttributedString * aStr = [[NSMutableAttributedString alloc]initWithString: searchModel.profession3];
        [aStr addAttributes:
         @{NSForegroundColorAttributeName:[UIColor colorWithString:@"#666666"]} range:NSMakeRange(0, searchModel.profession3.length)];
        [aStr addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:16]} range:NSMakeRange(0, searchModel.profession3.length)];
        
        [aStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithString:@"#FE8E0A"]} range:range];
        self.titleLabel.attributedText = aStr;
    }
}

- (UILabel *)selectFirstLabel {
    if (!_selectFirstLabel) {
        _selectFirstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _selectFirstLabel.textAlignment = NSTextAlignmentLeft;
        _selectFirstLabel.textColor = [UIColor colorWithString:@"#999999"];
        _selectFirstLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_selectFirstLabel];
        [_selectFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(27);
        }];
    }
    return _selectFirstLabel;
}
- (UILabel *)selectSecondaryLabel {
    if (!_selectSecondaryLabel) {
        _selectSecondaryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _selectSecondaryLabel.textAlignment = NSTextAlignmentLeft;
        _selectSecondaryLabel.textColor = [UIColor colorWithString:@"#999999"];
        _selectSecondaryLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_selectSecondaryLabel];
        [_selectSecondaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.selectFirstLabel.mas_bottom).offset(1);
            make.right.mas_equalTo(-15);
            make.left.mas_equalTo(35);
            make.height.mas_equalTo(27);
        }];
    }
    return _selectSecondaryLabel;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-级连"]];
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectFirstLabel.mas_left);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(16);
            make.centerY.mas_equalTo(self.selectSecondaryLabel.mas_centerY);
        }];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorWithString:@"#000000"];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectFirstLabel.mas_left);
            make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(8);
            make.right.mas_equalTo(self.selectFirstLabel.mas_right);
            make.height.mas_equalTo(55);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _titleLabel;
}
@end
