//
//  ViewController.m
//  FQGCDManageDemo
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FQGCDManage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
}

/*!
 *  @brief  使用dispatch_group_enter和dispatch_group_leave函数实现组处理
 */
- (void)groupTest2 {
    
    //创建调度组
    dispatch_group_t group = dispatch_group_create();
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //进入队列
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:2];
        NSLog(@"下载第一张图");
        
        //离开队列
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:1];
        NSLog(@"下载第二张图");
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        
        [NSThread sleepForTimeInterval:3];
        NSLog(@"下载第三张图");
        
        dispatch_group_leave(group);
    });
    
    //等待调度队列wait相当于一个阻塞状态
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"更新UI");
    /*!
     *  @brief  输出结果
     *
     2016-03-15 22:36:49.277 GCD其他方法[6783:209444] 下载第二张图
     2016-03-15 22:36:50.280 GCD其他方法[6783:209429] 下载第一张图
     2016-03-15 22:36:51.279 GCD其他方法[6783:209445] 下载第三张图
     2016-03-15 22:36:51.279 GCD其他方法[6783:209352] 更新UI
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
