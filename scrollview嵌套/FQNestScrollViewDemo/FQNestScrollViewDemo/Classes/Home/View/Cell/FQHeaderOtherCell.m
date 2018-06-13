//
//  FQHeaderOtherCell.m
//  FQNestScrollViewDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQHeaderOtherCell.h"

@interface FQHeaderOtherCell()

@property (nonatomic, strong) UILabel *descLabel;


@end

@implementation FQHeaderOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.descLabel];
    }
    return self;
}

#pragma mark - Init Views

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width, 60)];
        _descLabel.text = @"XXXXXXXXXXXXXXXXX";
    }
    return _descLabel;
}

@end
