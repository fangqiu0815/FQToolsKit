//
//  MTDetailMenuView.h
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTDetailMenuList;


typedef void(^ClickBackBlock) (NSInteger index);//1
@interface MTDetailMenuView : UIButton

//创建次菜单的分类表
+(MTDetailMenuView*)getMenuList:(CGFloat)height listWidth:(CGFloat)width offsetY:(CGFloat)y;
@property (nonatomic,copy)ClickBackBlock clickBackBlock;//2
@property (nonatomic,strong)MTDetailMenuList * tableView;
@end
