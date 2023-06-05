//
//  AEGPTViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/3/23.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AEGPTViewController.h"

@interface AEGPTViewController ()
/// <#Description#>
@property (nonatomic, strong) NSURLSessionDataTask *task;
/// <#Description#>
@property (nonatomic, strong) UITextView *textView;
@end

@implementation AEGPTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.left.right.mas_equalTo(0);
    }];
    
    [self getData];
}

- (void)getData {
    
    // 创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.openai.com/v1/engines/davinci-codex/completions"]];
    request.HTTPMethod = @"POST";

    // 添加请求标头
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"Bearer https://api.openai.com/v1/engines/davinci-codex/completions" forHTTPHeaderField:@"Authorization"];

    // 创建请求体
    NSDictionary *body = @{@"prompt": @"Hello AI!",
                           @"max_tokens": @1024,
                           @"temperature": @0.7};
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:body options:0 error:nil];
    request.HTTPBody = bodyData;
    request.timeoutInterval = 15;

    // 创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];

    // 创建任务对象
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }

        // 处理响应数据
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@"Error parsing JSON: %@", error);
        } else {
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                // Do something with the dictionary
            } else if ([jsonObject isKindOfClass:[NSArray class]]) {
                NSArray *jsonArray = (NSArray *)jsonObject;
                // Do something with the array
            }
            self.textView.text = [jsonObject yy_modelToJSONString];
        }
    }];

    // 启动任务
    [task resume];

    self.task = task;
}

@end
