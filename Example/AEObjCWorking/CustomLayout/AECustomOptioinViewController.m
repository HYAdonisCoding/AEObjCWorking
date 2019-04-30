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

@end

@implementation AECustomOptioinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"edit";
    
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
    
    AECustomOptionView *view  = [AECustomOptionView sharedWithDataArray:array frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.block = ^(id  _Nullable data) {
        NSLog(@"%@", data);
    };
    
    [self.view addSubview:view];
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
