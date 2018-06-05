//
//  FQBaseItemDataSourceCell.m
//  FQBaseItemDataSource
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQBaseItemDataSourceCell.h"

@interface FQBaseItemDataSourceCell()

@property (nonatomic, strong) NSArray *items;

@end

static NSString *cellID = @"FQBaseItemCell";

@implementation FQBaseItemDataSourceCell

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [super init]) {
        self.items = items;
    }
    return self;
}

#pragma mark --- 私有方法 ---

- (id)itemAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    if (tableView.style == UITableViewStyleGrouped) {
        FQBaseItemGroup *items = self.items[indexPath.section];
        return items.items[indexPath.row];
    } else {
        return self.items[indexPath.row];
    }
}


#pragma mark --- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.style == UITableViewStyleGrouped) {
        FQBaseItemGroup *items = self.items[section];
        return items.items.count;
    } else {
        return self.items.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.style == UITableViewStyleGrouped) {
        return self.items.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self itemAtIndexPath:indexPath tableView:tableView];
    FQBaseItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FQBaseItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    [cell setBaseItem:item];
    return cell;
}

#pragma mark --- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FQBaseItem *baseItem = [self itemAtIndexPath:indexPath tableView:tableView];
    if (baseItem.selectBlock) {
        baseItem.selectBlock(indexPath);
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.style == UITableViewStyleGrouped) {
        FQBaseItemGroup *items = self.items[section];
        return items.headTitle;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (tableView.style == UITableViewStyleGrouped) {
        FQBaseItemGroup *items = self.items[section];
        return items.footTitle;
    }
    return nil;
}



@end
