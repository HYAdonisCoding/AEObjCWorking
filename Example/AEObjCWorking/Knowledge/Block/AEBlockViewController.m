//
//  AEBlockViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEBlockViewController.h"
#import "AEMCBlock.h"

@interface AEBlockViewController ()

@end

@implementation AEBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[@"MCBlock", @"testBlock1", @"testBlock2", @"testBlock3"];

    
    
}
- (void)MCBlock{
    [[[AEMCBlock alloc] init] method];
}

- (void)testBlock1 {
    [[[AEMCBlock alloc] init] method1];
}

- (void)testBlock2 {
    [[[AEMCBlock alloc] init] method2];
}

- (void)testBlock3 {
    [[[AEMCBlock alloc] init] method3];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *method = self.dataArray[indexPath.row];
    SEL sel = NSSelectorFromString(method);
    if (sel && [self respondsToSelector:sel]) {
        [self performSelector:sel];
    } else {
        // 没有这个方法
        NSLog(@"%@ -- %@", @"没有这个方法", method);
    }

}

@end
