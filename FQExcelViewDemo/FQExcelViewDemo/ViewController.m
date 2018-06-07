//
//  ViewController.m
//  FQExcelViewDemo
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FQExcelViewConfig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FQExcelView *view = [[FQExcelView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300)];
    view.fq_rowHeight = 50;
    view.fq_columnNum = 7;
    view.fq_fixedColumn = 1;
    view.fq_fixedRow = 1;
    view.fq_excelDataSource = @[
                                @[@"地区",@"当日收入（万）",@"同比",@"环比",@"当月收入（万）",@"同比",@"环比"],
                                @[@"厦门",@"2300",@"2%",@"3.1%",@"5600",@"2%",@"2%"],
                                @[@"泉州",@"4000",@"2%",@"3.1%",@"5600",@"2%",@"2%"],
                                @[@"福州",@"5000",@"2%",@"3.1%",@"5600",@"2%",@"2%"],
                                @[@"漳州",@"6000",@"2%",@"3.1%",@"5600",@"2%",@"2%"],
                                @[@"莆田",@"7000",@"2%",@"3.1%",@"5600",@"2%",@"2%"],
                                @[@"龙岩",@"8000",@"2%",@"3.1%",@"5600",@"2%",@"2%"],
                                ];
//    view.fq_titleMergeArr = @[@{@"col":@"3",@"row":@"0",@"span":@"3"}];
    view.fq_columnsWidthArr = @[@"60",@"140",@"60",@"60",@"140",@"60",@"60"];

    [self.view addSubview:view];




}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
