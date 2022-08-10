//
//  AEEventViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEEventViewController.h"
#import "AECustomButton.h"

@interface AEEventViewController () {
    AECustomButton *cornerButton;
}

@end

@implementation AEEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cornerButton = [[AECustomButton alloc] initWithFrame:CGRectMake(100, 100, 120, 120)];
    cornerButton.backgroundColor = [UIColor blueColor];
    [cornerButton addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cornerButton];
    
    AECustomButton *myButton = [[AECustomButton alloc] initWithFrame:CGRectZero];
    myButton.backgroundColor = [UIColor orangeColor];
    [myButton addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    [myButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.right.mas_equalTo(-20);
    }];
}

- (void)doAction:(id)sender{
    NSLog(@"click");
}


@end
