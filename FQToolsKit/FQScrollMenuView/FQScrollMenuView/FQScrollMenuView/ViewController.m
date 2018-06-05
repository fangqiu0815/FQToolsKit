//
//  ViewController.m
//  FQScrollMenuView
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "FQScrollMenu.h"
#import "DataSource.h"
#define IMG(name)           [UIImage imageNamed:name]
#import <Masonry.h>

@interface ViewController ()<FQScrollMenuDelegate,FQScrollMenuDataSource>
{
    BOOL _showHeader;
    BOOL _automaticUpdate;
}
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <DataSource *>*dataArray;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray <DataSource *>*allDataSource;
/**
 * 菜单
 */
@property (nonatomic, strong) FQScrollMenu *scrollMenu;
/**
 *  分区数
 */
@property (nonatomic, assign) NSUInteger number;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    //GCD
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self createData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.scrollMenu fq_reloadData];
        });
    });
    
}

#pragma mark -  Data
- (void)createData{
    
    
    NSArray *images = @[IMG(@"icon_cate"),
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498711713465&di=d986d7003deaae41342dd9885c117e38&imgtype=0&src=http%3A%2F%2Fs9.rr.itc.cn%2Fr%2FwapChange%2F20168_3_0%2Fa86hlk59412347762310.GIF",
                        IMG(@"icon_movie"),
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498711713465&di=d986d7003deaae41342dd9885c117e38&imgtype=0&src=http%3A%2F%2Fs9.rr.itc.cn%2Fr%2FwapChange%2F20168_3_0%2Fa86hlk59412347762310.GIF",
                        IMG(@"icon_stay"),
                        IMG(@"icon_ traffic"),
                        IMG(@"icon_ scenic"),
                        IMG(@"icon_fitness"),
                        IMG(@"icon_fitment"),
                        IMG(@"icon_hairdressing"),
                        IMG(@"icon_mom"),
                        IMG(@"icon_study"),
                        IMG(@"icon_travel"),
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498711713465&di=d986d7003deaae41342dd9885c117e38&imgtype=0&src=http%3A%2F%2Fs9.rr.itc.cn%2Fr%2FwapChange%2F20168_3_0%2Fa86hlk59412347762310.GIF"];
    NSArray *titles = @[@"美食",
                        @"休闲娱乐",
                        @"电影/演出",
                        @"KTV",
                        @"酒店住宿",
                        @"火车票/机票",
                        @"旅游景点",
                        @"运动健身",
                        @"家装建材",
                        @"美容美发",
                        @"母婴",
                        @"学习培训",
                        @"旅游出行",
                        @"动态图\n从网络获取"];
    
    for (NSUInteger idx = 0; idx< images.count; idx ++) {
        
        DataSource *object = [[DataSource alloc] init];
        object.itemDescription = titles[idx];
        object.itemImage = images[idx];
        object.itemPlaceholder = IMG(@"placeholder");
        
        [self.allDataSource addObject:object];
    }
    
    [self.dataArray addObjectsFromArray:self.allDataSource];
    
    
}

- (void)setupUI
{
    self.number = 1;
    
    _showHeader = YES;
    _automaticUpdate = YES;
    self.scrollMenu = [[FQScrollMenu alloc]initWithFrame:CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width ,200 ) scrollMenuDelegate:self];
    self.scrollMenu.backgroundColor = [UIColor greenColor];
    self.scrollMenu.currentPageIndicatorTintColor = [UIColor colorWithRed:107/255.f green:191/255.f blue:255/255.f alpha:1.0];
    [FQScrollMenuItem appearance].textFont = [UIFont systemFontOfSize:12];
    [FQScrollMenuItem appearance].textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
    [self.view addSubview:self.scrollMenu];
}


- (NSMutableArray<DataSource *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray<DataSource *> *)allDataSource{
    if (_allDataSource == nil) {
        _allDataSource = [NSMutableArray array];
    }
    return _allDataSource;
}

- (NSInteger)numberOfSectionsInScrollMenu:(FQScrollMenu *)scrollMenu
{
    return self.number;
}

- (NSInteger)scrollMenu:(FQScrollMenu *)scrollMenu numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGSize)itemSizeOfScrollMenu:(FQScrollMenu *)menu{
    
    return CGSizeMake(kScale(75), kScale(90));
}

- (id<FQObjectProtocol>)scrollMenuCell:(FQScrollMenu *)scrollMenu cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataArray[indexPath.item];
}

/** 如果不要页眉，不用遵守此协议  */
- (UIView *)scrollMenu:(FQScrollMenu *)menu headerInSection:(NSUInteger)section
{
    
    if (_showHeader) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScale(30))];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:kScale(17)];
        label.text = [NSString stringWithFormat:@"--  SECTION %ld  --",section];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(view);
        }];
        
        switch (section%3) {
            case 0:
                label.textColor = [UIColor greenColor];
                break;
            case 1:
                label.textColor = [UIColor orangeColor];
                break;
            case 2:
                label.textColor = [UIColor blueColor];
                break;
            default:
                break;
        }
        
        return view;
    }
    
    return nil;
    
}

- (CGFloat)heightOfHeaderInScrollMenu:(FQScrollMenu *)menu{
    return   _showHeader ? kScale(30) : 0;
}

- (void)scrollMenu:(FQScrollMenu *)menu didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"IndexPath:%@",indexPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
