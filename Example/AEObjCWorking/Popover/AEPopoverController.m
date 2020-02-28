//
//  AEPopoverController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEPopoverController.h"

@interface AEPopoverController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation AEPopoverController

#pragma mark -- UIPopoverPresentationControllerDelegate
/** 要让弹出效果在iPhone下生效,必须实现此方法 */
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}
#pragma mark -- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置弹出后的大小 */
    self.preferredContentSize = self.contentSize;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (instancetype)initWithSourceView:(UIView *)sourceView bySourceRect:(CGRect)sourceRect andContentSize:(CGSize)contentSize andDirection:(UIPopoverArrowDirection)direction {
    self = [super init];
    if (self) {
        _sourceRect = sourceRect;
        _sourceView = sourceView;
        _contentSize = contentSize;
        _direction = direction;
        /** 设置当前控制器的弹出方式是:UIModalPresentationPopover */
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.permittedArrowDirections = _direction;
        self.popoverPresentationController.delegate = self;
        self.popoverPresentationController.sourceView = _sourceView;
        self.popoverPresentationController.sourceRect = _sourceRect;
    }
    return self;
}
@end
