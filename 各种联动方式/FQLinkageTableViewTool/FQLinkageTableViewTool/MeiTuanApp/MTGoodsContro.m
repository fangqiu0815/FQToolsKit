//
//  MTGoodsContro.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MTGoodsContro.h"
#import "MTDetailMenuView.h"
#import "MTGoodsCarToolBar.h"
#import "MTDetailGoodCell.h"
#import "MTDetailMenuList.h"
#import "MTGoodHeader.h"
#import "MTRecomHeader.h"
#import "MTShopDetailContro.h"
#import "MTMianTableView.h"

@interface MTGoodsContro ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView * goodsList;
@property (nonatomic , strong) MTDetailMenuView * menuListView;
@property (nonatomic , strong) UIView * recomHeader;


@end
static const CGFloat recomH = 190;
@implementation MTGoodsContro

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.goodsList];
    [self creatLeftMenuList];
    
}


/**
 左侧商品表格
 
 @return tableview
 */
-(UITableView*)goodsList
{
    if (_goodsList==nil) {
        _goodsList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.listHeight) style:UITableViewStylePlain];
        [_goodsList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listCell"];
        [_goodsList registerClass:[UIView class] forHeaderFooterViewReuseIdentifier:@"header"];
        _goodsList.backgroundColor = [UIColor clearColor];
        _goodsList.contentInset = UIEdgeInsetsMake(0, 0, [MTGoodsCarToolBar getGoodsCarBar].height, 0);
        _goodsList.delegate = self;
        _goodsList.dataSource = self;
        
        //推荐头部
        weakSelf(self);
        _recomHeader = [MTRecomHeader getRecomHeder:@[@"1",@"3",@"4"]];
        _recomHeader.callBackBlock = ^(BOOL isEnd) {
            MTShopDetailContro * vc= (MTShopDetailContro*)[weakSelf.view viewController];
            vc.tableView.isRg = isEnd;
        };
        _goodsList.tableHeaderView = _recomHeader;
    }
    return _goodsList;
}
//左侧商品分类栏目
-(void)creatLeftMenuList
{
    weakSelf(self);
    
    _menuListView = [MTDetailMenuView getMenuList:self.listHeight listWidth:100 offsetY:recomH];
    _menuListView.clickBackBlock = ^(NSInteger index) {
        weakSelf.canScroll= YES;
        
        //大表格置顶顶部
        MTShopDetailContro * vc= (MTShopDetailContro*)[weakSelf.view viewController];
        CGFloat y=  [vc.tableView rectForSection:0].origin.y;
        [vc.tableView setContentOffset:CGPointMake(0, y) animated:YES];
        //商品表格滑动
        [weakSelf.goodsList selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index+1] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    };
    
    [_goodsList addSubview:_menuListView];
}

#pragma mark tableView的代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTDetailGoodCell * cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString * hederID=@"header";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:hederID];
    header.textLabel.text = [NSString stringWithFormat:@"%ld",section];
    return header;
}

//右侧的商品表滚动效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //锁定左侧菜单表格
    CGFloat y = [self.goodsList rectForSection:0].origin.y;
    CGFloat offsetY= scrollView.contentOffset.y>=y ? scrollView.contentOffset.y:recomH;
    _menuListView.originY =offsetY;
    
    
    if (self.canScroll) {
        self.point = scrollView.contentOffset;
        return;
    }
    
    if (self.point.y < 0) {
        self.point = CGPointMake(self.point.x, 0);
    }
    scrollView.contentOffset = self.point;
    
}
//右侧点击滚动之后，继续右侧就不可以滚动了
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.canScroll = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollowLeftTable];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self scrollowLeftTable];
}
//滑动商品，联动左侧的菜单表格
-(void)scrollowLeftTable
{
    // 取出显示在视图且最靠上的cell的 indexPath
    NSIndexPath *topHeaderViewIndexpath = [[self.goodsList indexPathsForVisibleRows] firstObject];
    NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
    [_menuListView.tableView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
