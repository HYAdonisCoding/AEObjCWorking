//
//  AECardViewCCell.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AECardViewCCell.h"

@implementation AECardViewCCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeInterface];
    }
    return self;
}

- (void)makeInterface {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.detailLabel.font = [UIFont boldSystemFontOfSize:14];
    self.detailLabel.textAlignment = NSTextAlignmentLeft;
    self.detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.bottom.left.right.mas_equalTo(0);
    }];

}

@end
