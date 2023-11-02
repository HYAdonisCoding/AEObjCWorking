//
//  AEBaseViewController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEBaseViewController.h"

@interface AEBaseViewController ()

@end

@implementation AEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", self.class);
    [self configUI];
    [self configEvent];
}

- (void)configUI {
    
}

- (void)configEvent {
    
}

- (void)dealloc {
    NSLog(@"%@", self.class);
}


- (UIImageView *)createImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView];
    return imageView;
}

- (NSString *)testString {
    return @"BaseViewController";
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
