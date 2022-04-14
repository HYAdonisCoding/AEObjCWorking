//
//  AECustomTitleViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/3/10.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AECustomTitleViewController.h"
#import "AECustomTitleView.h"
#import "UIButton+AEImagePlace.h"
#import "AESpaceLabel.h"

@interface AECustomTitleViewController () {
    UIButton *_button;
}

@end

@implementation AECustomTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"消息中心";
    title = @"消息中心(100000000000)";
//    AECustomTitleView *view = [AECustomTitleView defaultTitleViewWith:title imageName:@"broom_icon" tapAction:^NSString * _Nonnull(id  _Nonnull data) {
//
//        NSLog(@"sender clicked %@", data);
//
//        return @"消息中心";
//    }];

//    self.navigationItem.titleView = view;
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(40);
//        make.width.mas_equalTo(SCREEN_WIDTH - 100);
//    }];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"broom_icon-1"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(broomAction) forControlEvents:(UIControlEventTouchUpInside)];
    button.backgroundColor = [UIColor purpleColor];
    
    self.navigationItem.titleView = button;
    [button sizeToFit];
    [button layoutButtonStyle:(AEButtonEdgeInsetsStyleRight) space:4];
    _button = button;
    
    
    AESpaceLabel *label = [[AESpaceLabel alloc] initWithFrame:CGRectZero];
    label.text = @"海南国家公园建设是国之大者\
    1上海新增本土2沸\
    2上海遭遇大风暴雨 有方舱严重漏雨热\
    3核酸检测时不建议把口罩往上推热\
    4胡锡进钱文雄离世令人悲痛唏嘘\
    5大量旅客离开上海铁路部门回应新\
    6降准即将落地新\
    7上海原副市长当志愿者\
    8武契奇回应塞尔维亚买中国防空系统\
    9运-20连续3天向塞尔维亚运军事物资\
    10虹口区卫健委钱文雄夫人自杀系谣言新\
    11椰树集团再发争议广告";
    label.backgroundColor = [UIColor greenColor];
    label.numberOfLines = 0;
    label.insets = UIEdgeInsetsMake(0, 20, 0, 20);
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
    }];
}

- (void)broomAction {
    [_button setTitle:@"消息中心" forState:(UIControlStateNormal)];
    [_button layoutButtonStyle:(AEButtonEdgeInsetsStyleRight) space:4];

}
@end
