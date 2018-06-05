//
//  ViewController.m
//  FQBaseItemDataSource
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FQBaseItemDataSourceCell.h"

@interface ViewController ()

/** tableview */
@property (nonatomic, strong) UITableView *tableView;
/** datasource */
@property (nonatomic, strong) FQBaseItemDataSourceCell *dataSource;
/** 数据数组 */
@property (nonatomic, strong) NSMutableArray *array;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [NSMutableArray array];
    [self setupData];
    [self setupUI];
    
}

- (void)setupData
{
    FQBaseItemGroup *itemGroup = [[FQBaseItemGroup alloc]init];
    FQBaseItem *item1 = [FQBaseItem baseItemWithTitleStr:@"haode" andPicIcon:@"icon_dizhi" anditemType:FQBaseItemTypeArrow];
    item1.selectBlock = ^(NSIndexPath *indexPath) {
        NSLog(@"haode");
    };
    [itemGroup.items addObject:item1];
    FQBaseItem *item2 = [FQBaseItem baseItemWithTitleStr:@"yingaishi" andPicIcon:@"icon_dizhi" andDetailStr:@"sdashdiash" anditemType:FQBaseItemTypeDetail];
    item2.selectBlock = ^(NSIndexPath *indexPath) {
        NSLog(@"yingaishi");
    };
    [itemGroup.items addObject:item2];

    FQBaseItem *item3 = [FQBaseItem baseItemWithTitleStr:@"enennen" andPicIcon:@"icon_dizhi" anditemType:FQBaseItemTypeSwitch];
    item3.switchClickBlock = ^(BOOL on) {
        NSLog(@"休息时间开关状态===%@",on?@"open":@"close");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"休息时间开关" message:on?@"打开":@"关闭" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    };
    [itemGroup.items addObject:item3];
    [_array addObject:itemGroup];
    
    self.dataSource = [[FQBaseItemDataSourceCell alloc]initWithItems:_array];
}

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self.dataSource;
//    tableView.rowHeight = 60;
    self.tableView = tableView;
    tableView.dataSource = self.dataSource;
    [self.view addSubview:tableView];
    
    UILabel *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.text = @"HeadView";
    headView.font = [UIFont boldSystemFontOfSize:30.0f];
    headView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = headView;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
