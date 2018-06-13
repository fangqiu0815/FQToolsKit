//
//  FQHeaderContainerCell.h
//  FQNestScrollViewDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FQHeaderContainerScrollViewDelegate <NSObject>

@optional
- (void)fq_containerOptionalScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)fq_containerOptionalScrollViewDidEndDecelerating:(UIScrollView *)scrollView;


@end

@interface FQHeaderContainerCell : UITableViewCell

@property (nonatomic, weak) id <FQHeaderContainerScrollViewDelegate> delegate;

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL objectCanScroll;
@property (nonatomic, assign) BOOL isSelectIndex;



@end
