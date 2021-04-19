//
//  AEGCDViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/17.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEGCDViewController.h"
#import "AEUserCenter.h"


@interface AEGCDViewController () {
    AEUserCenter *center;
}

@end

@implementation AEGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    center = [[AEUserCenter alloc] init];
    
    for (int i = 0; i < 100; i++) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [center AE_setObject:@(i) forKey:[NSString stringWithFormat:@"%d", i]];
            NSLog(@"%@", [NSString stringWithFormat:@"%d", i]);

    });
    }
    for (int i = 0; i < 100; i++) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [center AE_setObject:@(i) forKey:[NSString stringWithFormat:@"%03d", i]];
            NSLog(@"%@", [NSString stringWithFormat:@"%03d", i]);
    });
    }
    NSLog(@"%@", center);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"%@", [center AE_objectForKey:[NSString stringWithFormat:@"%d", i]]);
        }
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"%@", [center AE_objectForKey:[NSString stringWithFormat:@"%03d", i]]);

        }
    });
    NSLog(@"%@", center);
}

@end
