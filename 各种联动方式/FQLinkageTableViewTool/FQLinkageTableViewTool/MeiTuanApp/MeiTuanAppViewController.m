//
//  MeiTuanAppViewController.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MeiTuanAppViewController.h"
#import "MTTableViewCell.h"
#import "MTGoodsCarToolBar.h"
#import "MTDetailNavgation.h"
#import "MTDetailCollection.h"

@interface MeiTuanAppViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) MTDetailNavgation * navgation;
@property (nonatomic , strong) MTDetailCollection * mainCollection;
@property (nonatomic , strong) MTGoodsCarToolBar  * goodsCarBar;
@property (nonatomic , strong) MTGoodsContro * goodVc;
@property (nonatomic , assign) CGPoint  point;



@end

@implementation MeiTuanAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
