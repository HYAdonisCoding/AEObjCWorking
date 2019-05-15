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
@end
