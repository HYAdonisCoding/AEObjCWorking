//
//  AEImageSetViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/1/3.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEImageSetViewController.h"
#import "UIImage+AEBlackAndWhite.h"

@interface AEImageSetViewController ()

@end

@implementation AEImageSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)configUI {
    self.title = @"云端图片";
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/img/flexible/logo/pc/result@2.png"];
    UIImageView *imageView = [self createImageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(150);
    }];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.jd.com/favicon.ico"]];
    //https://github.githubassets.com/favicons/favicon.svg
    //https://www.baidu.com/img/flexible/logo/pc/result@2.png
    
//    imageView.image = [UIImage imageNamed:@"swift_icon"];
    [imageView sd_setImageWithURL:url];
//    [imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        imageView.image = image.grayImage;
//    }];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.backgroundColor = [UIColor yellowColor];
    button.contentMode = UIViewContentModeScaleToFill;
    [button sd_setImageWithURL:[NSURL URLWithString:@"https://www.baidu.com/img/flexible/logo/pc/result@2.png"] forState:(UIControlStateNormal)];
//    [button sd_setImageWithURL:[NSURL URLWithString:@"https://www.baidu.com/img/flexible/logo/pc/result@2.png"] forState:(UIControlStateNormal) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        [button setImage:image.grayImage forState:(UIControlStateNormal)];
//    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.mas_equalTo(0);
    }];
}
//- (void)dealImage:(NSURL *)imageURL imageView:(UIImageView*)imageView {
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imageURL options:(SDWebImageDownloaderHighPriority) progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//
//
//        NSString* key = [[SDWebImageManager sharedManager] cacheKeyForURL:imageURL];
//        BOOL result;
//        [[SDImageCache sharedImageCache] diskImageExistsWithKey:key completion:^(BOOL isInCache) {
//
//        }];
//        NSString* imagePath = [[SDDiskCache alloc] initWithCachePath:<#(nonnull NSString *)#> config:<#(nonnull SDImageCacheConfig *)#> diskImageDataForKey:key];
//        NSData* newData = [NSData dataWithContentsOfFile:imagePath];
//        if (!result || !newData) {
//            BOOL imageIsPng = ImageDataHasPNGPreffixWithData(nil);
//            NSData* imageData = nil;
//            if (imageIsPng) {
//                imageData = UIImagePNGRepresentation(image);
//            }
//            else {
//                imageData = UIImageJPEGRepresentation(image, (CGFloat)1.0);
//            }
//            NSFileManager* _fileManager = [NSFileManager defaultManager];
//            if (imageData) {
//                [_fileManager removeItemAtPath:imagePath error:nil];
//                [_fileManager createFileAtPath:imagePath contents:imageData attributes:nil];
//            }
//        }
//        newData = [NSData dataWithContentsOfFile:imagePath];
//        UIImage* grayImage = nil;
////        if (type == 0) {
////            grayImage = [UIImage imageWithData:newData];
////        }else{
//            UIImage* newImage = [UIImage imageWithData:newData];
////
////            grayImage = [newImage grayscaleWithType:type];
////        }
//        grayImage = [UIImage changeColoursTogray:newImage type:ImageChangeTypeBW];
//        imageView.image = grayImage;
//    }];
//}
- (void)configUI1 {
    self.title = @"本地图片";
    UIImageView *imageView = [self createImageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(100);
    }];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.jd.com/favicon.ico"]];
    //https://github.githubassets.com/favicons/favicon.svg
    //https://www.baidu.com/img/flexible/logo/pc/result@2.png
    
//    imageView.image = [UIImage imageNamed:@"swift_icon"];
    imageView.image = [UIImage changeColoursTogray:[UIImage imageNamed:@"swift_icon"] type:ImageChangeTypeBW];
    
    UIImageView *imageView2 = [self createImageView];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(imageView.mas_height);
    }];
    imageView2.image = [UIImage changeColoursTogray:[UIImage imageNamed:@"swift_icon"] type:ImageChangeTypePink];
    
    UIImageView *imageView3 = [self createImageView];
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView2.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(imageView.mas_height);
    }];
    imageView3.image = [UIImage changeColoursTogray:[UIImage imageNamed:@"swift_icon"] type:ImageChangeTypeBlue];
    
    UIImageView *imageView4 = [self createImageView];
    [imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView3.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(imageView.mas_height);
    }];
    imageView4.image = [UIImage changeColoursTogray:[UIImage imageNamed:@"swift_icon"] type:ImageChangeTypeOrigin];
}



@end
