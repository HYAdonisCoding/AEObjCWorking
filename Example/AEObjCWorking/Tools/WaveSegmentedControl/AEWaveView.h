//
//  AEWaveView.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2024/7/23.
//  Copyright © 2024 HYAdonisCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEWaveView : UIView
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveFrequency;
- (void)startAnimating;
@end

NS_ASSUME_NONNULL_END
