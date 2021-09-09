//
//  AEAddressTCell.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEAddressTCell.h"

@implementation AEAddressTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 昵称
       self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 30, 40)];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        self.nameLabel.textColor = UIColor.grayColor;
        [self addSubview:self.nameLabel];
        self.imageIcon = [[UIImageView alloc] init];
        self.imageIcon.image  = [UIImage imageNamed:@"right"];
        [self.imageIcon setHidden: true];
        [self addSubview:self.imageIcon];
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
