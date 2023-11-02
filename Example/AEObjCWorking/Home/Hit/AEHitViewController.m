//
//  AEHitViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/9/6.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEHitViewController.h"
#import "AEHitView.h"
#import "UIButton+EnlargeArea.h"

@interface AEHitViewController ()

@end

@implementation AEHitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testHit];
    
    [self testFonts];
}
- (void)testFonts {
    //遍历所有字体，这时已经把新字体添加进去了
    for (NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
}

- (void)testHit {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.center.mas_equalTo(0);
    }];
    AEHitView *view2 = [[AEHitView alloc] init];
    view2.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.center.mas_equalTo(0);
    }];
    
    [self.view layoutIfNeeded];
    NSLog(@"%@", view);
}
- (void)testButton2 {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.center.mas_equalTo(0);
    }];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.center.mas_equalTo(0);
    }];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [view2 addSubview:button];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
        make.center.mas_equalTo(0);
    }];
    [button setBackgroundColor:[UIColor cyanColor]];
    button.clickArea = @"10";
    
    
}

- (void)testButton {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(48);
        make.center.mas_equalTo(0);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.center.mas_equalTo(0);
    }];
    [button setBackgroundColor:[UIColor cyanColor]];
    button.clickArea = @"3";
    
    
}

- (void)btnClicked:(UIButton *)sender {
    NSLog(@"点击了");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
