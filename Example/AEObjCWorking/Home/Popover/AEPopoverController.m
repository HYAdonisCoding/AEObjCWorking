//
//  AEPopoverController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/28.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEPopoverController.h"

@interface AEPopoverController ()<UIPopoverPresentationControllerDelegate>

/// 背景
@property (nonatomic,strong) UIVisualEffectView *visualView;

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

//presentationTransitionWillBegin 是在呈现过渡即将开始的时候被调用的。我们在这个方法中把半透明黑色背景 View 加入到 containerView 中，并且做一个 alpha 从0到1的渐变过渡动画。
- (void)presentationTransitionWillBegin {
    
    // 使用UIVisualEffectView实现模糊效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
    _visualView.frame = self.view.bounds;
    _visualView.alpha = 0.4;
    _visualView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_visualView];
}

//presentationTransitionDidEnd: 是在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成。在我们的例子中，我们可以使用它在过渡效果已结束但没有完成时移除半透明的黑色背景 View。
- (void)presentationTransitionDidEnd:(BOOL)completed {
    
    // 如果呈现没有完成，那就移除背景 View
    if (!completed) {
        [_visualView removeFromSuperview];
    }
}

//以上就涵盖了我们的背景 View 的呈现部分，我们现在需要给它添加淡出动画并且在它消失后移除它。正如你预料的那样，dismissalTransitionWillBegin 正是我们把它的 alpha 重新设回0的地方。
- (void)dismissalTransitionWillBegin {
    _visualView.alpha = 0.0;
}

//我们还需要在消失完成后移除背景 View。做法与上面 presentationTransitionDidEnd: 类似，我们重载 dismissalTransitionDidEnd: 方法
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [_visualView removeFromSuperview];
    }
}
@end
