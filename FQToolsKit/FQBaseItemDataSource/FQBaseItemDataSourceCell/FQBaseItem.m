//
//  FQBaseItem.m
//  FQBaseItemDataSource
//
//  Created by mac on 2018/4/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQBaseItem.h"

@implementation FQBaseItem

+ (instancetype)baseItemWithTitleStr:(NSString *)cellTitle andPicIcon:(NSString *)cellPic andDetailStr:(NSString *)cellDetail anditemType:(FQBaseItemType)itemType
{
    FQBaseItem *item = [[FQBaseItem alloc]init];
    item.cellTitle = cellTitle;
    item.cellPic = cellPic;
    item.cellDetail = cellDetail;
    item.itemType = itemType;
    return item;
}

+ (instancetype)baseItemWithTitleStr:(NSString *)cellTitle andPicIcon:(NSString *)cellPic anditemType:(FQBaseItemType)itemType
{
    return [self baseItemWithTitleStr:cellTitle andPicIcon:cellPic andDetailStr:@"" anditemType:itemType];
}


@end
@implementation FQBaseItemGroup

- (instancetype)init
{
    if (self = [super init]) {
        _items = [NSMutableArray array];
    }
    return self;
}




@end
