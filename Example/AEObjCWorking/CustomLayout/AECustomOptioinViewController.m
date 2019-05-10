//
//  AECustomOptioinViewController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AECustomOptioinViewController.h"
#import "AECustomOptionView.h"
#import "AECustomOptionModel.h"

@interface AECustomOptioinViewController ()

    /// 已选择数组
@property (nonatomic, copy) NSMutableArray *selectedArray;

@end

@implementation AECustomOptioinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"edit";
    
    self.selectedArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *array = [NSMutableArray array];
    AECustomOptionModel *model = [AECustomOptionModel new];
    model.title = [AEConvenientTool randomCreatChinese:3];
    [array addObject:model];
    
    model = [AECustomOptionModel new];
    model.title = [AEConvenientTool randomCreatChinese:13];
    [array addObject:model];
    
    model = [AECustomOptionModel new];
    model.title = [AEConvenientTool randomCreatChinese:4];
    [array addObject:model];
    
    model = [AECustomOptionModel new];
    model.title = [AEConvenientTool randomCreatChinese:123];
    [array addObject:model];

    model = [AECustomOptionModel new];
    model.title = [AEConvenientTool randomCreatChinese:4];
    [array addObject:model];

    model = [AECustomOptionModel new];
    model.title = [AEConvenientTool randomCreatChinese:5];
    [array addObject:model];

    model = [AECustomOptionModel new];
    model.title = [AEConvenientTool randomCreatChinese:6];
    [array addObject:model];
    
    AECustomOptionView *view  = [AECustomOptionView sharedWithDataArray:array frame:CGRectMake(0, kHYSafeAreaTopHeight, SCREEN_WIDTH, 100)];
    WK(weakSelf);
    view.block = ^(id  _Nullable data) {
        SG(strongSelf)
        [strongSelf showAlertViewWithMessage:[@"点击了" stringByAppendingString:data]];
        NSLog(@"%@", data);
    };
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view.frame) + 20, SCREEN_WIDTH - 20, 50)];
    label.text = @"已选择";
    [self.view addSubview:label];
    
    AECustomOptionView *choosedView  = [AECustomOptionView sharedWithDataArray:array frame:CGRectMake(0, CGRectGetMaxY(label.frame) + 20, SCREEN_WIDTH, 100)];
    
    choosedView.block = ^(id  _Nullable data) {
        SG(strongSelf)
        [strongSelf showAlertViewWithMessage:[@"点击了" stringByAppendingString:data]];
        NSLog(@"%@", data);
    };
    
    [self.view addSubview:choosedView];
}
- (void)showAlertViewWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
