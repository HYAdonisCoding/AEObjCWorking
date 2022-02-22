//
//  AEFileOperationViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/2/22.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEFileOperationViewController.h"
#import <WebKit/WebKit.h>


@interface AEFileOperationViewController ()<UIDocumentPickerDelegate>
/// 显示pdf
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AEFileOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [WKWebView new];
    self.webView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    UIButton *upload = [UIButton buttonWithType:(UIButtonTypeCustom)];
    upload.backgroundColor = UIColor.purpleColor;
    [upload setTitle:@"选择文件" forState:(UIControlStateNormal)];
    [upload addTarget:self action:@selector(presentDocumentCloud) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:upload];
    [upload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.webView.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.5);
        make.centerX.mas_equalTo(0);
    }];
}

//打开文件APP
- (void)presentDocumentCloud {
//    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
    NSArray *documentTypes = @[ @"public.image", @"com.adobe.pdf"];

    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    documentPickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}

#pragma mark - UIDocumentPickerDelegate
#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    //获取授权
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        //通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;

        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            //读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            if (error) {
                //读取出错
//                [self showError:@"读取出错"];
                NSLog(@"%@", @"读取出错");
            } else {
                //上传
//                NSLog(@"fileData --- %@",fileData);
//                [self uploadingWithFileData:fileData fileName:fileName fileURL:newURL];
                [self fileWithURL:newURL data:fileData fileName:fileName];
            }
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        [urls.firstObject stopAccessingSecurityScopedResource];
    } else {
        //授权失败
//        [self showError:@"授权失败"];
        NSLog(@"%@", @"授权失败");
    }
}

- (void)fileWithURL:(NSURL *)url data:(NSData *)data fileName:(NSString *)fileName {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        //下载PDF到本地 使用同步下载方法，
        NSData *doubi = data;
        //  二进制流写入文件
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];

        NSFileManager *fileManger = [NSFileManager defaultManager];
        NSString *testDirectory = [documentsDirectory stringByAppendingString:@"/test"];

        //  创建目录
        [fileManger createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        //  创建文件
        NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
        //  写入文件

        [fileManger createFileAtPath:testPath contents:doubi attributes:nil];

        dispatch_sync(dispatch_get_main_queue(), ^{

            //打开文件:testPath
            NSURL *fileUrl = [NSURL fileURLWithPath:testPath];
            NSURL *parentUrl = [NSURL fileURLWithPath:testDirectory];
            [self.webView loadFileURL:fileUrl allowingReadAccessToURL:parentUrl];
        });
    });
    
    //打开文件:testPath
//    NSURL *parentUrl = [NSURL fileURLWithPath:@"/private/var/mobile/Containers/Shared/AppGroup/44230A92-5135-4DCE-B8A2-0B58F92034FA/File Provider Storage/其他/"];
//    [self.webView loadFileURL:url allowingReadAccessToURL:parentUrl];

}
                   
@end
