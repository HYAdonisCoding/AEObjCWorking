//
//  AESplashViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/2/1.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import "AESplashViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <SDWebImage/UIImage+GIF.h>

typedef NS_ENUM(NSInteger, AdType) {
    AdTypeNone,// 无开屏
    AdTypeLocalImage,// 本地图片
    AdTypeLocalGIF,// 本地gif
    AdTypeLocalVideo, // 本地视频
    AdTypeRemoteImage,// 网络图片
    AdTypeRemoteGIF,// 网络gif
};

@interface AESplashViewController ()
@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) UIImageView *gifImageView;
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation AESplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"见龙在田"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(self.view.mas_width);
        make.height.mas_lessThanOrEqualTo(self.view.mas_height);
    }];
    
    
    
    AdType type = [self randomAdType];
    
    switch (type) {
        case AdTypeLocalImage:
            [self configImage:NO url:nil];
            break;
        case AdTypeLocalGIF:
            [self configImage:YES url:nil];
            break;
            
        case AdTypeLocalVideo:
            [self configVideo];
            break;
        case AdTypeRemoteImage:
            [self configImage:NO url:@"https://img0.baidu.com/it/u=644879149,398853304&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889"];
            break;
        case AdTypeRemoteGIF:
            [self configImage:YES url:@"https://hbimg.huabanimg.com/c97812249cc7e5a54ce70a38999210bd67a4667921518e-15aymz_fw658"];
            break;
        default:
            [self skipToNextScreen];
            break;
    }
}

- (AdType)randomAdType {
    // 生成一个0到5的随机整数
    NSInteger randomValue = arc4random_uniform(6);
    NSLog(@"randomValue:%ld", (AdType)randomValue);
    switch (randomValue) {
        case 0:
            return AdTypeNone;
        case 1:
            return AdTypeLocalImage;
        case 2:
            return AdTypeLocalGIF;
        case 3:
            return AdTypeLocalVideo;
        case 4:
            return AdTypeRemoteImage;
        case 5:
            return AdTypeRemoteGIF;
        default:
            return AdTypeNone;
    }
}



- (void)configImage:(BOOL)gif url:(NSString *)url {
    UIImage *gifImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bgimage" ofType:@"jpeg"]];
    if (gif) {
        // 创建 UIImageView 并加载 GIF 图片
        NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"RR" ofType:@"gif"];
        NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
        gifImage = [self animatedImageWithAnimatedGIFData:gifData];
    }
    self.gifImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.gifImageView.image = gifImage;
    self.gifImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.gifImageView];
    if (url.length > 0) {
        [self.gifImageView yy_setImageWithURL:[NSURL URLWithString:url] placeholder:nil];
        if (gif) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.gifImageView.image = [UIImage sd_imageWithGIFData:data];
                });
                
            });
        }
        
    }
    
    // 创建 "跳过" 按钮
    self.skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.skipButton.frame = CGRectMake(self.view.bounds.size.width - 80, 40, 60, 30);
    self.skipButton.backgroundColor = [UIColor colorWithString:@"#000000150"];
    self.skipButton.layer.cornerRadius = 10;
    self.skipButton.layer.masksToBounds = YES;
    [self.skipButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.skipButton addTarget:self action:@selector(skipToNextScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.skipButton];
    [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 40));
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
    }];
    // 设置倒计时
    self.countdown = 3;
    [self updateSkipButtonTitle];
    
    // 启动定时器，每秒更新倒计时
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateCountdown)
                                                    userInfo:nil
                                                     repeats:YES];
}


- (void)updateCountdown {
    
    if (self.countdown > 0) {
        NSLog(@"跳过 %ld s", (long)self.countdown);
        
            [self updateSkipButtonTitle];
        
            self.countdown--;
       
    } else {
        // 时间到，跳转到下一个页面
        [self skipToNextScreen];
    }
    
}

- (void)updateSkipButtonTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
    if (self.countdown > 0) {
        [UIView performWithoutAnimation:^{
            [self.skipButton setTitle:[NSString stringWithFormat:@"跳过 %ld s", (long)self.countdown] forState:UIControlStateNormal];
            [self.view layoutIfNeeded]; // 可能需要调用 layoutIfNeeded 以确保立即更新布局
        }];
    } else {
        [UIView performWithoutAnimation:^{
            [self.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
            [self.view layoutIfNeeded]; // 可能需要调用 layoutIfNeeded 以确保立即更新布局
        }];
        
    }
    });
}

- (void)skipToNextScreen {
    // 在这里跳转到你的主界面或其他目标界面
    // 停止并释放计时器
    [self.timer invalidate];
    self.timer = nil;
    NSLog(@"跳转到下一个界面");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startApp" object:nil];
}

// 通过 GIF 数据创建 UIImage
- (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    if (!source) {
        return nil;
    }
    
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    
    for (size_t i = 0; i < count; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (imageRef) {
            [images addObject:[UIImage imageWithCGImage:imageRef]];
            CGImageRelease(imageRef);
        }
    }
    
    CFRelease(source);
    
    if ([images count] > 0) {
        return [UIImage animatedImageWithImages:images duration:([images count] * 0.1)];
    } else {
        return nil;
    }
}

- (void)configVideo {
    // 设置视频文件的 URL
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"video" withExtension:@"mp4"];
    
    // 创建 AVPlayer 对象
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    
    // 创建 AVPlayerLayer 用于显示视频
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    // 添加 AVPlayerLayer 到视图
    [self.view.layer addSublayer:playerLayer];
    
    // 创建 "跳过" 按钮
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    skipButton.frame = CGRectMake(self.view.bounds.size.width - 90 - 20, 20, 90, 40);
    skipButton.backgroundColor = [UIColor colorWithString:@"#000000160"];
    skipButton.layer.cornerRadius = 10;
    skipButton.layer.masksToBounds = YES;
    [skipButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipButton];
    [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 40));
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(20);
    }];
    self.player = player;
    // 注册通知，监听视频播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:player.currentItem];
    
    // 开始播放视频
    [player play];
}

- (void)skipButtonTapped {
    // 处理 "跳过" 按钮点击事件
    NSLog(@"跳过按钮被点击");
    [self.player pause];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startApp" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)videoDidFinish:(NSNotification *)notification {
    // 处理视频播放完成
    NSLog(@"视频播放完成");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startApp" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
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

