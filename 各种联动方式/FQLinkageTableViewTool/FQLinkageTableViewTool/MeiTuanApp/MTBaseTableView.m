//
//  MTBaseTableView.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MTBaseTableView.h"

@implementation MTBaseTableView

//允许接受多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return self.isRg;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass(touch.view.superview.class) isEqualToString:@"UITableViewCell"]) {
        //如果是左侧的范围，那么手势不生效
        return NO;
    }
    
    return YES;
}

@end
