//
//  AppDelegate.m
//  WXPayTool
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "WXPayToolManage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 微信支付 回调 回调后的所有操作返回商品详情界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popCommodityMainVCClick) name:KDMPayResultBackNoti object:nil];

    return YES;
}

- (void)popCommodityMainVCClick
{
    
}

// 支持所有iOS系统  引入友盟框架打开注释
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    NSLog(@"微信支付回调1");
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (!result) {
//        result = [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//    }
//    return result;
//}

#pragma mark ================ 程序重新回到前台 ==================
- (void)applicationWillEnterForeground:(UIApplication *)application  {
}

- (void)applicationDidEnterBackground:(UIApplication *)application  {
//    STUserDefaults.joinInPayState = 0;
}

#pragma mark ================ 程序重新激活 ===================
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //检测是否装了微信软件
    if ([WXApi isWXAppInstalled]){
#pragma mark ===============  微信支付不成功的回调  =========================
//        if (STUserDefaults.joinInPayState == 2) { // 取消
//            [self sendRechargeQuXiaoPayResult:STUserDefaults.joinInPayState];
//        } else if(STUserDefaults.joinInPayState == 3){ // 失败
//            [self sendRechargeShiBaiPayResult:STUserDefaults.joinInPayState];
//        } else{ //成功或者无
//            NSLog(@"成功或者无");
//        }
    }else{
        NSLog(@"没安装微信");
    }
}

#pragma mark ============= 发送微信付款充值结果 ===============
//发送微信付款充值结果
- (void)sendRechargeShiBaiPayResult:(int)state
{
    NSString *str = @"订单号";
    if (str.length != 0) {
        [WXPayToolManage wxSendPayLoseWithLocalOrderString:str];
    }
}

- (void)sendRechargeQuXiaoPayResult:(int)state
{
    NSString *str = @"订单号";
    if (str.length != 0) {
        [WXPayToolManage wxSendPayLoseWithLocalOrderString:str];
    }
}

@end
