//
//  AEFontsViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/11/23.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEFontsViewController.h"

@implementation AEFontsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }

    [self configUI];
}

- (void)configUI {
    CGFloat size = 24;
    CGFloat width = SCREEN_WIDTH - 20;
    CGFloat height = 300;
    // 数字、字母、符号加汉字，然后设置一样的大小颜色
    NSString *title = @"1234567890 \nabcdefghijklmnopqrstuvwxy\n ABCDEFGHIJKLMNOPQRSTUVWXYZ\n ~!@#$%^&*()-=_+:\";'<>?,./ ~！@#￥%……&*（）——=——+；‘’：“”，。、《》？\n 长征二号F遥十五火箭焕然一新";
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, width, height)];
        label.font = [UIFont systemFontOfSize:size];
        label.numberOfLines = 0;
        label.text = title;
        label.backgroundColor = [UIColor yellowColor];
        label;
    })];
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 90 + height, width, height)];
        label.font = [UIFont fontWithName:@"MicrosoftYaHei" size:size];
        label.numberOfLines = 0;
        label.text = title;
        label.backgroundColor = [UIColor yellowColor];
        label;
    })];
//    [self.view addSubview:({
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 200, 40)];
//        label.font = [UIFont fontWithName:@"MicrosoftYaHei" size:size];
//        label.text = @"iOS MicrosoftYaHei";
//        label;
//    })];
//    [self.view addSubview:({
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 200, 40)];
//        label.font = [UIFont fontWithName:@"MicrosoftYaHei" size:size];
//        label.text = @"iOS 微软雅黑";
//        label;
//    })];
}

@end
