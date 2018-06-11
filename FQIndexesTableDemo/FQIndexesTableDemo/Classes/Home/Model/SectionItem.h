//
//  SectionItem.h
//  FQIndexesTableDemo
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CellItem;

@interface SectionItem : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSArray *items;


@end

@interface CellItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;


@end
