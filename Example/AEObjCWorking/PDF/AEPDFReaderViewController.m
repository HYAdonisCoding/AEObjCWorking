//
//  AEPDFReaderViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/2.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEPDFReaderViewController.h"
#import "AEPreviewViewController.h"
#import "AEPDFModel.h"
#import "AEPreviewControllerWrapper.h"


@interface AEPDFReaderViewController () 

@end

@implementation AEPDFReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource: @"错题.pdf" ofType:nil];
    NSString *path2 = [[NSBundle mainBundle] pathForResource: @"发票.pdf" ofType:nil];
    NSString *path3 = [[NSBundle mainBundle] pathForResource: @"截屏.pdf" ofType:nil];
    
    AEPDFModel *model1 = [[AEPDFModel alloc] initWithName:@"保险条款" path:path1 readed:NO];
    AEPDFModel *model2 = [[AEPDFModel alloc] initWithName:@"免责条款" path:path2 readed:NO];
    AEPDFModel *model3 = [[AEPDFModel alloc] initWithName:@"注意事项" path:path3 readed:NO];
    
    self.dataArray = @[model1, model2, model3].mutableCopy;
    
}





- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:NSStringFromClass([self class])];
    }
    AEPDFModel *model = (AEPDFModel *)self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.backgroundColor = UIColor.cyanColor;
    cell.detailTextLabel.text = model.readed ? @"已阅读" : @"待阅读";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WK(weakSelf);
    AEPreviewViewController *vc = [[AEPreviewViewController alloc] initAllPages:self.dataArray currentPage:indexPath.row completeHandler:^(NSArray * _Nonnull datas) {
        weakSelf.dataArray = datas.mutableCopy;
        [weakSelf.tableView reloadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}





#pragma mark -
#pragma mark UIDocumentInteractionControllerDelegate

///// 方法可以返回一个新的视图控制器以显示文档内容。您可以创建一个自定义的视图控制器并将其返回给此方法。
//- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
//    // 创建自定义的底部工具栏
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
//    [self.view addSubview:toolbar];
//    self.toolbar = toolbar;
//    // 创建工具栏按钮
//    UIBarButtonItem *customButton = [[UIBarButtonItem alloc] initWithTitle:@"请滑至最后一页，完整阅读协议内容（3S）" style:UIBarButtonItemStylePlain target:self action:@selector(openIn:)];
//    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//
//    // 将按钮添加到工具栏
//    toolbar.items = @[flexibleSpace, customButton];
//    return self;
//}





@end
