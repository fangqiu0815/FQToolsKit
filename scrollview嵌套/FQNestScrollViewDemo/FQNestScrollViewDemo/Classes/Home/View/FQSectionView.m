//
//  FQSectionView.m
//  FQNestScrollViewDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQSectionView.h"

@implementation FQSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightTextColor];
        [self addSubview:self.segmentControl];
        [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(0);
        }];
    }
    return self;
}

#pragma mark - Init Views

- (HMSegmentedControl *)segmentControl {
    if (!_segmentControl) {
        NSArray *titles = @[@"新闻1",@"新闻2",@"新闻3"];
        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _segmentControl.selectionIndicatorHeight = 1.5f;
        _segmentControl.selectionIndicatorColor = [UIColor redColor];
        
        NSDictionary *attributesNormal = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName,nil];
        NSDictionary *attributesSelected = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName,nil];
        _segmentControl.titleTextAttributes = attributesNormal;
        _segmentControl.selectedTitleTextAttributes = attributesSelected;
    }
    return _segmentControl;
}


@end
