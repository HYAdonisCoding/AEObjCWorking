//
//  AETrialViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/7/23.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AETrialViewController.h"

@interface AETrialViewController ()

@end

@implementation AETrialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)configEvent {
    [super configEvent];
    
    self.dataArray = [self getLocalJsonData:@"interact_data"];
    if (self.dataArray.count <= 0) {
        
        self.dataArray = @[@"AEScrollViewController",
                           @"AEScrollTrialViewController"];
    }
}


@end
