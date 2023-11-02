//
//  AEMineViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/10/31.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEMineViewController.h"

@implementation AEMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)configEvent {
    [super configEvent];
    
    self.dataArray = [self getLocalJsonData:@"mine_data"];
    if (self.dataArray.count <= 0) {
        
        self.dataArray = @[@"AEScrollViewController",];
    }
}

@end
