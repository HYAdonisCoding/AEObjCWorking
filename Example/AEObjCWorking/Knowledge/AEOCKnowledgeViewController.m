//
//  AEOCKnowledgeViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEOCKnowledgeViewController.h"
#import "AEBaseModel+AECategory.h"
#import "AEBaseModel+AECategoryTest.h"
/// test
@interface Sark : NSObject

@end

@implementation Sark

@end

// MARK: - 笔试题
@interface Mobile : NSObject

@end

@implementation Mobile



@end

@interface Phone : Mobile

@end

@implementation Phone

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"self - %@", NSStringFromClass([self class]));
        NSLog(@"super - %@", NSStringFromClass([super class]));
    }
    return self;
}

@end

@interface AEOCKnowledgeViewController ()

@end

@implementation AEOCKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = @[@"AECategoryViewController",
                       @"AEGCDViewController",
                       @"AEArithmeticViewController",
                       @"AEBlockViewController",
                       @"AEMemoryViewController",
                       @"AEReusePoolViewController",
                       @"AEEventViewController",
                       @"AEKVOViewController",
                       @"AERuntimeViewController"];
    /// test
    BOOL ret1 = [[NSObject class] isKindOfClass:[NSObject class]];
    BOOL ret2 = [[NSObject class] isMemberOfClass:[NSObject class]];
    BOOL ret3 = [[Sark class] isKindOfClass:[Sark class]];
    BOOL ret4 = [[Sark class] isMemberOfClass:[Sark class]];
    NSLog(@"%d%d%d%d", ret1, ret2, ret3, ret4);
    
    NSLog(@"1%@", NSStringFromClass([self class]));
    NSLog(@"2%@", NSStringFromClass([super class]));
    
    NSLog(@"1%@", [self testString]);
    NSLog(@"2%@", [super testString]);
    
    // 多线程
//    [self thread];
    
    AEBaseModel *model = [AEBaseModel new];
    [model getSport];
    
    Phone *p = [Phone new];
}

- (void)thread {
    //    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread:) object:@"参数"];
    //    [thread start];
    //    thread.name = @"NSThread线程";
    //    thread.threadPriority = 1;
    //    [thread cancel];
    //    [NSThread detachNewThreadSelector:@selector(testThread:) toTarget:self withObject:@"构造器方式参数"];
    
    //
    [self performSelector:@selector(testThread:) withObject:@"参数1" afterDelay:1];
    [self performSelectorOnMainThread:@selector(testThread:) withObject:@"参数2" waitUntilDone:YES];
    [self performSelectorInBackground:@selector(testThread:) withObject:@"参数3"];
    
    [self performSelector:@selector(testThread:) onThread:[NSThread currentThread] withObject:@"参数4" waitUntilDone:YES];
    [self performSelector:@selector(testThread:) withObject:@"参数1" afterDelay:1];
    [[NSRunLoop currentRunLoop] run];
    
    dispatch_queue_t queque = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_barrier_async(queque, ^{
        NSLog(@"%@", @"来了");
    });
        
}
- (void)testThread:(id)data {
    NSLog(@"参数: %@", data);
}
- (NSString *)testString {
//    int(^MyBlock)(int, int) = ^(int a, int b){
//        NSLog(@"%d, 我就是block，有参数有返回值",a+b);
//        return a+b;
//    };
//    MyBlock(22, 33);
    typedef void(^Myblock)(void);
//    typedef int (^MyBlock)(int a, int b);
//    MyBlock block = ^int(int a, int b) {
//        return a + b;
//    };
//    block(1, 100);
    __block int age = 10;
    Myblock block = ^{
        NSLog(@"age = %d", age);
    };
    age = 8;
    block();
    return NSStringFromClass(self.class);
}


@end
