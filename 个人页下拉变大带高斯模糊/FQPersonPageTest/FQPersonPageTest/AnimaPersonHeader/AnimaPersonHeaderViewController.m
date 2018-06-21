//
//  AnimaPersonHeaderViewController.m
//  FQPersonPageTest
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AnimaPersonHeaderViewController.h"
#import "PayBillTitleView.h"
#import "PayTheBillHeaderView.h"
#import "UIImage+Extension.h"
#import "UIView+Frame.h"
#import "Masonry.h"

#define ViewHeight  [UIApplication sharedApplication].statusBarFrame.size.height
#define ViewWidth   [UIApplication sharedApplication].statusBarFrame.size.width
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface AnimaPersonHeaderViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIImage *_barShadowImage;
}
/** <#name#> */
@property (nonatomic, strong) UITableView *tableView;
/** <#name#> */
@property (nonatomic, strong) PayBillTitleView *titleView;
/** <#name#> */
@property (nonatomic, strong) PayTheBillHeaderView *headerView;
/** <#name#> */
@property (nonatomic, strong) UIImageView *navigationBarBackgroundView;




@end

@implementation AnimaPersonHeaderViewController
{
    BOOL bInitRange;
    CGFloat  yRange; // y轴方向需要移动的距离
    CGFloat  xRange;  // x轴方向需要移动的距离
    CGPoint  originPoint; // 移动图片初始位置, 底线起点
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 初始化
    bInitRange = NO;
    yRange = 0;
    xRange = 0;
    originPoint = CGPointMake(0, 0);
    
    self.tableView.contentInset = UIEdgeInsetsMake(0 - (ViewHeight + 44), 0, -44, 0);
    self.navigationItem.titleView = self.titleView;
    self.titleView.iconImageView.hidden = YES;
    [self.view addSubview:self.tableView];
    
    
}

- (UIImageView *)navigationBarBackgroundView
{
    if (!_navigationBarBackgroundView) {
        _navigationBarBackgroundView = [[UIImageView alloc]initWithImage:[UIImage createImageWithColor:[UIColor blueColor]]];
    }
    return _navigationBarBackgroundView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar insertSubview:self.navigationBarBackgroundView atIndex:0];
    self.navigationBarBackgroundView.frame = CGRectMake(0, -ViewHeight, ViewWidth, self.navigationController.navigationBar.bounds.size.height + ViewHeight);
    self.navigationBarBackgroundView.alpha = 0;
    
    _barShadowImage = self.navigationController.navigationBar.shadowImage;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (bInitRange == NO) {
        bInitRange = YES;
        CGRect smallIconRect = [self.titleView convertRect:self.titleView.iconImageView.frame toView:nil];
        CGRect bigIconRect = [self.headerView convertRect:self.headerView.iconImageView.frame toView:nil];

        originPoint = CGPointMake(bigIconRect.origin.x, bigIconRect.origin.y + bigIconRect.size.height);
        xRange = fabs((smallIconRect.origin.y + smallIconRect.size.height) - (bigIconRect.origin.y + bigIconRect.size.height));
        yRange = fabs((smallIconRect.origin.y + smallIconRect.size.height) - (bigIconRect.origin.y + bigIconRect.size.height));
        NSLog(@"xrange---%f\nyrange---%f\n",xRange,yRange);
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (yRange <= 0) return;
    if (scrollView.contentOffset.y <= 0) {
        if (self.headerView.iconImageView.yj_width == 60) {
            return;
        }else{
            self.headerView.iconImageView.yj_width = 60;
            self.headerView.iconImageView.yj_x = 15;
            self.headerView.titleLab.alpha = 1.0;
            return;
        }
    }
    CGFloat ratioY = scrollView.contentOffset.y/yRange ; // y轴上移动的百分比
    if (ratioY >= 1) {
        self.headerView.titleLab.alpha = 0.0;
        self.headerView.iconImageView.alpha = 0.0;
        self.titleView.iconImageView.hidden = NO;
        self.navigationBarBackgroundView.alpha = 1.0;
    }else{
        
        self.navigationBarBackgroundView.alpha = 0;
        self.headerView.titleLab.alpha = 1 - ratioY;
        self.headerView.iconImageView.alpha = 1.0;
        self.titleView.iconImageView.hidden = YES;
        
        self.headerView.iconImageView.yj_x = 15 + xRange * ratioY;
        self.headerView.iconImageView.yj_height = 60 - 30 * ratioY;
        self.headerView.iconImageView.yj_width = self.headerView.iconImageView.yj_height;
        self.headerView.iconImageView.layer.masksToBounds = YES;
        self.headerView.iconImageView.layer.cornerRadius = self.headerView.iconImageView.yj_height/2;
    }
    
    NSLog(@"header.x----%f\nheader.icon.x---%f\nheader.icon.hei---%f\nratioY---%f",self.headerView.yj_x,self.headerView.iconImageView.yj_x,self.headerView.iconImageView.yj_height,ratioY);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个", indexPath.row];
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    self.headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180);
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = _barShadowImage;
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationBarBackgroundView removeFromSuperview];
}

- (PayBillTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[PayBillTitleView alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    }
    return _titleView;
}

- (PayTheBillHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[PayTheBillHeaderView alloc]init];
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
