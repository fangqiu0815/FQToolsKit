//
//  YJSPayManager.h
//  YJSPayManagerDemo
//
//  Created by apple on 17/2/24.
//  Copyright © 2017年 YJS. All rights reserved.
//

#import <WXApi.h>
#import <LLPaySdk.h>
#import <WechatAuthSDK.h>
#import <UPPaymentControl.h>
#import <AlipaySDK/AlipaySDK.h>
#import <Foundation/Foundation.h>

/**
 resultCode:
  0    -    支付成功
 -1   -    支付失败
 -2   -    支付取消
 -3   -    未安装App(适用于微信)
 -4   -    设备或系统不支持，或者用户未绑卡(适用于ApplePay)
 -99  -    未知错误
 */
typedef void (^YJSPayManagerResultBlock) (NSInteger resultCode, NSString * resultMsg);

/**ApplePay设备和系统支持状态*/
typedef NS_ENUM(NSInteger, YJSApplePaySupportStatus) {
    kYJSApplePaySupport,                    //完全支持
    kYJSApplePayDeviceOrVersionNotSupport,  //设备或系统不支持
    kYJSApplePaySupportNotBindCard,         //设备和系统支持，用户未绑卡
    kYJSApplePayUnknown                     //未知状态
};

@interface YJSPayManager : NSObject<LLPaySdkDelegate, WXApiDelegate>

+ (YJSPayManager *)sharedManager;

/***********************************************/
/*****************Apple Pay*********************/
/***********************************************/

/**Apple Pay 支付结果回调*/
@property (strong, nonatomic) YJSPayManagerResultBlock applePayResultBlock;

/**是否支持Apple Pay 判断返回的枚举类型*/
+ (YJSApplePaySupportStatus)isCanApplePay;

/**跳转wallet系统app进行绑卡*/
+ (void)showWalletToBindCard;

/**发起Apple Pay支付*/
- (void)applePayWithTraderInfo:(NSDictionary *)traderInfo
                viewController:(UIViewController *)viewController
                     respBlock:(YJSPayManagerResultBlock)block;

/***********************************************/
/*******************微信支付*********************/
/***********************************************/

/**微信支付结果回调*/
@property (strong, nonatomic)YJSPayManagerResultBlock wechatResultBlock;

/**检查是否安装微信*/
+ (BOOL)isWXAppInstalled;

/**注册微信appId*/
+ (BOOL)wechatRegisterAppWithAppId:(NSString *)appId
                       description:(NSString *)description;

/**处理微信通过URL启动App时传递回来的数据*/
+ (BOOL)wechatHandleOpenURL:(NSURL *)url;

/**发起微信支付*/
- (void)wechatPayWithAppId:(NSString *)appId
                 partnerId:(NSString *)partnerId
                  prepayId:(NSString *)prepayId
                   package:(NSString *)package
                  nonceStr:(NSString *)nonceStr
                 timeStamp:(NSString *)timeStamp
                      sign:(NSString *)sign
                 respBlock:(YJSPayManagerResultBlock)block;

/***********************************************/
/*******************支付宝支付********************/
/***********************************************/

/**支付宝支付结果回调*/
@property (strong, nonatomic)YJSPayManagerResultBlock alipayResultBlock;

/**处理支付宝通过URL启动App时传递回来的数据*/
+ (BOOL)alipayHandleOpenURL:(NSURL *)url;

/**发起支付宝支付*/
- (void)aliPayOrder:(NSString *)order
             scheme:(NSString *)scheme
          respBlock:(YJSPayManagerResultBlock)block;

/***********************************************/
/********************银联支付*********************/
/***********************************************/

/**银联支付结果回调*/
@property (nonatomic, strong)YJSPayManagerResultBlock unionResultBlock;

/**处理银联通过URL启动App时传递回来的数据*/
+ (BOOL)unionHandleOpenURL:(NSURL*)url;

/**发起银联支付*/
- (void)unionPayWithSerialNo:(NSString *)serialNo
              viewController:(id)viewController
                   respBlock:(YJSPayManagerResultBlock)block;


@end
