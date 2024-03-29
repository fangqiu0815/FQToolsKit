//
//  FQTypeButton.m
//  FQTypeButtonDemo
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQTypeButton.h"

static CGFloat const kScale = 0.8;

@implementation FQTypeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return self;
}

// 没有高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
    //    highlighted = NO;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat width = [self.titleLabel.text sizeWithFont:self.titleLabel.font forWidth:self.bounds.size.width lineBreakMode:self.titleLabel.lineBreakMode].width;
    NSInteger length = self.titleLabel.text.length;
    width = (length <= 2 ? width : (width * kScale));
    return CGRectMake(width, 0.0, self.bounds.size.width, self.bounds.size.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0.0, 0.0, self.bounds.size.width, self.frame.size.height);
}






@end
