//
//  AEFileOperationViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/2/22.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEFileOperationViewController.h"
#import <WebKit/WebKit.h>
#import "AEGetFile.h"

@interface AEFileOperationViewController ()<UIDocumentPickerDelegate>
/// 显示pdf
@property (nonatomic, strong) WKWebView *webView;
/// 预览
@property (nonatomic, strong) UIImageView *imageView;

/// 文件路径
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *directory;
/// <#Description#>
@property (nonatomic, strong) AEGetFile *f;
@end

@implementation AEFileOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = UIColor.yellowColor;
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
        make.height.width.mas_equalTo(150);
        make.centerX.mas_equalTo(0);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(show)];
    [self.imageView addGestureRecognizer:tap];
    
    
    UIButton *upload = [UIButton buttonWithType:(UIButtonTypeCustom)];
    upload.backgroundColor = UIColor.purpleColor;
    [upload setTitle:@"选择文件" forState:(UIControlStateNormal)];
    [upload addTarget:self action:@selector(presentDocumentCloud) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:upload];
    [upload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.5);
        make.centerX.mas_equalTo(0);
    }];
    
    self.webView = [WKWebView new];
    self.webView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(upload.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

- (void)show {
    if (self.path.length <= 0 || self.directory.length <= 0) {
        NSLog(@"%@", @"路径有误， 请重新选择文件");
        return;
    }
    //打开文件:testPath
    NSURL *fileUrl = [NSURL fileURLWithPath:self.path];
    NSURL *parentUrl = [NSURL fileURLWithPath:[self.path stringByDeletingLastPathComponent]];
    [self.webView loadFileURL:fileUrl allowingReadAccessToURL:parentUrl];
}
- (void)presentDocumentCloud {
    AEGetFile *f = [AEGetFile new];
    [f choosePdfAndPicture];
    f.block = ^(UIImage *icon, NSData *data, NSString *path, NSString *directory) {
        
        self.imageView.image = icon;
        self.path = path;
        self.directory = directory;
    };
    self.f = f;
}
//打开文件APP
//- (void)presentDocumentCloud {
////    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
//    NSArray *documentTypes = @[ @"public.image", @"com.adobe.pdf"];
//
//    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
//    documentPickerViewController.delegate = self;
//    documentPickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:documentPickerViewController animated:YES completion:nil];
//}

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
        self.path = testPath;
        self.directory = testDirectory;
        
        dispatch_sync(dispatch_get_main_queue(), ^{

            // 预览图
            if ([testPath hasSuffix:@".pdf"] || [testPath hasSuffix:@".PDF"]) {
                NSURL *pdfUrl = [NSURL fileURLWithPath:testPath];
                CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL((CFURLRef)pdfUrl);
                self.imageView.image = [self imageFromPDFWithDocumentRef:pdfRef];
                CGPDFDocumentRelease(pdfRef);
            } else {
                self.imageView.image = [UIImage imageWithContentsOfFile:testPath];
            }
            
            
        });
    });

}
                   
// 生成缩略图：
- (UIImage *)imageFromPDFWithDocumentRef:(CGPDFDocumentRef)documentRef
{
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(documentRef, 1);
    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);

    UIGraphicsBeginImageContext(pageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, CGRectGetMinX(pageRect),CGRectGetMaxY(pageRect));
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, -(pageRect.origin.x), -(pageRect.origin.y));
    CGContextDrawPDFPage(context, pageRef);

    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}
@end
