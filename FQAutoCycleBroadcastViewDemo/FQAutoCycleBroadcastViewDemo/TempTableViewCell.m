//
//  TempTableViewCell.m
//  FQAutoCycleBroadcastViewDemo
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TempTableViewCell.h"

@interface TempTableViewCell()

/** <#name#> */
@property (nonatomic, strong) UIView *bgView;


/** <#name#> */
@property (nonatomic, strong) UILabel *nameLab;

/** <#name#> */
@property (nonatomic, strong) UILabel *detailLab;

@end

@implementation TempTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bgView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self.bgView addSubview:self.nameLab];
        [self.bgView addSubview:self.detailLab];

        [self addView];
    }
    return self;
}

- (void)addView
{
    self.bgView.frame = CGRectMake(10, 5, 200, 30);
    self.nameLab.frame = CGRectMake(10, 0, 80, 30);
    self.detailLab.frame = CGRectMake(95, 0, 105, 30);
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 10;
        
    }
    return _bgView;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.text = @"正在分享您的链接";
        _detailLab.textColor = [UIColor whiteColor];
        _detailLab.font = [UIFont systemFontOfSize:14];
    }
    return _detailLab;
}

- (UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        NSArray *array = @[@"“导师ABC”",@"“导师123”",@"“haha123”",@"“sisi123”",@"“123123”",@"“zhende123”"];
        int i = [self getRandomNumber:0 to:(int)array.count - 1];
        _nameLab.text = array[i];
        _nameLab.textColor = [UIColor orangeColor];
        _nameLab.font = [UIFont systemFontOfSize:15];
    }
    return _nameLab;
}

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}



@end
