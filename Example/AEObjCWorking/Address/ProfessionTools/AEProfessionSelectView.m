//
//  AEProfessionSelectView.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2022/4/25.
//  Copyright © 2022 HYAdonisCoding. All rights reserved.
//

#import "AEProfessionSelectView.h"
#import "AEProfessionTCell.h"
#import "AEProfessionSearchTCell.h"
#import "AEProfessionModel.h"
//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSUInteger, AELevelListType) {
    first,// 一级列表
    secondary,// 二级列表
    three,// 三级列表
    search,// 搜索列表
};

@interface AEProfessionSelectView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UITextFieldDelegate>

/// 本地数组
@property (nonatomic, strong) NSArray<AEProfessionSumModel *> *resultArray;

/// 背景视图
@property (nonatomic, strong) UIView *backView;
/// 列表类型
@property (nonatomic, assign) AELevelListType listType;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 列表
@property (nonatomic, strong) UITableView *tableView;
/// 搜索框
@property (nonatomic, strong) UITextField *textField;
/// 返回按钮
@property (nonatomic, strong) UIButton *backButton;
///
@property (nonatomic, strong) NSArray<AEProfessionSumModel *> *firstArray;
@property (nonatomic, strong) NSArray<AEProfessionSubModel *> *secondaryArray;
@property (nonatomic, strong) NSArray<AEProfessionModel *> *threeArray;
@property (nonatomic, strong) NSArray<AEProfessionSearchModel *> *searchArray;

/// 选中模型
@property (nonatomic, strong) AEProfessionModel *selectModel;
/// 回调
@property (nonatomic, copy) AEAddressSelectBlock block;

@property (nonatomic, strong) UILabel *selectFirstLabel;
@property (nonatomic, strong) UILabel *selectSecondaryLabel;
/// 图标
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation AEProfessionSelectView

- (UIView *)initAddressView {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"profession.json" ofType:nil];

    NSString *string = [[NSString alloc] initWithContentsOfFile:imagePath encoding:NSUTF8StringEncoding error:nil];
    NSData * resData = [[NSData alloc]initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    self.resultArray = [NSArray yy_modelArrayWithClass:[AEProfessionSumModel class] json:[NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil]];
    AEProfessionSearchModel *model = [AEProfessionSearchModel new];
    model.profession1 = @"党的机关、国家机关、群众团体和社会组织、企事业单位负责人";
    model.profession2 = @"人民团体和群众团体、社会组织及其他成员组织负责人";
    model.profession3 = @"人民团体和群众团体负责人";
    self.searchArray = @[model, model];
    self.frame = CGRectMake(0, 0, screen_width, screen_height);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBtnAndcancelBtnClick)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    //设置添加地址的View
    self.backView = [[UIView alloc]init];
    self.backView.frame = CGRectMake(0, screen_height, screen_width, _defaultHeight);
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, screen_width - 100, 30)];
    titleLabel.text = _title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithString:@"#000000"];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.backView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(15, 10, 30, 30);
    cancelBtn.tag = 1;
    [cancelBtn setImage:[UIImage imageNamed:@"icon-返回"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:cancelBtn];
    cancelBtn.hidden = YES;
    self.backButton = cancelBtn;
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ensureBtn.frame = CGRectMake(CGRectGetMaxX(self.backView.frame) - 45, 10, 30, 30);
    [ensureBtn setImage:[UIImage imageNamed:@"icon_shut"] forState:UIControlStateNormal];
    [ensureBtn addTarget:self action:@selector(tapBtnAndcancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backView addSubview:ensureBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor colorWithString:@"#F0F0F0"];
    [self.backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textField.placeholder = @"请输入职业名称";
    self.textField.backgroundColor = [UIColor colorWithString:@"#F8F8F8"];
    self.textField.layer.cornerRadius = 14;
    self.textField.layer.masksToBounds = YES;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeySearch;
    //设置放大镜图标
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_sousuo"]];
    searchIcon.contentMode = UIViewContentModeCenter;
    self.textField.leftView = searchIcon;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    
    [self.backView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(15);
        make.left.mas_equalTo(lineView.mas_left);
        make.right.mas_equalTo(lineView.mas_right);
        make.height.mas_equalTo(28);
    }];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[AEProfessionTCell class] forCellReuseIdentifier:NSStringFromClass([AEProfessionTCell class])];
    
    [self.tableView registerClass:[AEProfessionSearchTCell class] forCellReuseIdentifier:NSStringFromClass([AEProfessionSearchTCell class])];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.backView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(103);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self addCorner];
    
    self.listType = first;
    [self configData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    return self;
}

- (void)dealloc {
    // 视图将要消失移除键盘通知，防止其他界面使用键盘导致的页面错乱
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)addAnimate{
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.frame = CGRectMake(0, screen_height - self.defaultHeight, screen_width, self.defaultHeight);
    }];
}
- (void)addAnimateCompationHandler:(AEAddressSelectBlock)compationHandler {
    self.block = compationHandler;
    [self addAnimate];
}

// MARK: - Private Method

- (void)searchProfession {
    // 获取数据
    
    // 成功后
    self.listType = search;
    [self configData];
}

- (void)keyBoardWillShow:(NSNotification *) note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.backView.frame = CGRectMake(0, screen_height * 0.1, screen_width, screen_height * 0.9);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
}

- (void)keyBoardWillHide:(NSNotification *) note {
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:note.userInfo];
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        //
        self.backView.frame = CGRectMake(0, screen_height - self.defaultHeight, screen_width, self.defaultHeight);
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}


- (void)addCorner {
    CGFloat radius = 16; // 圆角大小
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight; // 圆角位置
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.backView.bounds;
    maskLayer.path = path.CGPath;
    self.backView.layer.mask = maskLayer;
}
- (void)backBtnClick {
    if (self.listType == search || self.listType == secondary || self.listType == three) {
        self.listType -= 1;
        [self configData];
    }
}
- (void)configData {
    self.selectFirstLabel.hidden = YES;
    self.selectSecondaryLabel.hidden = YES;
    self.iconImageView.hidden = YES;
    switch (self.listType) {
        case first: {
            self.firstArray = self.resultArray;
            self.backButton.hidden = YES;
            self.textField.hidden = NO;

            break;
        }
        case secondary: {
            self.backButton.hidden = NO;
            self.textField.hidden = YES;
            self.selectFirstLabel.hidden = NO;
            [self.selectFirstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(48);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(55);
            }];
            break;
        }
        case three: {
            self.backButton.hidden = NO;
            self.textField.hidden = YES;
            self.selectFirstLabel.hidden = NO;
            self.selectSecondaryLabel.hidden = NO;
            self.iconImageView.hidden = NO;
            [self.selectFirstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(48);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(27);
            }];
            [self.selectSecondaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.selectFirstLabel.mas_bottom).offset(1);
                make.right.mas_equalTo(-15);
                make.left.mas_equalTo(35);
                make.height.mas_equalTo(27);
            }];
            [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.selectFirstLabel.mas_left);
                make.height.mas_equalTo(16);
                make.width.mas_equalTo(16);
                make.centerY.mas_equalTo(self.selectSecondaryLabel.mas_centerY);
            }];
            break;
        }
        case search: {
            self.backButton.hidden = NO;

            break;
        }
        default:
            break;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.tableView reloadData];
    } completion:^(BOOL finished) {
        [self.tableView scrollsToTop];
    }];
}
/// 取消
- (void)tapBtnAndcancelBtnClick {
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
         self.backView.frame = CGRectMake(0, screen_height, screen_width, 200);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        NSString * titleAddress = self.selectModel.name;
        NSString * titleID = self.selectModel.code;
        if (self.block) {
            self.block(titleAddress, titleID);
        }
    }];
}

// MARK: - UITableViewDataSource,

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (self.listType == search) {
        AEProfessionSearchTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AEProfessionSearchTCell class]) forIndexPath:indexPath];
        cell.searchModel = self.searchArray[row];
        return cell;
    } else {
        AEProfessionTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AEProfessionTCell class]) forIndexPath:indexPath];
        NSString *title;
        
        switch (self.listType) {
            case first:
                title = self.firstArray[row].name;
                cell.imageIcon.hidden = NO;
                break;
            case secondary:
                title = self.secondaryArray[row].name;
                cell.imageIcon.hidden = NO;
                break;
            case three:
                title = self.threeArray[row].name;
                cell.imageIcon.hidden = YES;
                break;
            default:
                break;
        }
        cell.nameLabel.text = title;
        
        return cell;
    }
    
    
    return UITableViewCell.new;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (self.listType) {
        case first:
            return self.firstArray.count;
        case secondary:
            return self.secondaryArray.count;
        case three:
            return self.threeArray.count;
        case search:
            return self.searchArray.count;
        default:
            return 0;
    }
}
// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;

    switch (self.listType) {
        case first: {
            AEProfessionSumModel *model = self.firstArray[row];
            self.secondaryArray = model.subProfession;
            self.selectFirstLabel.text = model.name;
            self.listType = secondary;
            [self configData];
            break;
        }
        case secondary: {
            AEProfessionSubModel *model = self.secondaryArray[row];
            self.threeArray = model.profession;
            self.selectSecondaryLabel.text = model.name;
            self.listType = three;
            [self configData];
            break;
        }
        case three: {
            self.selectModel = self.threeArray[row];
            [self tapBtnAndcancelBtnClick];
            break;
        }
        case search: {
            AEProfessionSearchModel *model = self.searchArray[row];
            AEProfessionModel *selectModel = [AEProfessionModel new];
            selectModel.name = model.profession3;
            selectModel.code = model.code3;
            self.selectModel = selectModel;
            [self tapBtnAndcancelBtnClick];
            break;
        }
        default:
            break;
    }
    
}
// MARK: - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchProfession];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length == 0) {
        return YES;
    }
    if (textField.text.length >= 2) {
        [self searchProfession];
    }
    return YES;
}

// MARK: - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass(touch.view.classForCoder) isEqualToString: @"UITableViewCellContentView"] ||
        touch.view == self.backView || touch.view == self.textField) {
        return NO;
    }
    return YES;
}

// MARK: - Lazy Loads
- (NSArray *)resultArray {
    if (!_resultArray) {
        _resultArray = [NSArray array];
    }
    return _resultArray;
}

- (NSArray *)firstArray {
    if (!_firstArray) {
        _firstArray = [NSArray array];
    }
    return _firstArray;
}
- (NSArray *)secondaryArray {
    if (!_secondaryArray) {
        _secondaryArray = [NSArray array];
    }
    return _secondaryArray;
}
- (NSArray *)threeArray {
    if (!_threeArray) {
        _threeArray = [NSArray array];
    }
    return _threeArray;
}
- (NSArray *)searchArray {
    if (!_searchArray) {
        _searchArray = [NSArray array];
    }
    return _searchArray;
}

- (UILabel *)selectFirstLabel {
    if (!_selectFirstLabel) {
        _selectFirstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _selectFirstLabel.textAlignment = NSTextAlignmentLeft;
        _selectFirstLabel.textColor = [UIColor colorWithString:@"#999999"];
        _selectFirstLabel.font = [UIFont systemFontOfSize:12];
        [self.backView addSubview:_selectFirstLabel];
        [_selectFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(48);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(55);
        }];
        _selectFirstLabel.hidden = YES;
    }
    return _selectFirstLabel;
}
- (UILabel *)selectSecondaryLabel {
    if (!_selectSecondaryLabel) {
        _selectSecondaryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _selectSecondaryLabel.textAlignment = NSTextAlignmentLeft;
        _selectSecondaryLabel.textColor = [UIColor colorWithString:@"#999999"];
        _selectSecondaryLabel.font = [UIFont systemFontOfSize:12];
        [self.backView addSubview:_selectSecondaryLabel];
        [_selectSecondaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.selectFirstLabel.mas_bottom).offset(1);
            make.right.mas_equalTo(-15);
            make.left.mas_equalTo(35);
            make.height.mas_equalTo(27);
        }];
        _selectSecondaryLabel.hidden = YES;
    }
    return _selectSecondaryLabel;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-级连"]];
        [self.backView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectFirstLabel.mas_left);
            make.height.mas_equalTo(16);
            make.width.mas_equalTo(16);
            make.centerY.mas_equalTo(self.selectSecondaryLabel.mas_centerY);
        }];
        _iconImageView.hidden = YES;
    }
    return _iconImageView;
}
@end
