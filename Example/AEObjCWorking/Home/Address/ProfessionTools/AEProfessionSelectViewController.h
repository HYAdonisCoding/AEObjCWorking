//
//  AEProfessionSelectViewController.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AEProfessionSelectViewController : AEBaseViewController

+ (instancetype)standardView:(NSString *)profession code:(NSString *)code completionHandler:(AEAddressSelectBlock)chooseLocationBlock;
@end

NS_ASSUME_NONNULL_END
