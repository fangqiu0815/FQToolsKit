//
//  ProfileViewController.m
//  CKNavSmoothDemo
//
//  Created by ck on 2017/6/1.
//  Copyright © 2017年 caike. All rights reserved.
//

#import "ProfileViewController.h"
#import "UINavigationController+Smooth.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic, assign)BOOL statusBarShouldLight;

/** <#name#> */
@property (nonatomic, strong) UIButton *backButton;

@end

static BOOL statusBarShouldLight = YES;

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navBarBgAlpha = 0;
    self.navBarTintColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 100, 40)];
    [button setTitle:@"back" forState:0];
    [button setBackgroundColor:[UIColor grayColor]];
    self.backButton = button;
    [button setTitleColor:[UIColor blackColor] forState:0];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    index = 5;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(returnsendCodeAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode: UITrackingRunLoopMode];
    
}

-(void)returnsendCodeAction
{
    NSLog(@"%ld",(long)index);
    if (index <= 0){
        [_backButton setBackgroundColor:[UIColor grayColor]];
        _backButton.userInteractionEnabled = YES;
        [_backButton setTitle:@"back" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [timer invalidate];
    }
    else
    {
        index--;
        NSString *indexStr = [NSString stringWithFormat:@"back(%lds)",(long)index];
        [_backButton setBackgroundColor:[UIColor grayColor]];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_backButton setTitle:indexStr forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blackColor] forState:0];
        _backButton.userInteractionEnabled = NO;
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (statusBarShouldLight) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat showNavBarOffSetY = 200 - self.topLayoutGuide.length;
    
//    if (contentOffsetY <= 0) {
//        self.headerView.frame = CGRectMake(0, 2*contentOffsetY, CGRectGetWidth(self.headerView.frame), 200 - contentOffsetY);
//    }
    
    if (contentOffsetY > showNavBarOffSetY) {
        CGFloat newAlpha = (contentOffsetY - showNavBarOffSetY) / 40.0;
        newAlpha = newAlpha < 1 ? newAlpha : 1;
        self.navBarBgAlpha = newAlpha;
        if (newAlpha > 0.8) {
            self.navBarTintColor = [UIColor orangeColor];
            statusBarShouldLight = NO;
        }
        else{
            self.navBarTintColor = [UIColor whiteColor];
            statusBarShouldLight = YES;
        }
    }
    else{
        self.navBarBgAlpha = 0;
        self.navBarTintColor = [UIColor whiteColor];
        statusBarShouldLight = YES;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (IBAction)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)popToRootAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
