//
//  AEHeadlineCCell.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/5/30.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEHeadlineCCell.h"

@interface AEHeadlineCCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation AEHeadlineCCell
- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    if (titleString.length > 2 && [titleString containsString:@" "]) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:titleString];
        [attributeString addAttributes:
         @{NSForegroundColorAttributeName: [UIColor colorWithString:@"#000000"],
           NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14]
         } range:NSMakeRange(0, attributeString.length)];
        
        [attributeString addAttributes:
         @{NSForegroundColorAttributeName: [UIColor colorWithString:@"#FB7C2D"],
           NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14]
         } range:NSMakeRange(0, 2)];
        self.titleLabel.attributedText = attributeString;
    } else {
        self.titleLabel.text = titleString;
    }
}
#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"Headlines_icon"];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(7);
            make.bottom.mas_equalTo(-7);
            make.size.mas_equalTo(CGSizeMake(34, 25));
        }];
    }
    return _imageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-19);
            make.left.mas_equalTo(self.imageView.mas_right).offset(8);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _titleLabel;
}

#pragma mark - 页面初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self imageView];
        [self titleLabel];
        UIImageView *rightImageView = [UIImageView new];
        rightImageView.image = [UIImage imageNamed:@"Headline_arrow_icon"];
        [self.contentView addSubview:rightImageView];
        [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(4, 8));
        }];
    }
    return self;
}


@end
