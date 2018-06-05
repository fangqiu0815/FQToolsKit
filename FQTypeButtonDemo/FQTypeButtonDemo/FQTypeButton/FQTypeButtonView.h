//
//  FQTypeButtonView.h
//  FQTypeButtonDemo
//
//  Created by mac on 2018/5/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 默认行高
#define heightTypeButtonView (40.0)
static NSString *const keyImageNormal         = @"keyImageNormal";
static NSString *const keyImageSelected       = @"keyImageSelected";
static NSString *const keyImageSelectedDouble = @"keyImageSelectedDouble";

@protocol FQTypeButtonClickDelegate <NSObject>

@optional
- (void)typeButtonClickWithIndex:(NSInteger)index isDescending:(BOOL)isDescending;

@end

@interface FQTypeButtonView : UIView

/**
 初始化方法

 @param frame 视图约束
 @param view  父视图
 @return 初始化
 */
- (instancetype)initWithFrame:(CGRect)frame andFatherView:(UIView *)view;

/** 代理事件 */
@property (nonatomic, weak) id <FQTypeButtonClickDelegate> delegate;

/** 是否显示切换滚动条（默认不显示。设置标题前设置） */
@property (nonatomic, assign) BOOL showScrollLine;

/** 字体大小（默认12。设置标题后设置） */
@property (nonatomic, strong) UIFont *titleFont;

/** 选中后字体大小（默认12。设置标题后设置） */
@property (nonatomic, strong) UIFont *titleFontSelected;

/// 按钮标题数组
@property (nonatomic, strong) NSArray *titles;

/// 选择状态颜色
@property (nonatomic, strong) UIColor *colorSelected;

/// 未选择状态颜色
@property (nonatomic, strong) UIColor *colorNormal;

/// 可重复操作的按钮标题（默认不能重复操作）
@property (nonatomic, strong) NSArray *enableTitles;

/// 按钮图标类型（array - dict - normal+selected+selectedDouble）
@property (nonatomic, strong) NSArray *imageTypeArray;

/// 默认选中按钮（默认第一个按钮被选中，如果是多状态选择时，必须设置，否则无法进行二项选择；-1时表示取消选中状态）
@property (nonatomic, assign) NSInteger selectedIndex;

/// 重置按钮标题
- (void)setTitleButton:(NSString *)title index:(NSInteger)index;

/// 设置某个按钮升序或降序状态
- (void)setTypeButton:(BOOL)isDescending index:(NSInteger)index;





@end
