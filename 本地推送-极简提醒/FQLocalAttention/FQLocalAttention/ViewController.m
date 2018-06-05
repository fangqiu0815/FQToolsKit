//
//  ViewController.m
//  FQLocalAttention
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FQLocalNotificationTool.h"
#import "NSString+FQString.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI
{
    UIButton *notBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    notBtn.frame = CGRectMake(20, 200, 320-40, 40);
    [notBtn setBackgroundColor:[UIColor greenColor]];
    [notBtn setTitle:@"click me!!!" forState:UIControlStateNormal];
    notBtn.layer.masksToBounds = YES;
    notBtn.layer.cornerRadius = 5.0;
    [notBtn addTarget:self action:@selector(notBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notBtn];
}

- (void)notBtnClick:(UIButton *)sender
{
    // 此处使用两个时间戳的差来计算，10秒后开启通知
    NSInteger time = [[NSString BA_time_getTimeStamp] integerValue] + 10 - [[NSString BA_time_getTimeStamp] integerValue];
    [FQLocalNotificationTool registerLocalNotification:time];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
