//
//  AECustomOptionView.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2019/4/30.
//  Copyright © 2019 HYAdonisCoding. All rights reserved.
//

#import "AECustomOptionView.h"
#import "AEAECustomOptionCell.h"
#import "AECustomOptionModel.h"
#import "AECustomViewFlowLayout.h"

@interface AECustomOptionView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AECustomOptionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame
            ];
    if (self) {
        
    }
    return self;
}


+ (instancetype)sharedWithDataArray:(NSArray *)dataArray frame:(CGRect)frame {
    return [[AECustomOptionView alloc] initWithDataArray:dataArray frame:frame];
}

- (instancetype)initWithDataArray:(NSArray *)dataArray frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = dataArray;
        [self makeInterface];
    }
    return self;
}

- (void)makeInterface {
    
    CGRect collectionViewFrame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    AECustomViewFlowLayout *flowLayout = [[AECustomViewFlowLayout alloc] initWithType:(AEAlignmentFlowLayoutTypeLeft) cellSpace:8.0f];
        // 设置UICollectionView为横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//UICollectionViewScrollDirectionHorizontal;
        // 每一行cell之间的间距
    flowLayout.minimumLineSpacing = 2;
        // 每一列cell之间的间距
    flowLayout.minimumInteritemSpacing = 2;
        // 设置第一个cell和最后一个cell,与父控件之间的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 2;// 根据需要编写
    flowLayout.minimumInteritemSpacing = 2;// 根据需要编写
    
        // 该行代码就算不写,item也会有默认尺寸
    flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
    
    UIView *backView = [[UIView alloc] initWithFrame:collectionViewFrame];
    backView.layer.shadowOffset = CGSizeMake(3,3);//往x方向偏移0，y方向偏移0
    backView.layer.shadowOpacity = 0.3;//设置阴影透明度
    backView.layer.shadowColor= [UIColor lightGrayColor].CGColor;//设置阴影颜色
    backView.layer.shadowRadius = 5;//设置阴影半径
    [self addSubview:backView];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, collectionViewFrame.size.width, collectionViewFrame.size.height) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.multipleTouchEnabled = NO;
    self.collectionView = collectionView;
    [backView addSubview:collectionView];
    
    [self.collectionView registerClass:[AEAECustomOptionCell class] forCellWithReuseIdentifier:NSStringFromClass([AEAECustomOptionCell class])];
}


- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AEAECustomOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AEAECustomOptionCell class]) forIndexPath:indexPath];
    AECustomOptionModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.block) {
        self.block(self.dataArray[indexPath.row].title);
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (void)setDataArray:(NSArray<AECustomOptionModel *> *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

@end
