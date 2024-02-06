//
//  AESignalTCell.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/2/14.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AESignalTCell.h"

@implementation AESignalTCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
    // 必须用子视图转化才能准确检测到显示
    CGRect convertRect = [self convertRect:self.textLabel.frame toView:tableView.superview];
    BOOL visible = CGRectIntersectsRect(convertRect, screenRect);
    if (visible) {
//        NSLog(@"显示了第: %@ 行", self.textLabel.text);
    }
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
