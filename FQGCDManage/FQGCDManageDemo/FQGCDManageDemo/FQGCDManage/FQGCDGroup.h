//
//  FQGCDGroup.h
//  FQGCDManageDemo
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FQGCDGroup : NSObject

/** 创建队列组 */
@property (nonatomic, strong, readonly) dispatch_group_t dispatchGroup;

/** 初始化 */
- (instancetype)init;

/** 进入队列 */
- (void)fq_enter;

/** 离开队列 */
- (void)fq_leave;

/** 永久等待 */
- (void)fq_wait;

/**
 判断 Dispatch Group中的操作是否执行完毕

 @param delta 执行时间
 @return 是否执行完毕
 */
- (BOOL)fq_wait:(int64_t)delta;




@end
