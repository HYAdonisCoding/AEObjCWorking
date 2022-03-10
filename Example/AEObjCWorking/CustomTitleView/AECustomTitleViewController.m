//
//  AECustomTitleViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/3/10.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AECustomTitleViewController.h"
#import "AECustomTitleView.h"

@interface AECustomTitleViewController ()

@end

@implementation AECustomTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"消息中心";
    title = @"消息中心(100000000000)";
    AECustomTitleView *view = [AECustomTitleView defaultTitleViewWith:title imageName:@"broom_icon" tapAction:^NSString * _Nonnull(id  _Nonnull data) {
        
        NSLog(@"sender clicked %@", data);
        
        return @"消息中心";
    }];
//    view.userInteractionEnabled = YES;
//    view.backgroundColor = [UIColor purpleColor];
    
    self.navigationItem.titleView = view;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SCREEN_WIDTH - 100);
    }];
}

@end
