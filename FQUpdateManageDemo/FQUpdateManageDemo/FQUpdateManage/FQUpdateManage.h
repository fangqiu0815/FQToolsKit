//
//  FQUpdateManage.h
//  FQUpdateManageDemo
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


//  app的唯一识别码 跳转appStoreq去下载
#define kAPPID  @"888237539"
//  取消更新版本次数 超过版本则不更新
#define kMAXUPDATECOUNT 4
//  弹窗标题
#define kUPDATETITLEMESSEGE  @"有新版本了"
//  弹窗确定按钮
#define kUPDATECONFIRM  @"去更新"
//  弹窗取消按钮
#define kUPDATECANCEL  @"暂不更新"

@interface FQUpdateManage : NSObject

/**
 检查更新

 @param isForce 是否强制更新
 */
+ (void)checkVersionFromServiceToUpdateWithForce:(BOOL)isForce;


@end
