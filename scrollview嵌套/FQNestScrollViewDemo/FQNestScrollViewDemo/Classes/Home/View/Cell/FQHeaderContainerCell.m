//
//  FQHeaderContainerCell.m
//  FQNestScrollViewDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQHeaderContainerCell.h"
#import "FQOneViewController.h"
#import "FQTwoViewController.h"
#import "FQThreeViewController.h"

#define kHeight [UIScreen mainScreen].bounds.size.height - 64.0 - 60

@interface FQHeaderContainerCell()
<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) FQOneViewController *oneVC;
@property (nonatomic, strong) FQTwoViewController *twoVC;
@property (nonatomic, strong) FQThreeViewController *threeVC;

@end

@implementation FQHeaderContainerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.scrollView];
        
        [self configScrollView];
    }
    return self;
}

- (void)configScrollView {
    self.oneVC = [[FQOneViewController alloc] init];
    self.twoVC = [[FQTwoViewController alloc] init];
    self.threeVC = [[FQThreeViewController alloc] init];
    
    [self.scrollView addSubview:self.oneVC.view];
    [self.scrollView addSubview:self.twoVC.view];
    [self.scrollView addSubview:self.threeVC.view];
    
    self.oneVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeight);
    self.twoVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, kHeight);
    self.threeVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, [UIScreen mainScreen].bounds.size.width, kHeight);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 为了横向滑动的时候，外层的tableView不动
    if (!self.isSelectIndex) {
        if (scrollView == self.scrollView) {
            if (self.delegate &&
                [self.delegate respondsToSelector:@selector(fq_containerOptionalScrollViewDidScroll:)]) {
                [self.delegate fq_containerOptionalScrollViewDidScroll:scrollView];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isSelectIndex = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(fq_containerOptionalScrollViewDidEndDecelerating:)]) {
            [self.delegate fq_containerOptionalScrollViewDidEndDecelerating:scrollView];
        }
    }
}

#pragma mark - Init Views

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height);
    }
    return _scrollView;
}

- (void)setObjectCanScroll:(BOOL)objectCanScroll {
    _objectCanScroll = objectCanScroll;
    
    self.oneVC.vcCanScroll = objectCanScroll;
    self.twoVC.vcCanScroll = objectCanScroll;
    self.threeVC.vcCanScroll = objectCanScroll;
    
    if (!objectCanScroll) {
        [self.oneVC.tableView setContentOffset:CGPointZero animated:NO];
        [self.twoVC.tableView setContentOffset:CGPointZero animated:NO];
        [self.threeVC.tableView setContentOffset:CGPointZero animated:NO];
    }
}

@end
