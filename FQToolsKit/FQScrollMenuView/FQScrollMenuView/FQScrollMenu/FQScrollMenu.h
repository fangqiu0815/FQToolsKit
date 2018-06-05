//
//  FQScrollMenu.h
//  FQScrollMenuView
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//自动处理屏幕适配
#define kScale(P)     ((P) * ([UIScreen mainScreen].bounds.size.width / 375.f))

/** 数据模型协议 */
@protocol FQObjectProtocol <NSObject>
/**
 *  显示文本
 */
@property (nonatomic, copy) NSString *itemDescription;
/**
 *  显示图片，可以为NSURL,NSString,UIImage三种格式
 */
@property (nonatomic, strong) id itemImage;
/**
 *  占位图片
 */
@property (nonatomic, strong) UIImage *itemPlaceholder;

@end

/** 菜单单元格 */
@interface FQScrollMenuItem : UICollectionViewCell
/**
 *  图片的尺寸，默认是(40,40)
 */
@property (nonatomic, assign) CGSize iconSize  UI_APPEARANCE_SELECTOR ;
/**
 *  图片与文本的距离，默认是 10
 */
@property (nonatomic, assign) CGFloat space UI_APPEARANCE_SELECTOR;
/**
 *  图片的圆角率，默认是20
 */
@property (nonatomic, assign) CGFloat iconCornerRadius UI_APPEARANCE_SELECTOR;
/**
 *  文本的字体颜色，默认是darkTextColor
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR ;
/**
 *  文本的字体大小，默认是14号系统字体
 */
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

@end


@class FQScrollMenu;

@protocol FQScrollMenuDataSource <NSObject>

@required
/**
 分组数量

 @param scrollMenu 滚动菜单
 @return NSInteger
 */
- (NSInteger)numberOfSectionsInScrollMenu:(FQScrollMenu *)scrollMenu;

/**
 每组菜单数量

 @param scrollMenu 滚动菜单
 @param section 分组
 @return NSInteger
 */
- (NSInteger)scrollMenu:(FQScrollMenu *)scrollMenu numberOfRowsInSection:(NSInteger)section;

/**
 数据源方法

 @param scrollMenu 滚动菜单
 @param indexPath 索引
 @return id<FQObjectProtocol>
 */
- (id<FQObjectProtocol>)scrollMenuCell:(FQScrollMenu *)scrollMenu cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@protocol FQScrollMenuDelegate <NSObject>
@required
/**
 单元格尺寸，默认是(40,70)
 
 @param menu 菜单
 @return CGSize
 */
- (CGSize)itemSizeOfScrollMenu:(FQScrollMenu *)menu;
/**
 分区的页眉，默认不显示
 
 @param menu 菜单
 @param section 分区
 @return UIView
 */
- (UIView *)scrollMenu:(FQScrollMenu *)menu headerInSection:(NSUInteger)section;
/**
 页眉的高度，默认20
 
 @param menu 菜单
 @return CGFloat
 */
- (CGFloat)heightOfHeaderInScrollMenu:(FQScrollMenu *)menu;
/**
 分页器的高度，默认15
 
 @param menu 菜单
 @return CGFloat
 */
- (CGFloat)heightOfPageControlInScrollMenu:(FQScrollMenu *)menu;
/**
 当单元格数量改变时，是否自动更新Frame以适应。默认是NO
 
 @return BOOL
 */
- (BOOL)shouldAutomaticUpdateFrameInScrollMenu:(FQScrollMenu *)menu;
/**
 单元格点击回调
 
 @param menu 菜单
 @param indexPath 索引
 */
- (void)scrollMenu:(FQScrollMenu *)menu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;



@end

@interface FQScrollMenu : UIView

/**
 *  分页控制器当前分页的颜色，默认是 darkTextColor;
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/**
 *  分页控制器分页的颜色，默认是 groupTableViewBackgroundColor;
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

/**
 *  图文展示类型 1.图文展示 2.仅有图展示
 */
@property (nonatomic, assign) NSInteger haveImageOrTitleObject;

/**
 初始化方法
 
 @param frame CGRect
 @param aDelegate id
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame  scrollMenuDelegate:(id)aDelegate;
/**
 刷新
 */
- (void)fq_reloadData;

#pragma mark - 禁用的初始化方法
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;



@end


NS_ASSUME_NONNULL_END
