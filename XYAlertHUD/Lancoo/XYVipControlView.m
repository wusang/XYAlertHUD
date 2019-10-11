//
//  XYVipControlView.m
//  XYAlertHUDDemo
//
//  Created by wuxiaoyuan on 2019/9/29.
//  Copyright © 2019 lange. All rights reserved.
//

#import "XYVipControlView.h"
#import <Masonry/Masonry.h>
#import <XYExtensions/XYExtensions.h>
#import "XYAlertHUD.h"


#define kLancooScreenWidth [UIScreen mainScreen].bounds.size.width
#define kLancooScreenHeight [UIScreen mainScreen].bounds.size.height
#define IsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kLancooWidth (IsPad ? 400 : kLancooScreenWidth * 0.8)
#define kLancooHeight (IsPad ? 300 : kLancooWidth * 0.9)
#define kLancooHeadImageH 100

@interface XYVipControlView ()
/** 头像 */
@property (nonatomic,strong) UIImageView *headImageV;
/** 标题 */
@property (nonatomic,strong) UILabel *titleL;
/** 内容 */
@property (nonatomic,strong) UILabel *contentL;


@property (nonatomic,strong) UIButton *sureBtn;

@property (nonatomic,strong) UIButton *closeBtn;
@property(nonatomic,strong) UIView *maskView;

@property (nonatomic,copy) void (^btnClickBlock) (void);
@property (nonatomic,copy) void (^closeBlock) (void);

@end

@implementation XYVipControlView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    return self;
}
- (void)layoutUI{
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.left.equalTo(self);
        make.top.equalTo(self.mas_top).offset(kLancooHeadImageH/2 - 10);
    }];
    [contentView xy_clipLayerWithRadius:5 width:0 color:nil];
    
    [self addSubview:self.headImageV];
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.height.mas_equalTo(kLancooHeadImageH);
        make.width.equalTo(self.headImageV.mas_height).multipliedBy(1.08);
    }];
    
    CGFloat sureWidth = kLancooWidth - 60;
    if (IsPad) {
        sureWidth = 240;
    }
    [contentView addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.width.mas_equalTo(sureWidth);
        make.bottom.equalTo(contentView).offset(-20);
        make.height.mas_equalTo(40);
    }];
    [self.sureBtn xy_shadowWithCornerRadius:20 borderWidth:0 borderColor:nil shadowColor:[UIColor xy_colorWithHex:0xEE4000] shadowOpacity:0.5 shadowOffset:CGSizeMake(1, 2.5) roundedRect:CGRectMake(3, 2, sureWidth-6, 40) cornerRadii:CGSizeMake(20, 20) rectCorner:UIRectCornerAllCorners];
    
    
    [contentView addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(contentView.mas_top).offset(kLancooHeadImageH/2 + 10);
        make.left.equalTo(contentView.mas_left).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    [contentView addSubview:self.contentL];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.left.equalTo(contentView).offset(20);
        make.top.equalTo(self.titleL.mas_bottom).offset(15);
        make.bottom.equalTo(self.sureBtn.mas_top).offset(-30);
    }];
}
+ (XYVipControlView *)vipControlViewWithTitleStr:(NSString *)titleStr contentStr:(NSString *)contentStr btnTitleStr:(NSString *)btnTitleStr closeBlock:(void (^)(void))closeBlock btnClickBlock:(void (^)(void))btnClickBlock{
    XYVipControlView *vipV = [[XYVipControlView alloc] initWithFrame:CGRectZero];
    vipV.titleL.text = titleStr;
    vipV.contentL.text = contentStr;
    [vipV.sureBtn setTitle:btnTitleStr forState:UIControlStateNormal];
    vipV.closeBlock = closeBlock;
    vipV.btnClickBlock = btnClickBlock;
    return vipV;
}
- (void)sureAction{
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
    [self hide];
}
- (void)closeAction{
    if (self.closeBlock) {
        self.closeBlock();
    }
    [self hide];
}
- (void)showOnView:(UIView *)view{
    
    [view addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
    [self.maskView addGestureRecognizer:tap];
    
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view).offset(- (kLancooHeadImageH/4+10));
        make.centerX.equalTo(view);
        make.width.mas_equalTo(kLancooWidth);
        make.height.mas_equalTo(kLancooHeight);
    }];
    
    self.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                             CGAffineTransformMakeScale(0.1f, 0.1f));
    self.alpha = 0.0f;
    self.maskView.alpha = 0.0f;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3f animations:^{
        self.maskView.alpha = 0.6f;
        weakSelf.transform = CGAffineTransformConcat(CGAffineTransformIdentity,
                                                     CGAffineTransformMakeScale(1.0f, 1.0f));
        weakSelf.alpha = 1.0f;
    }];
}
- (void)hide{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^(void) {
        weakSelf.maskView.alpha = 0.0f;
        weakSelf.alpha = 0.0f;
    } completion:^(BOOL isFinished) {
        [weakSelf.maskView removeFromSuperview];
        [weakSelf removeFromSuperview];
    }];
}
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor xy_colorWithHex:0x000000 alpha:0.6];
    }
    return _maskView;
}
- (UIImageView *)headImageV{
    if (!_headImageV) {
        _headImageV = [[UIImageView alloc] initWithImage:[UIImage xy_imageNamed:@"xy_hud_topBird" atBundle:XYAlert.alertBundle]];
    }
    return _headImageV;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _titleL.textColor = [UIColor xy_colorWithHex:0x222222];
    }
    return _titleL;
}
- (UILabel *)contentL{
    if (!_contentL) {
        _contentL = [UILabel new];
        _contentL.textAlignment = NSTextAlignmentCenter;
        _contentL.font = [UIFont systemFontOfSize:15];
        _contentL.textColor = [UIColor xy_colorWithHex:0x444444];;
        _contentL.numberOfLines = 3;
    }
    return _contentL;
}
- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.backgroundColor = [UIColor redColor];
        [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage xy_imageNamed:@"close" atBundle:XYAlert.alertBundle] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
