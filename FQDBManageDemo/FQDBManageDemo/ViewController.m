//
//  ViewController.m
//  FQDBManageDemo
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "UIView+FQTextInputKeyBoard.h"
#import "UserInfoModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *ageTextF;
@property (weak, nonatomic) IBOutlet UITextField *jobTextF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"测试";

}

- (IBAction)fq_query:(id)sender {
    UserInfoModel *userInfo = [UserInfoModel fq_findByPK:1];
    
    NSLog(@"name---%@\nage---%@\njob---%@",userInfo.name,userInfo.age,userInfo.job);
}

- (IBAction)fq_insert:(id)sender {
    
    UserInfoModel *model = [[UserInfoModel alloc]init];
    [UserInfoModel fq_clearTable];
    model.name=self.nameTextF.text;
    model.age=self.ageTextF.text;
    model.job=self.jobTextF.text;
    //插入到数据库中
    [model fq_save];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
