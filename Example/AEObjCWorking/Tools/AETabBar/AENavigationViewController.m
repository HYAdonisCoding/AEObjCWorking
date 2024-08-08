//
//  AENavigationViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/11/2.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AENavigationViewController.h"

@interface AENavigationViewController ()

@end

@implementation AENavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 首页不需要隐藏tabbar
       NSString *ctrlName = NSStringFromClass([viewController class]);
       
       if ([ctrlName isEqualToString:@"AEHomeViewController"] ||
           [ctrlName isEqualToString:@"AEUnconventionalViewController"] ||
           [ctrlName isEqualToString:@"AEActivityViewController"] ||
           [ctrlName isEqualToString:@"AEMineViewController"]) {
           
           viewController.hidesBottomBarWhenPushed = NO;

       }else{
          // 其他push时需要隐藏tabbar
           viewController.hidesBottomBarWhenPushed = YES;
       }
       
       // 这一句别忘记了啊
       [super pushViewController:viewController animated:animated];
}

@end
