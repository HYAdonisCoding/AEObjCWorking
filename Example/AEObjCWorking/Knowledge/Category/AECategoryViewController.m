//
//  AECategoryViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/2/24.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AECategoryViewController.h"
#import "AEStudyModel.h"
#import "AEStudyModel+StudyCategory.h"
#import "AEStudyModel+AEDouble.h"

@interface AECategoryViewController ()

@end

@implementation AECategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AEStudyModel *o = [AEStudyModel new];
    [o study:@"Objective-C 语言"];
    NSLog(@"%@", [AEStudyModel standard]);
    [o studyHardWith:@"Adam"];
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
