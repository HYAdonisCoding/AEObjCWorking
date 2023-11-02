//
//  AEUnconventionalViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/25.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEUnconventionalViewController.h"

@interface AEUnconventionalViewController ()

@end

@implementation AEUnconventionalViewController

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
