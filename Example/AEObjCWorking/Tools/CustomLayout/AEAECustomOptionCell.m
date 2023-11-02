//
//  AEAECustomOptionCell.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEAECustomOptionCell.h"

static CGFloat space = 5.0f;

@interface AEAECustomOptionCell ()

/// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation AEAECustomOptionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeInterface];
    }
    return self;
}

- (void)makeInterface {
    
    self.titleLabel = ({
        UILabel *cardClassNameLabel = [[UILabel alloc] init];
        cardClassNameLabel.font = [UIFont systemFontOfSize:13.0f];
        cardClassNameLabel.textAlignment = NSTextAlignmentCenter;
        cardClassNameLabel.backgroundColor = [UIColor greenColor];
        cardClassNameLabel.layer.cornerRadius = 8.0f;
        cardClassNameLabel.layer.masksToBounds = YES;
        cardClassNameLabel.layer.borderColor = [UIColor grayColor].CGColor;
        cardClassNameLabel.layer.borderWidth = .5f;
        [self addSubview:cardClassNameLabel];
        [cardClassNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(space);
            make.bottom.right.mas_equalTo(-space);
            make.height.mas_greaterThanOrEqualTo(20.0f);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH - 20.0f);
        }];
        cardClassNameLabel;
    });
}
@end
