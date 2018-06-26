//
//  MTDetailMenuView.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MTDetailMenuView.h"

#import "MTGoodsCarToolBar.h"
#import "MTBaseTableView.h"
#import "MTDetailMenuList.h"

@interface MTDetailMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , assign) CGFloat  height;
@property (nonatomic , assign) CGFloat  width;
@end
@implementation MTDetailMenuView



+(MTDetailMenuView*)getMenuList:(CGFloat)height listWidth:(CGFloat)width offsetY:(CGFloat)y
{
    
    MTDetailMenuView * listView = [[MTDetailMenuView alloc]initWithFrame:CGRectMake(0, y, width, height)];
    listView.backgroundColor= [UIColor grayColor];
    listView.height = height;
    listView.width  = width;
    return listView;
    
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        [self creatSubViews];
    }
    return self;
}

/**
 创建子控件
 */
-(void)creatSubViews
{
    _tableView  =[[MTDetailMenuList alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, [MTGoodsCarToolBar getGoodsCarBar].height+190, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.clickBackBlock(indexPath.row);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView  dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
