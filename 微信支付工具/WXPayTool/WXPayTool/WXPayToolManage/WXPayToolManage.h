//
//  WXPayToolManage.h
//  WXPayTool
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <CommonCrypto/CommonDigest.h>

//商户ID
#define WXDevelopmentMCHID @"1358888888"
//f653f408ab90781bfb2e23f902de8e3a
#define ShareSDKAppKey @"13ef87fc4830d"
//1b718997cbfc8
#define WXDevelopmentPARTNERID @"bacdefghjki123678hsjadbzbnsda"

#pragma mark-----最新微信登录数据--------
// *** 微信KEY
#define WXDevelopmentAppKey @"wxb5491b5tdsadfjznx~"
// *** 微信Secret
#define WXDevelopmentAppSecret @"bacdefghjki123678hsjadbzbnsdasads~"


static NSString *const KDMPayResultBackNoti = @"KDMPayResultBackNoti";

@interface WXPayToolManage : NSObject<WXApiDelegate>


/**
 微信支付失败回调 订单解锁

 @param localorderStr 订单号
 */
+ (void)wxSendPayLoseWithLocalOrderString:(NSString *)localorderStr;

/**
 微信支付

 @param backDict 微信支付字典
 */
+ (void)wxSendPayWithDict:(NSDictionary*)backDict;

///
+ (instancetype)sharedManager;

/**
 微信支付 字典

 @param backDict 微信支付字典
 @return 微信支付字典 返回MD5加密
 */
+ (NSString *)getSign:(NSDictionary*)backDict;

+ (NSString *)md5:(NSString *)str;

// MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;


@end
