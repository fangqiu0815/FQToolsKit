//
//  FQBaseItemDataSourceCell.h
//  FQBaseItemDataSource
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FQBaseItemCell.h"

@interface FQBaseItemDataSourceCell : NSObject<UITableViewDelegate, UITableViewDataSource>

//初始化
- (instancetype)initWithItems:(NSArray *)items;

@end


