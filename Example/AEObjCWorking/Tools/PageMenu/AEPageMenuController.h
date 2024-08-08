//
//  AEPageMenuController.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/7/24.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

@import Foundation;
@import UIKit;
@class AEPageMenuController, AEMenuItem, AEPageMenuItem;;

typedef NS_ENUM(NSInteger, AEPageMenuControllerStyle) {
  AEPageMenuControllerStylePlain,    // like NewsPass
  AEPageMenuControllerStyleTab,    // like Gunosy
  AEPageMenuControllerStyleSmartTab,    // like SmartNews
  AEPageMenuControllerStyleHackaTab    // like Hackadoll
};

// 定义协议
@protocol AEPageMenuControllerDelegate <NSObject>

@optional
// 在页面切换操作进行之前调用
- (void)pageMenuController:(AEPageMenuController *)pageMenuController willMoveToViewController:(UIViewController *)viewController atMenuIndex:(NSInteger)menuIndex;


// 在页面切换完成时调用
- (void)pageMenuController:(AEPageMenuController *)pageMenuController didMoveToViewController:(UIViewController *)viewController atMenuIndex:(NSInteger)menuIndex;


// 在菜单项创建等完成时调用
- (void)pageMenuController:(AEPageMenuController *)pageMenuController didPrepareMenuItems:(NSArray<AEPageMenuItem *> *)menuItems;

// 在菜单项被点击时调用
- (void)pageMenuController:(AEPageMenuController *)pageMenuController didSelectMenuItem:(AEPageMenuItem *)menuItem atMenuIndex:(NSInteger)menuIndex;

@end



@interface AEPageMenuController : UIViewController

@property (nonatomic,weak) id <AEPageMenuControllerDelegate>    delegate;

@property (nonatomic,readonly) AEPageMenuControllerStyle    menuStyle;

@property (nonatomic,strong,readonly) NSArray *    titles;
@property (nonatomic,strong,readonly) NSArray *    childControllers;
@property (nonatomic,strong,readonly) NSArray *    menuColors;

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers
             menuStyle:(AEPageMenuControllerStyle)menuStyle
            menuColors:(NSArray<UIColor *> *)menuColors
              topBarHeight:(CGFloat)topBarHeight;

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)controllers
             menuStyle:(AEPageMenuControllerStyle)menuStyle
              topBarHeight:(CGFloat)topBarHeight;

-(void)setMenuSeparatorColor:(UIColor *)color;
-(void)setMenuIndicatorColor:(UIColor *)color;
/// 获取顶部导航
- (UIScrollView *)getTheScrollView;
@end


@interface AEMenuItem : NSObject
@property (nonatomic,copy) NSString *    title;    // set automatically
@property (nonatomic,assign) NSInteger    tag;    // default: 0
@property (nonatomic,copy) NSString *    badgeValue; // default: nil
@property (nonatomic,strong) UIColor *    titleColor; // set automatically
@property (nonatomic,strong) UIColor *    backgroundColor; // set automatically
@property (nonatomic,strong) UIColor *    borderColor; // set automatically
@property (nonatomic,getter=isEnabled) BOOL    enabled; // default: YES
@property (nonatomic,readonly,getter=isSelected) BOOL    selected; // default: NO
@property (nonatomic,readonly) AEPageMenuControllerStyle    menuStyle;
@end
