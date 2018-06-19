//
//  FQDBManage.h
//  FQDBManageDemo
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FQDBManage : NSObject

@property (nonatomic, retain, readonly) FMDatabaseQueue *dbQueue;
/// 
+ (FQDBManage *)shareInstance;
/// 存储地址
+ (NSString *)dbPath;
/// 修改存储地址名称
- (BOOL)fq_changeDBWithDirectoryName:(NSString *)directoryName;


@end
