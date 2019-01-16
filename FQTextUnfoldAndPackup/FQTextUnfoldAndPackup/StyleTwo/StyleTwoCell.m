//
//  StyleTwoCell.m
//  FQTextUnfoldAndPackup
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "StyleTwoCell.h"

@interface StyleTwoCell()

/** 背景视图 */
@property (nonatomic, strong) UIView *bottomView;
/** 头像 */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 昵称 */
@property (nonatomic, strong) UILabel *nickNameLab;
/** 点赞 */
@property (nonatomic, strong) UIButton *iconZanBtn;
/** 评论 */
@property (nonatomic, strong) UILabel *recomendLab;


@end

@implementation StyleTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bottomView];
        [self.bottomView addSubview:self.iconImageView];
        [self.bottomView addSubview:self.iconZanBtn];
        [self.bottomView addSubview:self.nickNameLab];
        [self.bottomView addSubview:self.recomendLab];
        
        [self addView];
    }
    return self;
}

- (void)addView
{
    
    
    
    
    
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.layer.cornerRadius = 5;
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}

- (UIButton *)iconZanBtn
{
    if (!_iconZanBtn) {
        _iconZanBtn = [[UIButton alloc]init];
    }
    return _iconZanBtn;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.cornerRadius = 20;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}


- (UILabel *)nickNameLab
{
    if (!_nickNameLab) {
        _nickNameLab = [[UILabel alloc]init];
        _nickNameLab.text = @"XXXXXXXXXXXXX";
        _nickNameLab.font = [UIFont systemFontOfSize:13.0f];
        _nickNameLab.textColor = [UIColor blackColor];
    }
    return _nickNameLab;
}

- (UILabel *)recomendLab
{
    if (!_recomendLab) {
        _recomendLab = [[UILabel alloc]init];
        _recomendLab.font = [UIFont systemFontOfSize:13.0f];
        _recomendLab.textColor = [UIColor blackColor];
    }
    return _recomendLab;
}




@end
