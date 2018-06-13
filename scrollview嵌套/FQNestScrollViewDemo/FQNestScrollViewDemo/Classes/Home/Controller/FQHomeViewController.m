//
//  FQHomeViewController.m
//  FQNestScrollViewDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQHomeViewController.h"
#import "FQHeaderCell.h"
#import "FQHeaderOtherCell.h"
#import "FQHeaderContainerCell.h"
#import "FQCustomTableView.h"
#import "FQSectionView.h"

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125, 2436),[[UIScreen mainScreen]currentMode].size):NO)

@interface FQHomeViewController ()<UITableViewDelegate,UITableViewDataSource,FQHeaderContainerScrollViewDelegate>

/** <#name#> */
@property (nonatomic, strong) FQSectionView *sectionView;

@property (nonatomic, strong) FQCustomTableView *tableView;

@property (nonatomic, strong) FQHeaderContainerCell *containerCell;

@property (nonatomic, assign) BOOL canScroll;


@end

@implementation FQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联动Demo";
    
    [self.view addSubview:self.tableView];
    
    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];

}

#pragma mark - Notification

- (void)changeScrollStatus {
    self.canScroll = YES;
    self.containerCell.objectCanScroll = NO;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        
        CGFloat offset = 64;
        if (iPhoneX) {
            offset = 88;
        }
        CGFloat bottomCellOffset = [self.tableView rectForSection:1].origin.y - offset;
        bottomCellOffset = floorf(bottomCellOffset);
        
        if (scrollView.contentOffset.y >= bottomCellOffset) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            if (self.canScroll) {
                self.canScroll = NO;
                self.containerCell.objectCanScroll = YES;
            }
        }else{
            //子视图没到顶部
            if (!self.canScroll) {
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            }
        }
    }
}

#pragma mark - YHDContainerCellDelegate

- (void)mmtdOptionalScrollViewDidScroll:(UIScrollView *)scrollView {
    self.tableView.scrollEnabled = NO;
}

- (void)mmtdOptionalScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger page = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    [self.sectionView.segmentControl setSelectedSegmentIndex:page animated:YES];
    
    self.tableView.scrollEnabled = YES;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

// 由于Demo中几个cell个数有限且全部不一样，所以这儿不用重用机制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 海报
            FQHeaderCell *cell = [[FQHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FQHeaderCell"];
            return cell;
        }
        // 简介
        FQHeaderOtherCell *cell = [[FQHeaderOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FQHeaderOtherCell"];
        return cell;
    }
    //
    FQHeaderContainerCell *containercell = [[FQHeaderContainerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FQHeaderContainerCell"];
    self.containerCell = containercell;
    containercell.delegate = self;
    return containercell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 300;
        }
        return 60;
    }
    return self.view.frame.size.height - 64 - 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    return 60.0f;
}

#pragma mark - Init Views

- (FQCustomTableView *)tableView {
    if (!_tableView) {
        _tableView = [[FQCustomTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (FQSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[FQSectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        __weak typeof(self) weakSelf = self;
        [_sectionView.segmentControl setIndexChangeBlock:^(NSInteger index) {
            weakSelf.containerCell.isSelectIndex = YES;
            [weakSelf.containerCell.scrollView setContentOffset:CGPointMake(index*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
        }];
    }
    return _sectionView;
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
