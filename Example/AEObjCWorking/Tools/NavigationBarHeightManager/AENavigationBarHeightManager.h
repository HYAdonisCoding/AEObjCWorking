//
//  AENavigationBarHeightManager.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/11/3.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AENavigationBarHeightManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, readonly) CGFloat navigationBarHeightWithSafeArea;

- (CGFloat)bottomSafeAreaHeight;

@end

NS_ASSUME_NONNULL_END
