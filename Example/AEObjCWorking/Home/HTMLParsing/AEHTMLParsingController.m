//
//  AEHTMLParsingController.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/2/26.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AEHTMLParsingController.h"
#import "AEHTMLParsingTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"

@interface AEHTMLParsingController ()

@end

@implementation AEHTMLParsingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /// 天津市第一中心医院 王毅 http://zgcx.nhc.gov.cn:9090/doctor
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath =[resourcePath stringByAppendingPathComponent:@"index.html"];
    NSData  * data      = [NSData dataWithContentsOfFile:filePath];
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://zgcx.nhc.gov.cn:9090/Doctor/Details/238c3321ad044739a247f805ecb1b3eb-637183102281880140-9D8D6A8996B89CE0F47D765D5271DCAB"]];
    NSString *result = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];   //data转字符串 为了打印不是乱码
    NSLog(@"------%@",result);
    
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray * elements  = [doc searchWithXPathQuery:@"//div"];
    //[doc searchWithXPathQuery:@"//div[@class='row']"]
//    TFHppleElement * element = [elements objectAtIndex:0];
//    [element text];                       // The text inside the HTML element (the content of the first text node)
//
//    [element tagName];                    // "a"
//    [element attributes];                 // NSDictionary of href, class, id, etc.
//    [element objectForKey:@"href"];       // Easy access to single attribute
//    [element firstChildWithTagName:@"b"]; // The first "b" child node
    BOOL __block search = NO;
    NSString __block *resultNum = @"";
    [elements enumerateObjectsUsingBlock:^(TFHppleElement * _Nonnull element, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"text:%@,tagName:%@,attributes:%@", [element text], [element tagName], [element attributes]);
        if ([[element raw] containsString:@"链接无效"]) {
            *stop = YES;
            NSLog(@"亲 %@", @"链接无效");
        }
        if (search) {
            resultNum = [element text];
            *stop = YES;
        }
        if ([[element text] isEqualToString:@"执业证书编码："]) {
            search = YES;
        }
    }];
    NSLog(@"结果: %@", resultNum);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
