//
//  ViewController.m
//  FQAutoCycleBroadcastViewDemo
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "SDCycleScrollView.h"
#import "TempTableViewCell.h"
#import "UIView+Frame.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UITableView * tableView;
@property (nonatomic, assign) int timerInt;
@property (nonatomic,strong) NSTimer *timer;
/** <#name#> */
@property (nonatomic, strong) NSMutableArray *dataSources;



@end

@implementation ViewController
{
    CGFloat yRange;
}

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    yRange = 120;
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 120) style:UITableViewStylePlain];
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
//    CAGradientLayer *gradinetLayer = [CAGradientLayer layer];
//    NSArray *colors = @[
//                        (id)[UIColor colorWithWhite:0 alpha:0.5].CGColor,
//                        (id)[UIColor colorWithWhite:0 alpha:1].CGColor,
//                        (id)[UIColor colorWithWhite:0 alpha:0.5].CGColor
//                        ];
//    [gradinetLayer setColors:colors];
//    [gradinetLayer setStartPoint:CGPointMake(0, 0)];
//    [gradinetLayer setEndPoint:CGPointMake(0, 1)];
//    [gradinetLayer setFrame:self.tableView.bounds];
//    [self.tableView.layer setMask:gradinetLayer];
    
    // 开启滚动
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollTheWinnerList:) userInfo:nil repeats:YES];

}

//滚动获奖者名单
- (void)scrollTheWinnerList:(NSTimer *)time
{
    self.timerInt ++;
    if (self.timerInt == 10) {
        self.timerInt = 0;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.timerInt inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } else {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.timerInt inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

#pragma mark 循环滚动
- (void)resetContentOffsetIfNeeded
{
    NSArray *indexpaths = [self.tableView indexPathsForVisibleRows];
    NSInteger totalVisibleCells = indexpaths.count;
    CGPoint contentOffset  = self.tableView.contentOffset;
    //check the top condition
    if  ( contentOffset.y <= 0.0) {
        contentOffset.y = 0;
        self.timerInt = 0;
    } else if ( contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height) ) {
        // scrollview content offset reached bottom minus the height of the tableview
        contentOffset.y = - self.tableView.bounds.size.height;
        //        self.timerInt = 0;
    }
    [self.tableView setContentOffset: contentOffset];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * LitigaCellIdentifier = @"TempTableViewCell";
    TempTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LitigaCellIdentifier];
    if (!cell) {
        cell = [[TempTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LitigaCellIdentifier];
    }
    
    
    return cell;
}

- (void)changeCellAlphaWithCell:(TempTableViewCell *)cell
{
    
    
}



//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    int number = scrollView.contentOffset.y / 44;
//    self.timerInt = number;
//   // [self resetContentOffsetIfNeeded];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat ratioY = scrollView.contentOffset.y/yRange ; // y轴上移动的百分比
    NSLog(@"ratioY --- %f\ncontentoffsety---%f",ratioY,scrollView.contentOffset.y);
    
//    CGFloat viewHeight = scrollView.yj_height + scrollView.contentInset.top;
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    TempTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    if (ratioY <= 1) {
//        [UIView animateWithDuration:2 animations:^{
//            cell.contentView.alpha = 1;
//        } completion:nil];
//    }else{
//        [UIView animateWithDuration:2 animations:^{
//            cell.contentView.alpha = 0;
//        } completion:nil];
//    }
    
//    for (TempTableViewCell *cell in [self.tableView indexPathsForVisibleRows]) {
//
//        if (ratioY <= 1) {
//            [UIView animateWithDuration:1.0 animations:^{
//                cell.contentView.alpha = 1;
//            } completion:^(BOOL finished) {
//
//            }];
//        }else{
//            [UIView animateWithDuration:1.0 animations:^{
//                cell.contentView.alpha = 0;
//            } completion:^(BOOL finished) {
//
//            }];
//        }
//
//    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}




#pragma mark ============ test ============
- (void)test
{
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
    backgroundView.frame = self.view.bounds;
    [self.view addSubview:backgroundView];
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    [self.view addSubview:demoContainerView];
    
    self.title = @"轮播Demo";
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"disableScrollGesture可以设置禁止拖动",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    CGFloat w = self.view.bounds.size.width;
    
    // 网络加载 --- 创建只上下滚动展示文字的轮播器
    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 750, w, 80) delegate:self placeholderImage:nil];
    cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollView4.onlyDisplayText = YES;
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"纯文字上下滚动轮播"];
    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
    [titlesArray addObjectsFromArray:titles];
    cycleScrollView4.titlesGroup = [titlesArray copy];
    [cycleScrollView4 disableScrollGesture];
    
    [demoContainerView addSubview:cycleScrollView4];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
