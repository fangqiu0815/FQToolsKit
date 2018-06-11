//
//  FQBaseViewController.h
//  FQGoldLinkiOS
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQBaseViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
UITextViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *timeZones;

@end
