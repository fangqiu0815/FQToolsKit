//
//  FQIndexesView.h
//  FQIndexesTableDemo
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FQIndexesViewConfig.h"

@class FQIndexesView;

@protocol FQIndexViewDelegate <NSObject>

@optional
/**
 当点击或者滑动索引视图时，回调这个方法
 
 @param indexView 索引视图
 @param section   索引位置
 */
- (void)indexView:(FQIndexesView *)indexView didSelectAtSection:(NSUInteger)section;

/**
 当滑动tableView时，索引位置改变，你需要自己返回索引位置时，实现此方法。
 不实现此方法，或者方法的返回值为 SCIndexViewInvalidSection 时，索引位置将由控件内部自己计算。
 
 @param indexView 索引视图
 @param tableView 列表视图
 @return          索引位置
 */
- (NSUInteger)sectionOfIndexView:(FQIndexesView *)indexView tableViewDidScroll:(UITableView *)tableView;

@end

@interface FQIndexesView : UIControl

@property (nonatomic, weak) id<FQIndexViewDelegate> delegate;

// 索引视图数据源
@property (nonatomic, copy) NSArray<NSString *> *dataSource;

// 当前索引位置
@property (nonatomic, assign) NSInteger currentSection;

// tableView在NavigationBar上是否半透明
@property (nonatomic, assign) BOOL translucentForTableViewInNavigationBar;

// 索引视图的配置
@property (nonatomic, strong, readonly) FQIndexesViewConfig *configuration;

// SCIndexView 会对 tableView 进行 strong 引用，请注意，防止“循环引用”
- (instancetype)initWithTableView:(UITableView *)tableView configuration:(FQIndexesViewConfig *)configuration;



@end


