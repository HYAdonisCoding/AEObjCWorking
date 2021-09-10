//
//  AEAddressSelectView.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/9/9.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AEAddressSelectBlock)(NSString * _Nullable titleAddress, NSString * _Nullable titleID);

NS_ASSUME_NONNULL_BEGIN

@protocol  AEAddressSelectViewDelegate <NSObject>
-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID;
@end

@interface AEAddressSelectView : UIView

@property (nonatomic, weak) id<AEAddressSelectViewDelegate> delegate;

@property (nonatomic, assign) NSUInteger defaultHeight;

@property (nonatomic, assign) CGFloat titleScrollViewH;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray *titleIDMarr;

@property (nonatomic, strong) UIView *addAddressView;

@property (nonatomic, assign) BOOL isChangeAddress; //这个属性如果是新增地址的时候设置成false

- (UIView *)initAddressView;

- (void)addAnimate;

- (void)addAnimateCompationHandler:(AEAddressSelectBlock)compationHandler;

@end

NS_ASSUME_NONNULL_END
