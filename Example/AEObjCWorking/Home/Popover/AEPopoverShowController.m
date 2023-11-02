//
//  AEPopoverShowController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEPopoverShowController.h"
#import "AEPopSheetController.h"

@interface AEPopoverShowController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation AEPopoverShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"环境" style:(UIBarButtonItemStyleDone) target:self action:@selector(filter:)];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 100, 40)];
    textfield.placeholder = @"请输入邮箱";
    [self.view addSubview:textfield];
    [textfield addTarget:self action:@selector(filter:) forControlEvents:(UIControlEventEditingChanged)];
    UITextField *textfield2 = [[UITextField alloc] initWithFrame:CGRectMake(100, SCREEN_HEIGHT/2, 100, 40)];
    textfield2.placeholder = @"请输入邮箱";
    [self.view addSubview:textfield2];
    [textfield2 addTarget:self action:@selector(filter:) forControlEvents:(UIControlEventEditingChanged)];
    
    UITextField *textfield1 = [[UITextField alloc] initWithFrame:CGRectMake(100, SCREEN_HEIGHT - 120, 100, 40)];
    textfield1.placeholder = @"请输入邮箱";
    [self.view addSubview:textfield1];
    [textfield1 addTarget:self action:@selector(filter:) forControlEvents:(UIControlEventEditingChanged)];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"环境" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor magentaColor] forState:(UIControlStateNormal)];
    button.frame = CGRectMake(100, 100, 100, 40);
    button.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(filter:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10.0f, 230.0f, 50.0f, 30.0f);
    [button1 setTitle:@"菜单" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor orangeColor]];
    [button1 addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(20, CGRectGetMaxY(self.view.bounds) - 100, 150.0f, 30.0f);
    [button2 setTitle:@"菜单" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor orangeColor]];
    [button2 addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(SCREEN_WIDTH - 120, 230.0f, 50.0f, 30.0f);
    [button3 setTitle:@"菜单" forState:UIControlStateNormal];
    [button3 setBackgroundColor:[UIColor orangeColor]];
    [button3 addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

- (void)filter:(id)sender {
    UIView *view;
    CGRect rect;
    if (![sender isKindOfClass:[UIView class]]) {
        view = self.navigationController.view;
        rect = CGRectMake(SCREEN_WIDTH - 100, 0, 100, 100);
    } else {
        view = sender;
        rect = CGRectMake(CGRectGetMidX(view.bounds), CGRectGetMaxY(view.bounds), 0, 5);
    }
    NSArray *data = @[@"@163.com",
                      @"@126.com",
                      @"@qq.com",
                      @"@sina.com",
                      @"@sina.com.cn",
                      @"@sohu.com",
                      @"@yahoo.com.cn"
    ];
    AEPopSheetController *vc = [[AEPopSheetController alloc] initWithSourceView:view datas:data contentWidth:120.f andDirection:(UIPopoverArrowDirectionLeft) completionHandler:^(NSInteger index, id  _Nonnull object) {
        NSLog(@"选中了 %d - %@", index, object);
        if ([object isKindOfClass:[NSString class]]) {
            if ([sender isKindOfClass:[UIButton class]]) {
                [((UIButton *)sender) setTitle:(NSString *)object forState:(UIControlStateNormal)];
            } else if ([sender isKindOfClass:[UIBarButtonItem class]]) {
                [((UIBarButtonItem *)sender) setTitle:(NSString *)object];
            } else if ([sender isKindOfClass:[UITextField class]]) {
                UITextField *text = sender;
                text.text = [text.text stringByAppendingString:(NSString *)object];
            }
        }
    }];
    vc.textColor = [UIColor magentaColor];
//    vc.backViewColor = [UIColor lightGrayColor];
    vc.scrollable = YES;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}


@end
