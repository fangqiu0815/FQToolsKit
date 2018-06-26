//
//  MTDetailNavgation.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MTDetailNavgation.h"

@implementation MTDetailNavgation

+ (MTDetailNavgation *)getNavgation
{
    return [[MTDetailNavgation alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, navH)];
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor= [UIColor colorWithWhite:1 alpha:0];
    }
    
    return self;
}


@end
