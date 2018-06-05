//
//  FQHeadView.m
//  FQPersonPageTest
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQHeadView.h"
#import "Masonry.h"

@interface FQHeadView()

/** <#name#> */
@property (nonatomic, strong) UIImageView *bgView;
/** <#name#> */
@property (nonatomic, strong) UIImageView *iconView;
/** <#name#> */
@property (nonatomic, strong) UILabel *nameLab;



@end

@implementation FQHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgView];
       
        [self addView];
    }
    return self;
}

- (void)addView
{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [self.bgView addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self.bgView);
    }];
    
    [self.bgView addSubview:self.iconView];
    [self.bgView addSubview:self.nameLab];

    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.centerX.mas_equalTo(self.bgView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    
}

- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"huba.jpeg"];
    }
    return _bgView;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.image = [UIImage imageNamed:@"huba.jpeg"];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 40;

    }
    return _iconView;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.text = @"XXXXXXX";
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.textColor = [UIColor whiteColor];
    }
    return _nameLab;
}

@end
