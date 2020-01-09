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
#import "AEDynamicLabel/AEDynamicLabel.h"
#import "UI_Component/UIFont+AEFonts.h"
#import "UI_Component/NSString+AELabelWidthAndHeight.h"
#import "UI_Component/UIView+AEGlowView.h"

@interface AEViewController () <AEDynamicLabelDelegate>

@end

@implementation AEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor magentaColor];
    AEDynamicLabel *label = [[AEDynamicLabel alloc] initWithFrame:CGRectMake(100, 100, 150, 30)];
    label.layer.borderColor = [UIColor grayColor].CGColor;
    label.layer.borderWidth = .5f;
    [label addContentView:[self createLabelWithText:@"1.我不想说再见,不说再见,越长大越孤单" textColor:[AEConvenientTool randomColor]]];
    label.backgroundColor = [AEConvenientTool randomColor];
    label.speed = .5f;

    label.direction = AEDynamicDirectionLeft;
    [self.view addSubview:label];
    [label startDynamicAnimation];
    
    AEDynamicLabel *dyamicLabel = [[AEDynamicLabel alloc] initWithFrame:CGRectMake(100, 200, 150, 30)];
    dyamicLabel.layer.borderColor = [UIColor grayColor].CGColor;
    dyamicLabel.layer.borderWidth = .5f;
    dyamicLabel.backgroundColor = [AEConvenientTool randomColor];
    dyamicLabel.speed = .5f;
    
    dyamicLabel.direction = AEDynamicDirectionLeft;
    dyamicLabel.text = @"2.我不想说再见,不说再见,越长大越孤单";
    dyamicLabel.textColor = [AEConvenientTool randomColor];
    dyamicLabel.font  = [UIFont HeitiSCWithFontSize:14.f];
    [self.view addSubview:dyamicLabel];
    
    [dyamicLabel startDynamicAnimation];
}

- (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor {

    NSString *string = [NSString stringWithFormat:@" %@ ", text];
    CGFloat   width  = [string widthWithStringAttribute:@{NSFontAttributeName : [UIFont HeitiSCWithFontSize:14.f]}];
    UILabel  *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    label.font       = [UIFont HeitiSCWithFontSize:14.f];
    label.text       = string;
    label.textColor  = textColor;

    label.glowRadius            = @(2.f);
    label.glowOpacity           = @(1.f);
    label.glowColor             = [textColor colorWithAlphaComponent:0.86];
    label.glowDuration          = @(1.f);
    label.hideDuration          = @(3.f);
    label.glowAnimationDuration = @(2.f);
    [label createGlowLayer];
    [label insertGlowLayer];
    [label startGlowLoop];

    return label;
}

#pragma mark - AEDynamicLabelDelegate
- (void)drawDynamicLabel:(AEDynamicLabel *_Nullable)dynamicLabel animationDidStopFinished:(BOOL)finished {
    [dynamicLabel stopAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [dynamicLabel addContentView:[self createLabelWithText:[AEConvenientTool randomCreatChinese:20]  textColor:[AEConvenientTool randomColor]]];
        [dynamicLabel startDynamicAnimation];
    });
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
