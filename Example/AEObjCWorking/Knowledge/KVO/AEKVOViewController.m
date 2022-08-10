//
//  AEKVOViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEKVOViewController.h"
#import "AEMObject.h"
#import "AEMObserver.h"

@interface AEKVOViewController ()

@end

@implementation AEKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AEMObject *obj = [[AEMObject alloc] init];
    AEMObserver *observer = [[AEMObserver alloc] init];
    
    [obj addObserver:observer forKeyPath:@"value" options:(NSKeyValueObservingOptionNew) context:NULL];
    //通过setter方法修改value
    obj.value = 1;
    
    // 1 通过kvc设置value能否生效？
    [obj setValue:@2 forKey:@"value"];
    
    // 2. 通过成员变量直接赋值value能否生效?
    [obj increase];
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
