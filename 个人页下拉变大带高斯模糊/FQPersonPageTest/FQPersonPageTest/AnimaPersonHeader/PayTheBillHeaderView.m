//
//  PayTheBillHeaderView.m
//  FQPersonPageTest
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PayTheBillHeaderView.h"
#import "Masonry.h"
#import "UIView+Frame.h"

@interface PayTheBillHeaderView()



@end

@implementation PayTheBillHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(self.iconImageView.mas_width);
        }];
        
        [self addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.iconImageView);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"huba.jpeg"];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 30;
    }
    return _iconImageView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc ]init];
        _titleLab.text = @"title";
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:15];
    }
    return _titleLab;
}

@end
