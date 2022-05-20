//
//  AEGifViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/5/19.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEGifViewController.h"


@interface AEGifViewController ()

@end

@implementation AEGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
