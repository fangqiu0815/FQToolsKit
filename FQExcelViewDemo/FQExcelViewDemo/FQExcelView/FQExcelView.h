//
//  FQExcelView.h
//  FQExcelViewDemo
//
//  Created by mac on 2018/6/7.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQExcelView : UIView

/** 总列数 */
@property (nonatomic, assign) NSInteger fq_columnNum;

/** 固定行数 */
@property (nonatomic, assign) NSInteger fq_fixedRow;

/** 固定列数 */
@property (nonatomic, assign) NSInteger fq_fixedColumn;

/** 行高 */
@property (nonatomic, assign) NSInteger fq_rowHeight;

/** 列宽的数组 写法形式 @["100",@"90",@"100"] */
@property(nonatomic, strong) NSArray *fq_columnsWidthArr;

/** 表格数据源 */
@property (nonatomic, strong) NSArray *fq_excelDataSource;

/** 标题合并数组 即单元格合并  写法形式 @[@{@"col":@"2",@"row":@"0",@"span":@"2"}] （第2列 第0行 合并后面的2个单元格） */
@property (nonatomic, strong) NSArray *fq_titleMergeArr;

#pragma mark ============ 标题设置 ============
/** 标题字体颜色 */
@property (nonatomic, strong) UIColor *fq_titleFontColor;

/** 标题字体大小 */
@property (nonatomic, strong) UIFont *fq_titleFont;

/** 标题背景颜色 */
@property (nonatomic, strong) UIColor *fq_titleBackgroundColor;

/** 标题 表格线的颜色 */
@property (nonatomic, strong) UIColor *fq_titleLineColor;

#pragma mark ============ 内容设置 ============
/** 内容字体颜色 */
@property (nonatomic, strong) UIColor *fq_contentFontColor;

/** 内容字体大小 */
@property (nonatomic, strong) UIFont *fq_contentFont;

/** 内容 表格线的颜色 */
@property (nonatomic, strong) UIColor *fq_contentLineColor;

/** 内容 表体左边偶数行背景色 */
@property (nonatomic, strong) UIColor *fq_bodyLeftEvenBgColor;

/** 内容 表体左边奇数行背景色 */
@property (nonatomic, strong) UIColor *fq_bodyLeftUnEvenBgColor;

/** 内容 表体右边偶数行背景色 */
@property (nonatomic, strong) UIColor *fq_bodyRigtEvenBgColor;

/** 内容 表体右边奇数行背景色 */
@property (nonatomic, strong) UIColor *fq_bodyRightUnEvenBgColor;





@end
