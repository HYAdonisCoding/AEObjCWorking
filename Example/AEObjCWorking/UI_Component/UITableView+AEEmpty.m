//
//  UITableView+AEEmpty.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/28.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "UITableView+AEEmpty.h"

@implementation UITableView (AEEmpty)

- (void)showMessage:(NSString *)message count:(NSInteger)count {
    if (count > 0) {
        self.backgroundView = nil;
        return;
    }
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    UIImageView *showImageView = [[UIImageView alloc]init];
    showImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backgroundView addSubview:showImageView];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor colorWithString: @"#999999"];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [backgroundView addSubview:tipLabel];
    
    showImageView.image = [UIImage imageNamed:@"nodata_icon"];
    tipLabel.text = message;
    ///tipLabel.text = @"网络不可用";
 
    [showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView.mas_centerX);
        make.centerY.mas_equalTo(backgroundView.mas_centerY).mas_offset(-50);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backgroundView.mas_centerX);
        make.top.mas_equalTo(showImageView.mas_bottom).mas_offset(30);
    }];
    
    self.backgroundView = backgroundView;
    
}

@end
