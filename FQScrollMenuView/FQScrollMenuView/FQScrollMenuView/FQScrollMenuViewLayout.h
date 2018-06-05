//
//  FQScrollMenuViewLayout.h
//  FQScrollMenuView
//
//  Created by mac on 2018/4/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^pageCaculateBlock)(NSInteger currentPageCount);

@interface FQScrollMenuViewLayout : UICollectionViewLayout

@property (nonatomic) CGFloat minimumLineSpacing; //行间距

@property (nonatomic) CGFloat minimumInteritemSpacing; //item间距

@property (nonatomic) CGSize itemSize; //item大小

@property (nonatomic) UIEdgeInsets sectionInset;

/** 页码回调 */
@property (nonatomic, copy) pageCaculateBlock caculatePage;

- (instancetype)init;

@end
