//
//  AETestUIViewController.m
//  AEObjCWorking_Example
//
//  Created by Adam on 2023/11/2.
//  Copyright © 2023 HYAdonisCoding. All rights reserved.
//

#import "AETestUIViewController.h"

#define LSSCALWIDTH (SCREEN_WIDTH/375.0)
#define Number(num)      (num*LSSCALWIDTH)
#define LSSCALHEIGHT (SCREEN_HEIGHT/667.0)
#define NumberHeight(num)          (num*LSSCALHEIGHT)



@interface AETestUIViewController ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *frontImageView;
@property(nonatomic,strong)UIImageView *backImageView;
@property(nonatomic,strong)UIButton *frontButton;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,strong)UIImageView *frontSyImageView;
@property(nonatomic,strong)UIImageView *backSyImageView;
@property(nonatomic,strong)UIButton *readButton;
@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic, strong)NSString *isFront;//判断是不是正面
@property(nonatomic,strong) UIScrollView *contentScrollView;
@property(nonatomic, strong)NSString *cardDataStr; //有效期限 后半部分
@end

@implementation AETestUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)configUI {
    [super configUI];
    [self project];
    
}
- (void)project {
    self.contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
    self.contentScrollView.backgroundColor = [UIColor lightGrayColor];
    self.contentScrollView.scrollEnabled=YES;
    self.contentScrollView.userInteractionEnabled = YES;
    self.contentScrollView.bounces = YES;
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
    CGFloat height = 280;
    UIView *subView = [[UIView alloc] init];
    subView.backgroundColor = [UIColor blueColor];
    [self.contentScrollView addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(height);
    }];

       
    UIView *subView1 = [[UIView alloc] init];
    subView1.backgroundColor = [UIColor yellowColor];
    [self.contentScrollView addSubview:subView1];
    [subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subView.mas_bottom).offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(height);
    }];
    
    UIView *subView2 = [[UIView alloc] init];
    subView2.backgroundColor = [UIColor magentaColor];
    [self.contentScrollView addSubview:subView2];
    [subView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subView1.mas_bottom).offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(height);
//        make.bottom.mas_equalTo(self.contentScrollView.mas_bottom).offset(-5);
    }];
        [self.view layoutIfNeeded];
      
        self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(subView2.frame) + 5);
}
- (void)projecttest {
    self.contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
    self.contentScrollView.backgroundColor = [UIColor lightGrayColor];
    self.contentScrollView.scrollEnabled=YES;
    self.contentScrollView.userInteractionEnabled = YES;
    self.contentScrollView.bounces = YES;
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    _titleLabel= ({
        UILabel *iv = [[UILabel alloc] init];
        iv.textColor = [UIColor blackColor];
        iv.font = [UIFont systemFontOfSize:13.0f];
        iv.textAlignment = NSTextAlignmentCenter;
        iv.text = @"请确保您的二代身份证处于有效期内";
        [self.contentScrollView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
            make.height.mas_equalTo(40.0f);
        }];
        iv;
    });
    
    _frontImageView = ({
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectZero];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.masksToBounds = YES;
        iv.clipsToBounds = YES;
        iv.layer.cornerRadius = 5.0f;
        iv.backgroundColor = [UIColor yellowColor];
        [self.contentScrollView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.0f);
            make.right.mas_equalTo(-10.0f);
            make.width.mas_equalTo(SCREEN_WIDTH - 20);
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.height.mas_equalTo(NumberHeight(210.0f));
        }];
        iv;
    });
    
    _backImageView = ({
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectZero];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.masksToBounds = YES;
        iv.clipsToBounds = YES;
        iv.layer.cornerRadius = 5.0f;
        iv.backgroundColor = [UIColor greenColor];
        [self.contentScrollView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.frontImageView.mas_bottom).mas_offset(5.0f);
            make.height.mas_equalTo(NumberHeight(210.0f));
        }];
        iv;
    });
    
    
    _readButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentScrollView addSubview:iv];
        iv.backgroundColor = [UIColor blueColor];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.0f);
            make.top.mas_equalTo(self.backImageView.mas_bottom).mas_offset(20.0f);
            make.size.mas_equalTo(CGSizeMake(18.0f, 17.0f));
        }];
        iv;
    });
    
    _tipLabel =({
        UILabel *iv = [[UILabel alloc] init];
        iv.textColor = [UIColor blackColor];
        iv.font = [UIFont systemFontOfSize:10.0f];
        iv.textAlignment = NSTextAlignmentLeft;
        iv.text = @"本人承诺上传的身份证件真实、有效，名下账户均为本人意愿开立。";
        iv.numberOfLines = 0;
        iv.backgroundColor = [UIColor magentaColor];
        [self.contentScrollView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.readButton);
            make.left.mas_equalTo(self.readButton.mas_right).mas_offset(5.0f);
            make.right.mas_equalTo(-10.0f);
            make.height.mas_equalTo(self.readButton.mas_height);
        }];
        iv;
    });
    
    UILabel *comfirmLab3 = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = [UIColor blueColor];
        iv.textAlignment = NSTextAlignmentLeft;
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc]initWithString:@"点击了解本功能"];
        [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, 0)];
        iv.attributedText = aStr;
        iv.font =  [UIFont systemFontOfSize:10];
        iv.backgroundColor = [UIColor magentaColor];
        [self.contentScrollView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tipLabel.mas_left);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_offset((55));
            make.right.mas_equalTo((-10));
            make.height.mas_equalTo(50);
        }];
        iv;
    });
    
    CGFloat bottom = [[AENavigationBarHeightManager sharedManager] bottomSafeAreaHeight];
    CGFloat navigationBarHeightWithSafeArea = [AENavigationBarHeightManager sharedManager].navigationBarHeightWithSafeArea;
    NSLog(@"%f-%f", navigationBarHeightWithSafeArea, bottom);
    _sureButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentScrollView addSubview:iv];
        [iv setTitle:@"下一步" forState:UIControlStateNormal];
        [iv setTitle:@"下一步" forState:UIControlStateSelected];
        [iv setTitle:@"下一步" forState:UIControlStateDisabled];
        [iv setTitle:@"下一步" forState:UIControlStateHighlighted];
        [iv.titleLabel setTextAlignment:NSTextAlignmentCenter];
        iv.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = 5.0f;
        iv.backgroundColor = [UIColor magentaColor];
        iv.alpha = 0.5f;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10.0f);
            make.right.mas_equalTo(-10.0f);
            
            make.top.mas_equalTo(comfirmLab3.mas_bottom).mas_offset(20.0f);
            
            make.height.mas_equalTo(44.0f);
            make.bottom.mas_equalTo(self.contentScrollView.mas_bottom).offset(-bottom);
        }];
        iv;
    });
    
//    [self.view layoutIfNeeded];
  
//    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.sureButton.frame) + bottom);
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

///MARK: TOOD
- (void)layoutTextUnderImageButton:(UIButton *)button {
    button.titleEdgeInsets = UIEdgeInsetsMake(button.currentImage.size.height +Number(20.0f),-button.currentImage.size.width,
                                              0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height, 0, 0,
                                              -button.titleLabel.intrinsicContentSize.width);
}
@end
