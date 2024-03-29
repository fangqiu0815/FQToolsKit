//
//  NewViewController.m
//  FQPersonPageTest
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "NewViewController.h"
#import "ViewController.h"
#import "Masonry.h"
#import "AnimaPersonHeaderViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"点击跳转1" forState:0];
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:self action:@selector(clickme) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor: [UIColor blueColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    UIButton *button1 = [[UIButton alloc]init];
    [button1 setTitle:@"点击跳转2" forState:0];
    [button1 setTitleColor:[UIColor blackColor] forState:0];
    [button1 addTarget:self action:@selector(clickmeAll) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundColor: [UIColor blueColor]];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(button.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
}

- (void)clickme
{
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

- (void)clickmeAll
{
    
    [self.navigationController pushViewController:[AnimaPersonHeaderViewController new] animated:YES];
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
