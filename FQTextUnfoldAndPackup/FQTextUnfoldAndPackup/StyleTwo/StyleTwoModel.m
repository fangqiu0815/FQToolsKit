//
//  StyleTwoModel.m
//  FQTextUnfoldAndPackup
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "StyleTwoModel.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation StyleTwoModel

-(CGFloat)heightForRowWithisShow:(BOOL)isShow
{
    if (!isShow) {
        if ([self heightForString:_workInfo fontSize:15 andWidth:SCREEN_WIDTH - 45] > 20) {
            _isBeyond = YES;
            
            return 140;
        }
        else
        {
            _isBeyond = NO;
            
            return [self heightForString:_workInfo fontSize:15 andWidth:SCREEN_WIDTH - 45] + 130;
        }
    }else
    {
        return [self heightForString:_workInfo fontSize:15 andWidth:SCREEN_WIDTH - 45] + 130;
    }
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width{
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailLabel.font = [UIFont systemFontOfSize:fontSize];
    detailLabel.text = value;
    detailLabel.numberOfLines = 0;
    CGSize deSize = [detailLabel sizeThatFits:CGSizeMake(width,1)];
    return deSize.height;
}

@end
