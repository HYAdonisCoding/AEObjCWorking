//
//  AEProfessionModel.h
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/24.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEProfessionModel : NSObject
/// 三级列表
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end

@interface AEProfessionSubModel : NSObject
/// 二级列表
@property (nonatomic, copy) NSString *profession2;
@property (nonatomic, copy) NSString *code2;
@property (nonatomic, copy) NSArray<AEProfessionModel *> *professionList;

@end

@interface AEProfessionSumModel : NSObject
/// 一级列表
@property (nonatomic, copy) NSString *profession1;
@property (nonatomic, copy) NSString *code1;
@property (nonatomic, copy) NSArray<AEProfessionSubModel *> *subProfession;

@end

@interface AEProfessionSearchModel : NSObject
@property (nonatomic, copy) NSString *code1;
@property (nonatomic, copy) NSString *profession1;
@property (nonatomic, copy) NSString *code2;
@property (nonatomic, copy) NSString *profession2;
@property (nonatomic, copy) NSString *code3;
@property (nonatomic, copy) NSString *profession3;
@property (nonatomic, copy) NSString *mark;

@end
NS_ASSUME_NONNULL_END
