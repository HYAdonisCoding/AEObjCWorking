//
//  AECustomTitleView.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/3/10.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AECustomTitleView.h"
@interface AECustomTitleView()
/// 标题名
@property (nonatomic, copy) NSString *title;
/// 图标名
@property (nonatomic, copy) NSString *imageName;
/// 回调
@property (nonatomic, copy) void(^tapAction)(id data);

@end

@implementation AECustomTitleView
+ (instancetype)defaultTitleViewWith:(NSString *)title imageName:(NSString *)imageName tapAction:(void(^)(id data))tapAction {
    AECustomTitleView *view = [[AECustomTitleView alloc] initWith:title imageName:imageName tapAction:tapAction];
    return view;
}
- (instancetype)initWith:(NSString *)title imageName:(NSString *)imageName tapAction:(void(^)(id data))tapAction {
    self = [super init];
    if (self) {
        self.title = title;
        self.imageName = imageName;
        self.tapAction = tapAction;
        [self configUI];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@", @"AECustomTitleView dealloc");
}

- (void)configUI {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textAlignment = NSTextAlignmentRight;
    label.frame = CGRectMake(0, 0, 100, 40);
    label.textColor = [UIColor blackColor];
    label.text = self.title;
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 5, 30, 30);
    [button setImage:[UIImage imageNamed:@"broom_icon"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:label];
    [self addSubview:button];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.mas_equalTo(label.mas_right).offset(2);
    }];
    self.userInteractionEnabled = YES;
}

- (void)buttonClickedAction:(UIButton *)sender {
    if (self.tapAction) {
        self.tapAction(sender);
    }
}

@end
