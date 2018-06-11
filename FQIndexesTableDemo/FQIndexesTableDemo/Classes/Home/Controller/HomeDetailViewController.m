//
//  HomeDetailViewController.m
//  FQIndexesTableDemo
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"球队介绍";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];

}

- (void)setupUI
{
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenW/2-40/2), 100, 80, 80)];
    iconImageView.image = [UIImage imageNamed:self.iconStr];
    [self.view addSubview:iconImageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((ScreenW/2-80/2), 200, 160, 40)];
    label.text = self.nameStr;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
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
