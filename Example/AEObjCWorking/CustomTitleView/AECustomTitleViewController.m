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
/// <#Description#>
@property (nonatomic, strong) AECustomTitleView *titleView;
@end

@implementation AECustomTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title = @"消息中心";
    title = @"消息中心(100000000000)";
    AECustomTitleView *view = [AECustomTitleView defaultTitleViewWith:title imageName:@"broom_icon" tapAction:^(id  _Nonnull data) {
        NSLog(@"sender clicked %@", data);
    }];
    self.titleView = view;
    self.navigationItem.titleView = view;
}

@end
