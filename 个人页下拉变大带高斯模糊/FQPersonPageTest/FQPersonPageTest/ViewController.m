//
//  ViewController.m
//  FQPersonPageTest
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "TestViewController.h"
#import "FQHeadView.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 自定义颜色 */
#define RGB(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
/** 带透明度的自定义颜色 */
#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define HeadViewHeight  183

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

/** tableview */
@property (nonatomic, strong) UITableView *tableView;
/** 头部视图 */
@property (nonatomic, strong) FQHeadView *headView;
@property (nonatomic, strong) UILabel * pageTitle;
@property (nonatomic, strong) UIView *view_bar;

/** 返回 */
@property (nonatomic, strong) UIButton * backBtn;


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FQHeadView *headView = [[FQHeadView alloc]init];
    self.headView = headView;
    headView.frame = CGRectMake(0, -HeadViewHeight, [UIScreen mainScreen].bounds.size.width, HeadViewHeight);
    headView.backgroundColor = [UIColor whiteColor];
    headView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:headView];
    
    UIView *view_bar = [[UIView alloc]init];
    self.view_bar = view_bar;
    view_bar.backgroundColor = [UIColor clearColor];
    [self.view addSubview: view_bar];
    [view_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton * meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [meBtn setImage:[UIImage imageNamed:@"推荐人-拷贝"] forState:UIControlStateNormal];
    [meBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:meBtn];
    [meBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-11);
    }];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn = backBtn;
    [backBtn setTitle:@"返回" forState:0];
    [backBtn setTitleColor:[UIColor whiteColor] forState:0];
    [backBtn addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-11);
    }];
    
    self.pageTitle = [[UILabel alloc]init];
    self.pageTitle.text = @"我";
    self.pageTitle.hidden = YES;
    self.pageTitle.textColor = [UIColor clearColor];
    [view_bar addSubview:self.pageTitle];
    [self.pageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(meBtn);
        make.centerX.equalTo(view_bar);
    }];
    
}

- (void)backclick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (FQHeadView *)headView{
    if (_headView == nil) {
        _headView = [[FQHeadView alloc]init];
        _headView.frame = CGRectMake(0, -HeadViewHeight, [UIScreen mainScreen].bounds.size.width, HeadViewHeight);
        _headView.backgroundColor = [UIColor whiteColor];
        _headView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _headView;
}

-(void)click{
    
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (scrollView == self.tableView) {
        if(yOffset< -(HeadViewHeight+20))
        {
            CGRect frame= self.headView.frame;
            frame.origin.y = yOffset;
            frame.size.height = -yOffset;
            frame.origin.x = (yOffset* ScreenW/183+ScreenW)/2;
            frame.size.width = -yOffset*ScreenW/183;
            self.headView.frame = frame;
        }else if(yOffset<-64){
            [self.view_bar setHidden:NO];
            self.pageTitle.hidden = NO;
            [self.backBtn setTitleColor:[UIColor whiteColor] forState:0];
            self.pageTitle.textColor = RGBA(255, 255, 255, (HeadViewHeight+yOffset)/ 100);
            self.view_bar.backgroundColor = RGBA(41,121,246,(HeadViewHeight+yOffset)/ 100);
        }else
        {
            [self.view_bar setHidden:NO];
            self.pageTitle.hidden = NO;
            [self.backBtn setTitleColor:[UIColor blackColor] forState:0];
            self.view_bar.backgroundColor = RGBA(41,121,246,1);
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell---%zd",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[TestViewController new] animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(HeadViewHeight, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.tableFooterView = [[UITableView alloc] init];
        _tableView.rowHeight = 60;
        if(@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view addSubview:self.tableView];

    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
