//
//  AEPlistViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/8/3.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEPlistViewController.h"
#import "AEDataHelper.h"
#import "AECardModel.h"

@interface AEPlistViewController ()

@end

@implementation AEPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AECardModel *model = AECardModel.new;
//    model.title = @"AECardDetailModel";
//    AECardDetailModel *dModel = [AECardDetailModel new];
//    dModel.subTitle = @"详情标题";
//    dModel.detail = @"详情内容";
//    model.detailModel = @[dModel];
//    BOOL success = [AEDataHelper saveUserInfoInDocument:model];
//    NSLog(@"%hhd", success);
    model = [AEDataHelper getUserInfoInDocument];
    NSLog(@"%@", model);
}

/*
 注意：
 在iOS中，只允许向沙盒中的plist文件写数据
 如果plist文件在bundle，plist文件为只读，你需要将plist文件从bundle中复制到缓存目录或文档目录下，然后再修改数据
 2.当向沙盒中的plist文件写数据无效时
 对写入的数据结构应属于以下几种如下：（NSString，NSData，NSDate，NSNumber，NSArray，NSDictionary）
 其他的数据结构是不被接受的，如 null
 */

@end
