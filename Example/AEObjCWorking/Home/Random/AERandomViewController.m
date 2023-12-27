//
//  AERandomViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/12/27.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AERandomViewController.h"
#import "AERandomModel.h"

@interface AERandomViewController ()
/// 开始时间
@property (nonatomic, copy) NSString *start_date;
/// 结束时间
@property (nonatomic, copy) NSString *end_date;
@end

@implementation AERandomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.start_date = @"2023/12/2";
    self.end_date = @"2023/12/19";
    NSLog(@"在范围内？ <%hhd>", [self testNil]);
}

- (BOOL)testNil {

    NSString *format = @"yyyy/MM/dd";
    // 判断时间
    /// 开始、结束时间都有
    if (self.start_date.length > 0 &&
        self.end_date.length > 0) {
        return [AETools isCurrentTimeBetweenStartTime:self.start_date andEndTime:self.end_date format:format];
    } else
        /// 有开始、没有结束时间
        if (self.start_date.length > 0 &&
            self.end_date.length <= 0) {
            return [AETools isCurrentTimeGreaterOrEqualThan:self.start_date format:format];
            
        } else
            /// 没有开始、有结束时间
            if (self.start_date.length <= 0 &&
                self.end_date.length > 0) {
                return [AETools isCurrentTimeLessOrEqualThan:self.end_date format:format];
            }
    return YES;
    
}

- (void)testRandom {
    // 创建对象数组
    AERandomModel *obj1 = [[AERandomModel alloc] init];
    obj1.probability = 5;
    obj1.advName = @"北京";
    
    AERandomModel *obj2 = [[AERandomModel alloc] init];
    obj2.probability = 3;
    obj2.advName = @"上海";
    
    AERandomModel *obj3 = [[AERandomModel alloc] init];
    obj3.probability = 2;
    obj3.advName = @"广州";
    AERandomModel *obj4 = [[AERandomModel alloc] init];
    obj4.probability = 5;
    obj4.advName = @"深圳";
    NSArray<AERandomModel *> *objects = @[obj1, obj2, obj3, obj4];
    
    
    for (int i = 0; i < 1500; i++) {
        // 随机选择对象
        AERandomModel *selectedObject = [AERandomViewController selectObjectWithProbability:objects];
        if (selectedObject) {
            NSLog(@"Selected %@ with probability: %ld", selectedObject.advName, (long)selectedObject.probability);
        } else {
            NSLog(@"No object selected");
        }
    }
    
}


+ (AERandomModel *)selectObjectWithProbability:(NSArray<AERandomModel *> *)objects {
    if (objects.count == 0) {
        return nil;
    }

    // 计算总概率值
    NSInteger totalProbability = 0;
    for (AERandomModel *obj in objects) {
        totalProbability += obj.probability;
    }

    // 生成随机数，范围在总概率值内
    NSInteger randomValue = arc4random_uniform((u_int32_t)totalProbability);

    // 遍历数组，根据概率选择对象
    NSInteger currentProbability = 0;
    for (AERandomModel *obj in objects) {
        currentProbability += obj.probability;
        if (randomValue < currentProbability) {
            return obj;
        }
    }

    // 如果数组中的对象概率之和不是总概率值，可能会返回 nil
    return nil;
}

@end
