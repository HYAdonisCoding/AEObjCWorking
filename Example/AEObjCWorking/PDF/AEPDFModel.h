//
//  AEPDFModel.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/6/2.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEPDFModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) BOOL readed;
@property (nonatomic, assign) BOOL scrollBottom;

@property (nonatomic, assign) BOOL timing;


- (instancetype)initWithName:(NSString *)name
                        path:(NSString *)path
                      readed:(BOOL)readed;
@end

NS_ASSUME_NONNULL_END
