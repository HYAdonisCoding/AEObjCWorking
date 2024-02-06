//
//  AEMutileLineTCell.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/2/14.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEMutileLineTCell.h"
@interface AEMutileLineTCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageIcon;
@property (strong, nonatomic) UIImageView *subImageIcon;
@end

@implementation AEMutileLineTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor blueColor];
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
        self.imageIcon.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:self.imageIcon];
        [self.imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(580);
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.right.mas_equalTo(self.titleLabel.mas_right);
        }];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor magentaColor];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageIcon.mas_bottom).offset(10);
            make.height.mas_equalTo(180);
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.right.mas_equalTo(self.titleLabel.mas_right);
            make.bottom.mas_equalTo(-10);
        }];
        self.subImageIcon = imageView;
        
        //先移除原有通知，再添加，防止重复
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AEHomeDidScorll" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(monitoringScreenDisplayScroll:)
                                                    name:@"AEHomeDidScorll" object:nil];
    
    }
    return self;
}



#pragma mark - 监测屏幕显示
- (void)monitoringScreenDisplayScroll:(NSNotification *)notification {
    UITableView *tableView = notification.userInfo[@"tableView"];
    CGRect screenRect = tableView.frame;
    CGRect convertRect = [self convertRect:self.titleLabel.frame toView:tableView.superview];
    BOOL visible = CGRectIntersectsRect(convertRect, screenRect);
    if (visible) {
//        NSLog(@"显示了标题: %@", _title);
    }
    CGRect convertRect1 = [self convertRect:self.imageIcon.frame toView:tableView.superview];
    BOOL visible1 = CGRectIntersectsRect(convertRect1, screenRect);
    if (visible1) {
//        NSLog(@"显示了imageIcon");
    }
    
    CGRect convertRect2 = [self convertRect:self.subImageIcon.frame toView:tableView.superview];
    BOOL visible2 = CGRectIntersectsRect(convertRect2, screenRect);
    if (visible2) {
//        NSLog(@"显示了subImageIcon");
    }
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
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
