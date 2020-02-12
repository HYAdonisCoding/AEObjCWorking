//
//  AEConvenientTool.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AEConvenientTool.h"

@implementation AEConvenientTool

///随机颜色
+ (UIColor *)randomColor {
    
    return [UIColor colorWithRed:[AEConvenientTool randomValue] green:[AEConvenientTool randomValue] blue:[AEConvenientTool randomValue] alpha:1];
}

+ (CGFloat)randomValue {
    
    return arc4random() % 256 / 255.f;
}

///随机汉字
+ (NSMutableString*)randomCreatChinese:(NSInteger)count {
    
    NSMutableString*randomChineseString =@"".mutableCopy;
    
    for(NSInteger i =0; i < count; i++){
        
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
            //随机生成汉字高位
        
        NSInteger randomH =0xA1+arc4random()%(0xFE - 0xA1+1);
        
            //随机生成汉子低位
        
        NSInteger randomL =0xB0+arc4random()%(0xF7 - 0xB0+1);
        
            //组合生成随机汉字
        
        NSInteger number = (randomH<<8)+randomL;
        
        NSData*data = [NSData dataWithBytes:&number length:2];
        
        NSString*string = [[NSString alloc]initWithData:data encoding:gbkEncoding];
        
        [randomChineseString appendString:string];
        
    }
    
    return randomChineseString;
    
}

#pragma mark - 排序
+ (void)sortWithDataArray:(NSArray *)dataArray sectionArray:(NSArray **)sectionArray sectionTitlesArray:(NSArray **)sectionTitlesArray propertyName:(NSString *)propertyName {
    
    ///1.UILocalizedIndexedCollation进行初始化
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    //获取collation索引
    NSUInteger sectionNumber = [[collation sectionTitles] count];
    NSMutableArray *section = [[NSMutableArray alloc] init];
    //    循环索引，初始化空数组并加入到数据数组
    for (NSInteger index = 0; index < sectionNumber; index++) {
        [section addObject:[[NSMutableArray alloc] init]];
    }
    //1.遍历数组中的元素
    for (id model in dataArray) {
        //2.获取name值的首字母在26个字母中所在的位置
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:NSSelectorFromString(propertyName)];
        //3.把model对象加到相对应的字母下的数组中去
        [section[sectionIndex] addObject:model];
    }
    
    //对每个section中的数组按照name属性进行检索排序（快速索引）
    for(NSInteger index=0; index<sectionNumber;index++){
        //1.获取每个section下的数组
        NSMutableArray *personArrayForSection = section[index];
        //2.对每个section下的数组进行字母排序
        NSArray *sortedPersonArrayForSection = [collation sortedArrayFromArray:personArrayForSection collationStringSelector:NSSelectorFromString(propertyName)];
        section[index] = sortedPersonArrayForSection;
    }
    
// 新建一个temp空的数组（目的是为了在调用enumerateObjectsUsingBlock函数的时候把空的数组添加到这个数组里，在将数据源空数组移除，或者在函数调用的时候进行判断，空的移除）
    NSMutableArray *temp = [NSMutableArray new];
    NSMutableArray *titles = [NSMutableArray new];
    [section enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.count == 0) {
            [temp addObject:obj];
        } else {
            [titles addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [section removeObjectsInArray:temp];
    *sectionArray = section;
    *sectionTitlesArray = titles.copy;
}


@end
