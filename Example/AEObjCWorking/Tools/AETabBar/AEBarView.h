//
//  AEBarView.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/11/1.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEBarView : UIView

/*初始化按钮*/
-(void)initButtonWithViewControllers:(NSArray<UIViewController *> * )viewControllers;
/*最大图片尺寸*/
@property (nonatomic,assign) CGSize maxImageSize;
/*最小图片尺寸*/
@property (nonatomic,assign) CGSize minImageSize;
/*文字颜色*/
@property (nonatomic,strong) UIColor *titleColor;
/*选中的文字颜色*/
@property (nonatomic,strong) UIColor *selectedTitleColor;
/*点击*/
@property (nonatomic,strong) void(^selectBlock)(NSInteger index);
@property (nonatomic, assign) NSInteger selectIndex;

/*中间是否有按钮*/
@property (nonatomic,assign) BOOL haveCenterButton;
/*中间图片*/
@property (nonatomic,copy) UIImage *centerImage;
/*点击中间*/
@property (nonatomic,strong) void(^selectCenterBlock)(void);

@end

NS_ASSUME_NONNULL_END
