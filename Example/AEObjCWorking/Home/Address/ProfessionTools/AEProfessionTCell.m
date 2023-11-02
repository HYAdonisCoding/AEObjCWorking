//
//  AEProfessionTCell.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEProfessionTCell.h"

@interface AEProfessionTCell ()




@end

@implementation AEProfessionTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 昵称
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(18);
            make.bottom.mas_equalTo(-18);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-41);
            make.height.mas_greaterThanOrEqualTo(19);
        }];
        
        self.imageIcon = [[UIImageView alloc] init];
        self.imageIcon.image = [UIImage imageNamed:@"icon_more"];
        [self.contentView addSubview:self.imageIcon];
        [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-24);
//            make.size.mas_equalTo(CGSizeMake(8, 16));
            make.centerY.mas_equalTo(0);
            make.left.mas_greaterThanOrEqualTo(self.nameLabel.mas_right).offset(1);
        }];
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

@end
