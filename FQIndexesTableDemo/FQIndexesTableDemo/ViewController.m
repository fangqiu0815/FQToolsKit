//
//  ViewController.m
//  FQIndexesTableDemo
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "HomeTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择索引类型";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController;
    switch (indexPath.row) {
        case 0:
        {
            HomeTableViewController *indexViewController = [HomeTableViewController new];
            indexViewController.indexViewStyle = FQIndexViewStyleDefault;
            indexViewController.hasSearch = YES;
            viewController = indexViewController;
        }
            break;
            
        case 1:
        {
            HomeTableViewController *indexViewController = [HomeTableViewController new];
            indexViewController.indexViewStyle = FQIndexViewStyleCenterToast;
            indexViewController.hasSearch = YES;
            viewController = indexViewController;
        }
            break;
            
        case 2:
        {
            HomeTableViewController *indexViewController = [HomeTableViewController new];
            indexViewController.indexViewStyle = FQIndexViewStyleDefault;
            viewController = indexViewController;
        }
            break;
            
        case 3:
        {
            HomeTableViewController *indexViewController = [HomeTableViewController new];
            indexViewController.indexViewStyle = FQIndexViewStyleCenterToast;
            viewController = indexViewController;
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"指向点类型";
            cell.detailTextLabel.text = @"有搜索";
        }
            break;
            
        case 1:
        {
            cell.textLabel.text = @"中心提示弹层";
            cell.detailTextLabel.text = @"有搜索";
        }
            break;
            
        case 2:
        {
            cell.textLabel.text = @"指向点类型";
            cell.detailTextLabel.text = @"无搜索";
        }
            break;
            
        case 3:
        {
            cell.textLabel.text = @"中心提示弹层";
            cell.detailTextLabel.text = @"无搜索";
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
