//
//  AEViewController.m
//  AEObjCWorking
//
//  Created by HYAdonisCoding on 04/25/2019.
//  Copyright (c) 2019 HYAdonisCoding. All rights reserved.
//

#import "AEViewController.h"
#import <AEAuthenticeTool.h>
#import "AECustomOptioinViewController.h"

@interface AEViewController ()

@end

@implementation AEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    self.view.backgroundColor = [UIColor magentaColor];
}

- (IBAction)editActiion:(UIBarButtonItem *)sender {
    AECustomOptioinViewController *vc = [AECustomOptioinViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [AEAuthenticeTool authenticatedByBiometryOrDevicePasscodeCompletionHandlers:^(BOOL success, HYAuthenticationVerifyType type, NSString * _Nullable descString, NSError * _Nullable error) {
        NSString *typeStr = @"";
        
        switch (type) {
            case HYAuthenticationVerifyTypeFaceID:
                typeStr = @"FaceID";
                break;
            case HYAuthenticationVerifyTypeTouchID:
                typeStr = @"TouchID";
                break;
            case HYAuthenticationVerifyTypeSecretCode:
                typeStr = @"SecretCode";
                break;
            case HYAuthenticationVerifyTypeNullID:
                typeStr = @"NullID";
                break;
        }
        
        NSString *message = [NSString stringWithFormat:@"%@ - 验证成功", typeStr];
        NSString *title = @"恭喜您";
        if (success) {
            
            
        } else {
            message = [NSString stringWithFormat:@"%@ - 验证失败 - %@", typeStr, descString];
            title = @"对不起";
        }
        
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
        
        [vc addAction:[UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
