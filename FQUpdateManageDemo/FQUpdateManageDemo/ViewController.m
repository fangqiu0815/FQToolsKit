//
//  ViewController.m
//  FQUpdateManageDemo
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FQUpdateManage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)forceUpdate:(id)sender {
    [FQUpdateManage checkVersionFromServiceToUpdateWithForce:YES];
    
}

- (IBAction)noForceUpdate:(id)sender {
    [FQUpdateManage checkVersionFromServiceToUpdateWithForce:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
