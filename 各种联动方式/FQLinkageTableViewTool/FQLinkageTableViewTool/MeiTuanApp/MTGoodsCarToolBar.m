//
//  MTGoodsCarToolBar.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MTGoodsCarToolBar.h"

@implementation MTGoodsCarToolBar

static CGFloat const nomalHeight = 40;
static MTGoodsCarToolBar * _instance = nil;

/**
 单例方式创建
 
 @return 返回单例对象
 */
+(instancetype)getGoodsCarBar
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (_instance == nil) {
            CGFloat height = nomalHeight + BottomYFit;
            _instance = [[self alloc]initWithFrame:CGRectMake(0, getWindow.height-height, SCREEN_WIDTH, height)];
            _instance.height = height;
        }
    });
    
    return _instance;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor redColor];
    }
    return self;
}


@end
