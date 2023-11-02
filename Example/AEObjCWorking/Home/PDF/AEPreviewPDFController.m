//
//  AEPreviewPDFController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/25.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEPreviewPDFController.h"
#import "AEPDFModel.h"
#import "AEPreviewPDFViewController.h"

@interface AEPreviewPDFController ()

@end

@implementation AEPreviewPDFController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)configEvent {
    [super configEvent];
    NSString *path1 = [[NSBundle mainBundle] pathForResource: @"错题.pdf" ofType:nil];
    NSString *path2 = [[NSBundle mainBundle] pathForResource: @"发票.pdf" ofType:nil];
    NSString *path3 = [[NSBundle mainBundle] pathForResource: @"协议书.pdf" ofType:nil];
    
    AEPDFModel *model1 = [[AEPDFModel alloc] initWithName:@"错题" path:path1 readed:NO];
    AEPDFModel *model2 = [[AEPDFModel alloc] initWithName:@"理财产品合同" path:path2 readed:NO];
    AEPDFModel *model3 = [[AEPDFModel alloc] initWithName:@"协议书" path:path3 readed:NO];
    
    self.dataArray = @[model1, model2, model3].mutableCopy;
}
- (void)configUI {
    [super configUI];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:NSStringFromClass([self class])];
    }
    AEPDFModel *model = (AEPDFModel *)self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.backgroundColor = UIColor.cyanColor;
//    cell.detailTextLabel.text = model.readed ? @"已阅读" : @"待阅读";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AEPreviewPDFViewController *vc = [[AEPreviewPDFViewController alloc] initWithModel:self.dataArray[indexPath.row]];
    [self presentViewController:vc animated:YES completion:^{
            //
    }];
}
@end
