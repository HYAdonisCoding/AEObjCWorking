//
//  AEGifViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/5/19.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEGifViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "AEHeadlineCCell.h"
#import "AEConvenientTool.h"

@interface AEGifViewController () <SDCycleScrollViewDelegate>

/// message
@property (nonatomic, strong) NSArray *messageArray;
@end

@implementation AEGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self messages];
//    [self testNotification];
    [self testNotificationClass];
}
- (void)testNotificationClass {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSString *name = @"ClassNotificationComing";
    [center removeObserver:[AEConvenientTool class]];
    [center addObserver:[AEConvenientTool class] selector:@selector(ae_customLog:) name:name object:nil];
    [center postNotificationName:name object:@"going" userInfo:@{@"1":@"123"}];
}
- (void)testNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center removeObserver:[AEConvenientTool class]];
    [center removeObserver:self];
    NSString *name = @"NotificationComing";
    /**注意：
     1、如果发送的通知指定了object对象，那么观察者接收的通知设置的object对象与其一样，才会接收到通知，但是接收通知如果将这个参数设置为了nil，则会接收一切通知。
     2、观察者的SEL函数指针可以有一个参数，参数就是发送的死奥西对象本身，可以通过这个参数取到消息对象的userInfo，实现传值。
     */
    [center addObserver:self selector:@selector(messages) name:name object:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"postNotification -- ");
        [center postNotificationName:name object:@"going" userInfo:@{@"1":@"123"}];
    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"postNotification -- ");// 发送和接受同一个线程
//        [center postNotificationName:name object:@"going" userInfo:@{@"1":@"123"}];
//    });
}
- (void)messages:(NSNotification *)notice {
    NSLog(@"notice--%@", notice);
}
- (void)messages {
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 39) delegate:self placeholderImage:nil];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.messageArray = @[
            @"通知 国家新闻出版署认定62种图书不合格热",
            @"通知 茅台冰淇淋上线：含2％飞天茅台",
            @"头条 湖北5名中学生游泳时被急流冲走热",
            @"头条 3人因蜱虫病病逝 曾接触去世感染者新",
            @"头条 出版社回应童书中兔子集体跳湖自杀新",
            @"头条 武汉一知名虾店被曝用黑油死虾新",
            @"头条 刘畊宏边直播边打白蚁",
            @"头条 山东一公立医院招聘“才艺护士”",
        ];
//        cycleScrollView.mainView.contentOffset = CGPointMake(0, 0);
        cycleScrollView.imageURLStringsGroup = self.messageArray;
    });
    self.messageArray = @[
        @"通知 全国疫情继续稳定下降",
        @"头条 安踏海报被指擦边：处理相关人员热",];
    cycleScrollView.imageURLStringsGroup = self.messageArray;
    cycleScrollView.backgroundColor = [UIColor magentaColor];
    cycleScrollView.showPageControl = NO;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:cycleScrollView];
    cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        NSLog(@"clickItem - %ld", (long)currentIndex);
    };
    cycleScrollView.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
//        NSLog(@"itemDidScroll - %ld", (long)currentIndex);
    };
}
/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    return [AEHeadlineCCell class];
}


/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    AEHeadlineCCell *myCell = (AEHeadlineCCell *)cell;
    myCell.titleString = self.messageArray[index];
}

- (void)ads {
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200) delegate:self placeholderImage:nil];
    cycleScrollView.imageURLStringsGroup = @[
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/dd.png",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/00001105ld.png",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5qjjba.png",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/zkvcs.jpg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5zkv2.jpeg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5zkv2.jpeg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5qjjba.png",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5zkv2.jpeg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5qjjba.png",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5zkv2.jpeg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5qjjba.png",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5zkv2.jpeg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/szkvdl3.jpg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5zkv2.jpeg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/szkvdl3.jpg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5zkv2.jpeg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/szkvdl3.jpg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/5zkv2.jpeg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/zkvcs.jpg",
        @"http://static.cebbank.com/fileDir/subject/resource/sjyhzqtp/MOBILEBANKAD/OPENAD/szkvdl3.jpg"];
    [self.view addSubview:cycleScrollView];
    cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        NSLog(@"clickItem - %ld", (long)currentIndex);
    };
    cycleScrollView.itemDidScrollOperationBlock = ^(NSInteger currentIndex) {
//        NSLog(@"itemDidScroll - %ld", (long)currentIndex);
    };
}
- (void)testGif {
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor blueColor]];
    // 财富版 标准版  都改扫一扫
    btn.adjustsImageWhenHighlighted = NO;
    btn.showsTouchWhenHighlighted = NO;
    CGFloat size = 0.5;
    // MARK: - gif
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"help_icon" ofType:@"gif"];
    btn.frame = CGRectMake(50, 100, 44*size, 28*size);
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage sd_imageWithGIFData:imageData];
    
    [btn setImage:image forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)btnClicked {
    NSLog(@"%@", @"---Clicked");
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
