//
//  AEIndexedTableView.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2021/3/29.
//  Copyright © 2021 HYAdonisCoding. All rights reserved.
//

#import "AEIndexedTableView.h"
#import "AEReusePool.h"

@interface AEIndexedTableView()
{
    UIView *containerView;
    AEReusePool *reusePool;
    NSArray *indexDataArray;
}

@end

@implementation AEIndexedTableView

- (void)reloadData {
    [super reloadData];
    /// 懒加载
    if (containerView == nil) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor whiteColor];
        
        /// 避免索引条随tableView滚动
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    
    if (reusePool == nil) {
        reusePool = [[AEReusePool alloc] init];
    }
    
    /// 标记所有视图为可重用状态
    [reusePool reset];
    
    /// reload字母索引条
    [self reloadIndexBar];
}

- (void)reloadIndexBar {
    // 获取字母索引条的显示内容
    // 获取字母索引条的显示内容
    NSArray <NSString *> *arrayTitles = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
        arrayTitles = [self.indexedDataSource indexTitlesForIndexTableView:self];
        indexDataArray = arrayTitles;
    }
    
    // 判断字母索引条是否为空
    if (!arrayTitles || arrayTitles.count <= 0) {
        [containerView setHidden:YES];
        return;
    }
    
    NSUInteger count = arrayTitles.count;
    CGFloat buttonWidth = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    
    for (int i = 0; i < [arrayTitles count]; i++) {
        NSString *title = [arrayTitles objectAtIndex:i];
        
        // 从重用池当中取一个Button出来
        UIButton *button = (UIButton *)[reusePool dequeueReusableView];
        // 如果没有可重用的Button重新创建一个
        if (button == nil) {
            button = [[UIButton alloc] initWithFrame:CGRectZero];
            button.backgroundColor = [UIColor whiteColor];
            
            // 注册button到重用池当中
            [reusePool addUsingView:button];
            NSLog(@"新创建一个Button");
        }
        else{
            NSLog(@"Button 重用了");
        }
        
        // 添加button到父视图控件
        [containerView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置button的坐标
        [button setFrame:CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight)];
        [button addTarget:self action:@selector(changeSection:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    [containerView setHidden:NO];
    containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWidth, self.frame.origin.y, buttonWidth, self.frame.size.height);
}

- (void)changeSection:(UIButton *)btn {
    // 获取字母索引条的显示内容
    NSInteger section = -1;
    if (indexDataArray.count) {
        section = [indexDataArray indexOfObject:btn.currentTitle];
        if (section > indexDataArray.count) {
            section = -1;
        }
    }
    
    if (self.indexedDataSource && [self.indexedDataSource respondsToSelector:@selector(didSelectSectionAt:forTitle:)]) {
        [self.indexedDataSource didSelectSectionAt:section forTitle:btn.currentTitle];
    }
}

@end
