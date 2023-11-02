//
//  AEMemoryViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEMemoryViewController.h"
#import "NSTimer+AEWeakTimer.h"

@interface AEMemoryViewController ()

@end

@implementation AEMemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSTimer scheduledWeakTimerWithTimeInterval:0.5 target:self selector:@selector(start) userInfo:nil repeats:YES];
}
- (void)start {
    NSLog(@"%@", @"coming");
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
