//
//  FQBaseItem.h
//  FQBaseItemDataSource
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FQBaseItemType) {
    FQBaseItemTypeArrow,    //右侧带箭头的
    FQBaseItemTypeDetail,   //右侧箭头加文字的
    FQBaseItemTypeSwitch,   //右侧switch不带箭头的
    FQBaseItemTypeBadge     //右侧带箭头且有提示数字
};

//Switch回调
typedef void(^SwitchClickBlock)(BOOL on);
//Cell回调
typedef void(^DidSelectBlock)(NSIndexPath *indexPath);

@interface FQBaseItem : NSObject

/** item样式 */
@property (nonatomic, assign) FQBaseItemType itemType;
/** cell图片 */
@property (nonatomic, copy) NSString *cellPic;
/** cell标题 */
@property (nonatomic, copy) NSString *cellTitle;
/** celldetail文字 */
@property (nonatomic, copy) NSString *cellDetail;
/** switch点击的block */
@property (nonatomic, copy) SwitchClickBlock switchClickBlock;
/** 点击cell的block */
@property (nonatomic, copy) DidSelectBlock selectBlock;
/** 小红点 (带红点数字或者红点)*/
@property (nonatomic, copy) NSString *redBadge;
//Switch状态 默认NO
@property (nonatomic, assign, getter=isSwitchOn) BOOL isSwitchOn;

/**
 带detail信息的初始化方法

 @param cellTitle   标题
 @param cellPic     图片
 @param cellDetail  描述
 @param itemType    类型
 @return 初始化
 */
+ (instancetype)baseItemWithTitleStr:(NSString *)cellTitle andPicIcon:(NSString *)cellPic andDetailStr:(NSString *)cellDetail anditemType:(FQBaseItemType)itemType;

/**
 不带detail信息的初始化方法

 @param cellTitle   标题
 @param cellPic     图片
 @param itemType    类型
 @return 初始化
 */
+ (instancetype)baseItemWithTitleStr:(NSString *)cellTitle andPicIcon:(NSString *)cellPic anditemType:(FQBaseItemType)itemType;


@end

@interface FQBaseItemGroup : NSObject

//Cell模型集合
@property (nonatomic, strong) NSMutableArray <FQBaseItem *> *items;

//组头标题 TableView为Group才有效
@property (nonatomic, copy) NSString *headTitle;
//组尾标题 TableView为Group才有效
@property (nonatomic, copy) NSString *footTitle;


@end

