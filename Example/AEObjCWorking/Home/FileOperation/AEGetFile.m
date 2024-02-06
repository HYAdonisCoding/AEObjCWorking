//
//  AEGetFile.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/3/1.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEGetFile.h"
@interface AEGetFile()<UIDocumentPickerDelegate>

@end

@implementation AEGetFile
/// 选择PDF或图片
- (void)choosePdfAndPicture {
//    NSDictionary *p = self.curData[@"data"][@"Params"];
//    // 0 照片 1 pdf
//    NSString *type = [p safeStringForKey:@"chooseType"];
//    if ([type isEqualToString:@"0"]) {
//        [self takeImageForPhotoAlbum];
//    } else if ([type isEqualToString:@"1"]) {
//        // PDF
//    }
    [self choosePDFFile];
}
#pragma mark - 选择PDF文件
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    NSLog(@"%@", @"documentPickerWasCancelled");
}
// 选择文件App中的pdf文件
- (void)choosePDFFile {
    NSArray *documentTypes = @[@"com.adobe.pdf"];

    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    documentPickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:documentPickerViewController animated:YES completion:nil];

}
#pragma mark - UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    //获取授权
    BOOL fileUrlAuthozied = [url startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        //通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;

        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
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
                NSLog(@"fileData --- %@",fileData);
                
            }
            [controller dismissViewControllerAnimated:YES completion:^{
                [self fileWithURL:newURL data:fileData fileName:fileName];
            }];
        }];
        [url stopAccessingSecurityScopedResource];
    } else {
        //授权失败
//        [self showError:@"授权失败"];
        NSLog(@"%@", @"授权失败");
    }
}
//- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
//    //获取授权
//    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
//    if (fileUrlAuthozied) {
//        //通过文件协调工具来得到新的文件地址，以此得到文件保护功能
//        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
//        NSError *error;
//
//        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
//            //读取文件
//            NSString *fileName = [newURL lastPathComponent];
//            NSError *error = nil;
//            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
//            if (error) {
//                //读取出错
////                [self showError:@"读取出错"];
//                NSLog(@"%@", @"读取出错");
//            } else {
//                //上传
////                NSLog(@"fileData --- %@",fileData);
////                [self uploadingWithFileData:fileData fileName:fileName fileURL:newURL];
//                [self fileWithURL:newURL data:fileData fileName:fileName];
//            }
//            [controller dismissViewControllerAnimated:YES completion:NULL];
//        }];
//        [urls.firstObject stopAccessingSecurityScopedResource];
//    } else {
//        //授权失败
////        [self showError:@"授权失败"];
//        NSLog(@"%@", @"授权失败");
//    }
//}

- (void)fileWithURL:(NSURL *)url data:(NSData *)data fileName:(NSString *)fileName {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        //下载PDF到本地 使用同步下载方法，
        NSData *doubi = data;
        //  二进制流写入文件
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)lastObject];

        NSFileManager *fileManger = [NSFileManager defaultManager];
        NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent: @"pdf"];

        //  创建目录
        [fileManger createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        //  创建文件
        NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
        //  写入文件

        [fileManger createFileAtPath:testPath contents:doubi attributes:nil];
        
    
            // 预览图
        if ([testPath hasSuffix:@".pdf"] || [testPath hasSuffix:@".PDF"]) {
            NSURL *pdfUrl = [NSURL fileURLWithPath:testPath];
            CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL((CFURLRef)pdfUrl);
            // 缩率图
            UIImage *iconImage = [self imageFromPDFWithDocumentRef:pdfRef];
            CGPDFDocumentRelease(pdfRef);
            if (self.block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.block(iconImage, data, testPath, testDirectory);
                });
            }
        }
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
