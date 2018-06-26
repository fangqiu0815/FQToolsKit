//
//  ViewController.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "BaseAppViewController.h"
#import "AliPayAppViewController.h"
#import "GovAppViewController.h"
#import "MeiTuanAppViewController.h"

static NSString *cellID = @"cell";

@interface ViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
/** <#name#> */
@property (nonatomic, copy) NSArray *dataSource;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联动";
    [self.view addSubview:self.tableView];
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@"基础联动",@"支付宝APP联动",@"国务院APP联动",@"美团外卖APP联动"];
    }
    return _dataSource;
}

#pragma mark - tableView 数据源代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[BaseAppViewController new] animated:YES];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:[AliPayAppViewController new] animated:YES];
    }else if (indexPath.row == 2){
        [self.navigationController pushViewController:[GovAppViewController new] animated:YES];
    }else{
        [self.navigationController pushViewController:[MeiTuanAppViewController new] animated:YES];
    }
    
}

#pragma mark - 懒加载 tableView -
// MARK: - 左边的 tableView
- (UITableView *)tableView {
    
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:tableView];
        _tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 50;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
