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

/// <#Description#>
@property (nonatomic, strong) NSMutableArray *mArray;
/// error
@property (nonatomic, copy) NSMutableArray *eArray;

@property (nonatomic, copy) NSArray *array;


@end

@implementation AECategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AEStudyModel *o = [AEStudyModel new];
    [o study:@"Objective-C 语言"];
    NSLog(@"%@", [AEStudyModel standard]);
    [o studyHardWith:@"Adam"];
    
    [self testProperty];
}

/**
 | 源对象类型    | 拷贝方式    | 目标对象类型 | 拷贝类型（深/浅） |
 | ------------- | ----------- | ------------ | ----------------- |
 | mutable对象   | copy        | 不可变       | 深拷贝            |
 | mutable对象   | mutableCopy | 可变         | 深拷贝            |
 | immutable对象 | copy        | 不可变       | 浅拷贝            |
 | immutable对象 | mutableCopy | 可变         | 深拷贝            |

 - 可变对象的copy和mutableCopy都是深拷贝
 - 不可变对象的copy是浅拷贝，mutableCopy都是深拷贝
 - copy方法返回的都是不可变对象
 */
- (void)testProperty {
    self.mArray = [NSMutableArray array];
    [self.mArray addObject:@"1"];
    id r1 = self.mArray.mutableCopy;
    [r1 addObject:@"2"];
    NSLog(@"r1: %@", r1);
    id r2 = self.mArray.copy;
    /// 不可变 error
//    [r2 addObject:@"3"];
    NSLog(@"r2: %@", r2);
    
    
    self.array = [NSArray arrayWithObject:@"A"];
    id r3 = self.mArray.mutableCopy;
    [r3 addObject:@"2"];
    NSLog(@"r3: %@", r1);
    id r4 = self.mArray.copy;
    /// 不可变 error
//    [r4 addObject:@"3"];
    NSLog(@"r4: %@", r4);
}

@end
