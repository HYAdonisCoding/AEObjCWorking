//
//  AEUnconventionalViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/4/25.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEUnconventionalViewController.h"
#import "AETrialViewController.h"
#import "AEWaveSegmentedControl.h"
#import "AEWaveView.h"

@interface AEUnconventionalViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) AETrialViewController *firstVC;
@property (nonatomic, strong) UIViewController *secondVC;
@end

@implementation AEUnconventionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.segmentedControl = [[AEWaveSegmentedControl alloc] initWithItems:@[@"Trial", @"Second"]];
    self.segmentedControl.frame = CGRectMake(0, 60, 240, 30);
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = 0;
    // 将 UISegmentedControl 设置为导航栏的 titleView
    self.navigationItem.titleView = self.segmentedControl;
    
    self.firstVC = [[AETrialViewController alloc] init];
    self.secondVC = [[UIViewController alloc] init];
    self.secondVC.view.backgroundColor = [UIColor yellowColor];
    
    [self addChildViewController:self.firstVC];
    self.firstVC.view.frame = CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height - 90);
    [self.view addSubview:self.firstVC.view];
    [self.firstVC didMoveToParentViewController:self];
    
    self.currentViewController = self.firstVC;
}
- (void)segmentChanged:(UISegmentedControl *)sender {
    UIViewController *newViewController;
    switch (sender.selectedSegmentIndex) {
        case 0:
            newViewController = self.firstVC;
            break;
        case 1:
            newViewController = self.secondVC;
            break;
        default:
            break;
    }
    
    [self.currentViewController willMoveToParentViewController:nil];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];
    
    [self addChildViewController:newViewController];
    newViewController.view.frame = CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height - 90);
    [self.view addSubview:newViewController.view];
    [newViewController didMoveToParentViewController:self];
    
    self.currentViewController = newViewController;

}


@end
