//
//  ViewController.m
//  FQTypeButtonDemo
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FQTypeButtonView.h"

@interface ViewController ()<FQTypeButtonClickDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FQTypeButtonView *buttonView = [[FQTypeButtonView alloc] initWithFrame:CGRectMake(0.0, 80, CGRectGetWidth(self.view.bounds), heightTypeButtonView) andFatherView:self.view];
    buttonView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    buttonView.delegate = self;
    buttonView.titles = @[@"综合", @"销量", @"价格"];
    buttonView.enableTitles = @[@"价格"];
    buttonView.colorNormal = [UIColor blackColor];
    buttonView.colorSelected = [UIColor redColor];
    NSDictionary *dict01 = [NSDictionary dictionary];
    NSDictionary *dict02 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"accessoryArrow_down"], keyImageNormal, [UIImage imageNamed:@"accessoryArrow_downSelected"], keyImageSelected, nil];
    NSDictionary *dict03 = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"priceImage_normal"], keyImageNormal, [UIImage imageNamed:@"priceImage_down"], keyImageSelected, [UIImage imageNamed:@"priceImage_up"], keyImageSelectedDouble, nil];
    buttonView.imageTypeArray = @[dict01, dict02, dict03];
    buttonView.selectedIndex = -1;
    
}

- (void)typeButtonClickWithIndex:(NSInteger)index isDescending:(BOOL)isDescending
{
    NSLog(@"click index %ld, isDescending %d", index, isDescending);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
