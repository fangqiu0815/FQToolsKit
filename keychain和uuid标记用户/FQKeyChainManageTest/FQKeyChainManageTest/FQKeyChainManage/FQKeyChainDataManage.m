//
//  FQKeyChainDataManage.m
//  FQKeyChainManageTest
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQKeyChainDataManage.h"
static NSString * const KEY_IN_KEYCHAIN_UUID = @"唯一识别的KEY_UUID";
static NSString * const KEY_UUID = @"唯一识别的key_uuid";

@implementation FQKeyChainDataManage

+(void)fq_saveUUID:(NSString *)UUID{
    
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:UUID forKey:KEY_UUID];
    
    [FQKeyChain fq_saveKey:KEY_IN_KEYCHAIN_UUID data:usernamepasswordKVPairs];
}

+(NSString *)fq_readUUID{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[FQKeyChain fq_loadKey:KEY_IN_KEYCHAIN_UUID];
    
    return [usernamepasswordKVPair objectForKey:KEY_UUID];
    
}

+(void)fq_deleteUUID{
    
    [FQKeyChain fq_deleteKey:KEY_IN_KEYCHAIN_UUID];
    
}




@end
