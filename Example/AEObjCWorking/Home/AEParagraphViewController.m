//
//  AEParagraphViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/6/28.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AEParagraphViewController.h"

@interface AEParagraphViewController ()

@end

@implementation AEParagraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configUI {
    [super configUI];
    
    
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(15);
        make.bottom.mas_lessThanOrEqualTo(self.mas_bottomLayoutGuideTop);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentJustified;
//    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
//    label.text = @"最新签发：对中国游客实行免签\n环球时报\n2024-06-27 15:38\n当地时间6月26日，老挝新闻文化旅游部部长签发了《2024老挝旅游年关于对特定游客签证政策实施细则》29号文件。\n根据文件内容，中国内地（大陆）及港澳台游客可以通过旅游公司组织，获取普通护照15天免签的政策。行程需要由老挝旅游公司组织并获得新闻文化旅游部的许可。政策执行时间从2024年7月1日起到2024年12月31日。";
    label.text = @"News UK is at the heart of the national conversation. Reaching almost 40 million people each month across the UK and beyond, our brands provide news, analysis, opinion - and some fun - to loyal and engaged audiences. Online, on the air, in print and beyond, our world-class journalists and broadcasters tell the stories that matter.";
    
}

@end
