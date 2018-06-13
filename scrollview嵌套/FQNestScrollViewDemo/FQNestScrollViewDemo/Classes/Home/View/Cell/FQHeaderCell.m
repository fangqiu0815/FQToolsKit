//
//  FQHeaderCell.m
//  FQNestScrollViewDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQHeaderCell.h"

@interface FQHeaderCell ()

@property (nonatomic, strong) UIImageView *posterImgView;

@end

@implementation FQHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.posterImgView];
    }
    return self;
}

#pragma mark - Init Views

- (UIImageView *)posterImgView {
    if (!_posterImgView) {
        _posterImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
        _posterImgView.image = [UIImage jq_imageWithColor:[UIColor blueColor]];
    }
    return _posterImgView;
}

@end
