//
//  AEPopoverShowController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEPopoverShowController.h"
#import "AEPopSheetController.h"

@interface AEPopoverShowController ()

@end

@implementation AEPopoverShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"环境" style:(UIBarButtonItemStyleDone) target:self action:@selector(filter:)];
}

- (void)filter:(UIBarButtonItem *)sender {
    AEPopSheetController *vc = [[AEPopSheetController alloc] initWithSourceView:self.navigationController.view bySourceRect:(CGRectMake(SCREEN_WIDTH - 100, 0, 100, 100)) andContentSize:(CGSizeMake(100, 100)) andDirection:(UIPopoverArrowDirectionAny)];
    vc.dataArray = @[@"测试", @"生产", @"渗透"];
    vc.block = ^(NSInteger index, id  _Nonnull object) {
        NSLog(@"选中了 %d - %@", index, object);
        if ([object isKindOfClass:[NSString class]]) {
            
            [sender setTitle:(NSString *)object];
        }
    };
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
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
