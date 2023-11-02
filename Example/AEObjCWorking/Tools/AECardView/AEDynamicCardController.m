//
//  AEDynamicCardController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEDynamicCardController.h"
#import "AECardView.h"
#import "AECardModel.h"

@interface AEDynamicCardController ()

@end

@implementation AEDynamicCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self makeInterface];
}

- (void)makeInterface {
    NSMutableArray *dataArray = [NSMutableArray array];
    AECardModel *model = [AECardModel new];
    model.title = @"内容特权";
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    AECardDetailModel *detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"院线新片";
    detailModel.detail = @"1234567890----";
    [array addObject:detailModel];
//    detailModel = [AECardDetailModel new];
//    detailModel.subTitle = @"海量高清大片";
//    detailModel.detail = @"qwertyuop";
//    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"热剧抢先看";
    detailModel.detail = @"asdfghjkl;";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"独家综艺";
    detailModel.detail = @"134567890";
    [array addObject:detailModel];
    model.detailModel = array.copy;
    [dataArray addObject:model];
    
    model = [AECardModel new];
    model.title = @"观影特权";
    array = [NSMutableArray arrayWithCapacity:4];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"广告特权";
    detailModel.detail = @"1234567890----";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"蓝光4K";
    detailModel.detail = @"qwertyuop";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"杜比全景声";
    detailModel.detail = @"asdfghjkl;";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"赠送影片";
    detailModel.detail = @"134567890";
    [array addObject:detailModel];
    model.detailModel = array.copy;
    [dataArray addObject:model];
    
    model = [AECardModel new];
    model.title = @"身份特权";
    array = [NSMutableArray arrayWithCapacity:3];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"电视大屏权益";
    detailModel.detail = @"1234567890----";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"尊享标识";
    detailModel.detail = @"qwertyuop";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"明星见面会";
    detailModel.detail = @"asdfghjkl;";
    [array addObject:detailModel];
//    detailModel = [AECardDetailModel new];
//    detailModel.subTitle = @"院线首映";
//    detailModel.detail = @"134567890";
//    [array addObject:detailModel];
    model.detailModel = array.copy;
    [dataArray addObject:model];
    
    model = [AECardModel new];
    model.title = @"生活特权";
    array = [NSMutableArray arrayWithCapacity:4];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"每日福利";
    detailModel.detail = @"1234567890----";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"生日礼包";
    detailModel.detail = @"qwertyuop";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"明星影视";
    detailModel.detail = @"asdfghjkl;";
    [array addObject:detailModel];
    detailModel = [AECardDetailModel new];
    detailModel.subTitle = @"购物折扣";
    detailModel.detail = @"134567890";
    [array addObject:detailModel];
    model.detailModel = array.copy;
    [dataArray addObject:model];
    
    
    
    AECardView *view = [[AECardView alloc] initWithFrame:CGRectZero];
    view.dataArray = dataArray.copy;
    view.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(2);
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}


@end
