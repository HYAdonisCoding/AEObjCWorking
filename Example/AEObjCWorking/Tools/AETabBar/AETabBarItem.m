//
//  AETabBarItem.m
//  AEObjCWorking_Example
//
//  Created by Adonis_HongYang on 2020/1/9.
//  Copyright © 2020 HYAdonisCoding. All rights reserved.
//

#import "AETabBarItem.h"
#import "UIView+Size.h"

@interface AETabBarItem ()
/*图片*/
@property (nonatomic,strong) UIImageView *imageView;
/*文字*/
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation AETabBarItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(11);
            make.left.and.right.equalTo(self);
            make.top.equalTo(self).offset(35);
        }];
        __weak __typeof(self) _self = self;
        [self setTapActionWithBlock:^{
            if (_self.selectBlock) {
                _self.selectBlock();
            }
        }];
    }
    return self;
}
/*更新布局方法 设置完之后记得调用*/
-(void)updateImageAndTitle{
    self.titleLabel.text = self.title;
    if (self.selected) {
        self.titleLabel.font = [UIFont systemFontOfSize:10.0];
        self.titleLabel.textColor = self.selectedTitleColor;
        if (self.selectedImage) {
            self.imageView.image = self.selectedImage;
        }
    }else{
        self.titleLabel.font = [UIFont boldSystemFontOfSize:10.0];
        self.titleLabel.textColor = self.titleColor;
        if (self.image) {
            self.imageView.image = self.image;
        }
    }
    if ([self.title length]) {
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.and.width.mas_equalTo(22);
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(5);
        }];
    }else{
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.and.width.mas_equalTo(40);
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(5);
        }];
    }
}
#pragma mark ---G
-(UIImageView*)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
-(UILabel*)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
