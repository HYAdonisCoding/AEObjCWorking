//
//  AECardView.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/7.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AECardView.h"
#import "AECardTransformLayout.h"
#import "AECustomViewFlowLayout.h"
#import "AECardViewCCell.h"
#import "AECardModel.h"

@interface AECardView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

// UI
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) AECustomViewFlowLayout *layout;


@end

@implementation AECardView

#pragma mark - life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureProperty];
        
        [self addCollectionView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureProperty];
        
        [self addCollectionView];
    }
    return self;
}


- (void)configureProperty {
    //    _needResetIndex = NO;
    //    _didReloadData = NO;
    //    _didLayout = NO;
    //    _autoScrollInterval = 0;
    //    _isInfiniteLoop = YES;
    //    _beginDragIndexSection.index = 0;
    //    _beginDragIndexSection.section = 0;
    //    _indexSection.index = -1;
    //    _indexSection.section = -1;
    //    _firstScrollIndex = -1;
}

- (void)addCollectionView {
    AECustomViewFlowLayout *flowLayout = [[AECustomViewFlowLayout alloc] initWithType:(AEAlignmentFlowLayoutTypeCenter) cellSpace:10];
    // 设置UICollectionView为横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 每一行cell之间的间距
    flowLayout.minimumLineSpacing = 0;
    // 每一列cell之间的间距
    flowLayout.minimumInteritemSpacing = 0;
    // 设置第一个cell和最后一个cell,与父控件之间的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;// 根据需要编写
    flowLayout.minimumInteritemSpacing = 0;// 根据需要编写
    CGFloat height = SCREEN_HEIGHT * 0.9;
    CGFloat width = SCREEN_WIDTH * .9;
    
    flowLayout.itemSize = CGSizeMake(width, height);// 该行代码就算不写,item也会有默认尺寸
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor orangeColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = NO;
    collectionView.decelerationRate = 1-0.0076;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.right.bottom.mas_offset(0);
    }];
    [collectionView registerClass:[AECardViewCCell class] forCellWithReuseIdentifier:NSStringFromClass([AECardViewCCell class])];
    _collectionView = collectionView;
}


- (CGPoint)contentOffset {
    return _collectionView.contentOffset;
}

#pragma mark - configure layout




- (void)setNeedUpdateLayout {
    if (!self.layout) {
        return;
    }
    
    [_collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //    if (section == 0 ) {
    return UIEdgeInsetsMake(0, 10, 0, 10);
    //    }
    //    else if (section == kPagerViewMaxSectionCount -1) {
    //        return UIEdgeInsetsMake(0, 10, 0, 10);
    //    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AECardViewCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AECardViewCCell class]) forIndexPath:indexPath];
    AECardDetailModel *model = self.dataArray[indexPath.section].detailModel[indexPath.row];
    cell.titleLabel.text = model.subTitle;
    cell.detailLabel.text = model.detail;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ((AECardModel *)self.dataArray[section]).detailModel.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}


@end
