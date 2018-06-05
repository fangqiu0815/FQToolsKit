//
//  FQKeyChain.h
//  FQKeyChainManageTest
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FQKeyChain : NSObject

+ (NSMutableDictionary *)fq_getKeychainQuery:(NSString *)service;

+ (void)fq_saveKey:(NSString *)service data:(id)data;

+ (id)fq_loadKey:(NSString *)service;

+ (void)fq_deleteKey:(NSString *)service;


@end
