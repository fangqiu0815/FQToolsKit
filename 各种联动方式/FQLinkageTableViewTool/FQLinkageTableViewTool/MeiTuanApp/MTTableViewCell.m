//
//  MTTableViewCell.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MTTableViewCell.h"

@interface MTTableViewCell()

/** <#name#> */
@property (nonatomic, strong) UIImageView *iconImageView;
/** <#name#> */
@property (nonatomic, strong) UILabel *titleLab;
/** <#name#> */
@property (nonatomic, strong) UILabel *priceLab;


@end

@implementation MTTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.priceLab];

        [self addView];
    }
    return self;
}

- (void)addView
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(self.iconImageView.mas_height);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.iconImageView.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.bottom.mas_equalTo(self.iconImageView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage createImageWithColor:RandomColor];
    }
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"极品烧鸭饭";
        _titleLab.textColor = [UIColor blackColor];
        
    }
    return _titleLab;
}

- (UILabel *)priceLab
{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.text = @"￥ 25.69";
        _priceLab.textColor = [UIColor redColor];
        _priceLab.font = [UIFont systemFontOfSize:13];
    }
    return _priceLab;
}


@end
