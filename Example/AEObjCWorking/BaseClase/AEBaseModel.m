//
//  AEBaseModel.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEBaseModel.h"
#import <objc/runtime.h>

@implementation AEBaseModel

- (NSString *)getSelfPropertyAndValue {
    NSMutableString *string = [NSMutableString string];
        //  取得当前类类型
    Class cls = [self class];
    unsigned int ivarsCnt = 0;
        //　获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
        //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p) {
        Ivar const ivar = *p;
        
            //　获取变量名
        NSString *key = [[NSString alloc ]initWithUTF8String:ivar_getName(ivar)];
            // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
            // 比如 @property(retain) NSString *abc;则 key == _abc;
        
            //　获取变量值
        id value = [self valueForKey:key];
        
            //　取得变量类型
            // 通过 type[0]可以判断其具体的内置类型
            //const char *type = ivar_getTypeEncoding(ivar);
        
        if (value == nil)
            {
            value = @"";
            }
        
        [string appendString: [NSString stringWithFormat:@", \\%@ : %@\\",key,value]];
    }
    free(ivars);
    
    return [NSString stringWithString:string];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"< %@ >",[[self getSelfPropertyAndValue] substringFromIndex:1]];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"< %@: %p, %@ >", [self class], self, [self getSelfPropertyAndValue]];
}

@end
