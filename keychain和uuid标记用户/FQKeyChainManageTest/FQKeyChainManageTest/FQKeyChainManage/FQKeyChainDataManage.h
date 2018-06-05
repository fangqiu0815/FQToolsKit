//
//  FQKeyChainDataManage.h
//  FQKeyChainManageTest
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FQKeyChain.h"

@interface FQKeyChainDataManage : NSObject

/**
 *   存储 UUID
 *
 *     */
+(void)fq_saveUUID:(NSString *)UUID;

/**
 *  读取UUID *
 *
 */
+(NSString *)fq_readUUID;

/**
 *    删除数据
 */
+(void)fq_deleteUUID;


@end
