//
//  YJSPayManager.m
//  YJSPayManagerDemo
//
//  Created by apple on 17/2/24.
//  Copyright © 2017年 YJS. All rights reserved.
//

#import "YJSPayManager.h"

@implementation YJSPayManager

+ (YJSPayManager *)sharedManager{
    static YJSPayManager * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YJSPayManager alloc] init];
    });
    return manager;
}

/*****************Apple Pay*********************/
+ (YJSApplePaySupportStatus)isCanApplePay{
    LLAPPaySupportStatus status = [LLAPPaySDK canDeviceSupportApplePayPayments];
    
    if(status==kLLAPPayDeviceSupport){
        return kYJSApplePaySupport;
    }
    else if(status==kLLAPPayDeviceNotSupport || status==kLLAPPayDeviceVersionTooLow){
        return kYJSApplePayDeviceOrVersionNotSupport;
    }
    else if(status==kLLAPPayDeviceNotBindChinaUnionPayCard){
        return kYJSApplePaySupportNotBindCard;
    }
    
    return kYJSApplePayUnknown;
}

+ (void)showWalletToBindCard{
    [LLAPPaySDK showWalletToBindCard];
}

- (void)applePayWithTraderInfo:(NSDictionary *)traderInfo   viewController:(UIViewController *)viewController respBlock:(YJSPayManagerResultBlock)block{
    self.applePayResultBlock = block;
    
    if([YJSPayManager isCanApplePay] == kYJSApplePaySupport){
        LLAPPaySDK *llAPPaySDK = [LLAPPaySDK sharedSdk];
        llAPPaySDK.sdkDelegate = self;
        
        [llAPPaySDK payWithTraderInfo:traderInfo inViewController:viewController];
    }
    else{
        if(self.applePayResultBlock){
            self.applePayResultBlock(-4, @"设备或系统不支持，或者用户未绑卡");
        }
    }
}

#pragma mark -- LLPaySDKDelegate
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic{
    NSString *msg;
    
    switch (resultCode){
        case kLLPayResultSuccess:{
            msg = @"支付成功";
            
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"]){
                if(self.applePayResultBlock){
                    self.applePayResultBlock(0, @"支付成功");
                }
            }
            else{
                if(self.applePayResultBlock){
                    self.applePayResultBlock(-1, @"支付失败");
                }
            }
        }
            break;
        case kLLPayResultFail:{
            if(self.applePayResultBlock){
                self.applePayResultBlock(-1, @"支付失败");
            }
        }
            break;
        case kLLPayResultCancel:{
            if(self.applePayResultBlock){
                self.applePayResultBlock(-2, @"支付取消");
            }
        }
            break;
        case kLLPayResultInitError:{
            if(self.applePayResultBlock){
                self.applePayResultBlock(-1, @"支付失败");
            }
        }
            break;
        case kLLPayResultInitParamError:{
            if(self.applePayResultBlock){
                self.applePayResultBlock(-1, @"支付失败");
            }
        }
            break;
        default:{
            if(self.applePayResultBlock){
                self.applePayResultBlock(-99, @"未知错误");
            }
        }
            break;
    }
}


/*******************微信支付*********************/
+ (BOOL)isWXAppInstalled{
    return [WXApi isWXAppInstalled];
}

+ (BOOL)wechatRegisterAppWithAppId:(NSString *)appId description:(NSString *)description{
    return [WXApi registerApp:appId withDescription:description];
}

+ (BOOL)wechatHandleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:[YJSPayManager sharedManager]];
}

- (void)wechatPayWithAppId:(NSString *)appId partnerId:(NSString *)partnerId prepayId:(NSString *)prepayId package:(NSString *)package nonceStr:(NSString *)nonceStr timeStamp:(NSString *)timeStamp sign:(NSString *)sign respBlock:(YJSPayManagerResultBlock)block{
    self.wechatResultBlock = block;
    
    if([WXApi isWXAppInstalled]){
        PayReq *req = [[PayReq alloc] init];
        req.openID = appId;
        req.partnerId = partnerId;
        req.prepayId = prepayId;
        req.package = package;
        req.nonceStr = nonceStr;
        req.timeStamp = (UInt32)timeStamp.integerValue;
        req.sign = sign;
        [WXApi sendReq:req];
    }
    else{
        if(self.wechatResultBlock){
            self.wechatResultBlock(-3, @"未安装微信");
        }
    }
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode){
            case 0:{
                if(self.wechatResultBlock){
                    self.wechatResultBlock(0, @"支付成功");
                }
                
                NSLog(@"支付成功");
                break;
            }
            case -1:{
                if(self.wechatResultBlock){
                    self.wechatResultBlock(-1, @"支付失败");
                }
                
                NSLog(@"支付失败");
                break;
            }
            case -2:{
                if(self.wechatResultBlock){
                    self.wechatResultBlock(-2, @"支付取消");
                }
                
                NSLog(@"支付取消");
                break;
            }
                
            default:{
                if(self.wechatResultBlock){
                    self.wechatResultBlock(-99, @"未知错误");
                }
            }
                break;
        }
    }
}

/*******************支付宝支付********************/
+ (BOOL)alipayHandleOpenURL:(NSURL *)url{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
        YJSPayManager *manager = [YJSPayManager sharedManager];
        NSNumber *code = resultDic[@"resultStatus"];
        
        if(code.integerValue==9000){
            if(manager.alipayResultBlock){
                manager.alipayResultBlock(0, @"支付成功");
            }
        }
        else if(code.integerValue==4000 || code.integerValue==6002){
            if(manager.alipayResultBlock){
                manager.alipayResultBlock(-1, @"支付失败");
            }
        }
        else if(code.integerValue==6001){
            if(manager.alipayResultBlock){
                manager.alipayResultBlock(-2, @"支付取消");
            }
        }
        else{
            if(manager.alipayResultBlock){
                manager.alipayResultBlock(-99, @"未知错误");
            }
        }
        
    }];
    
    return YES;
}

- (void)aliPayOrder:(NSString *)order scheme:(NSString *)scheme respBlock:(YJSPayManagerResultBlock)block{
    self.alipayResultBlock = block;
    
    __weak __typeof(&*self)ws = self;
    [[AlipaySDK defaultService] payOrder:order fromScheme:scheme callback:^(NSDictionary *resultDic) {
        
        NSNumber *code = resultDic[@"resultStatus"];
        
        if(code.integerValue==9000){
            if(ws.alipayResultBlock){
                ws.alipayResultBlock(0, @"支付成功");
            }
        }
        else if(code.integerValue==4000 || code.integerValue==6002){
            if(ws.alipayResultBlock){
                ws.alipayResultBlock(-1, @"支付失败");
            }
        }
        else if(code.integerValue==6001){
            if(ws.alipayResultBlock){
                ws.alipayResultBlock(-2, @"支付取消");
            }
        }
        else{
            if(ws.alipayResultBlock){
                ws.alipayResultBlock(-99, @"未知错误");
            }
        }
        
    }];
}

/********************银联支付*********************/
+ (BOOL)unionHandleOpenURL:(NSURL*)url{
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        YJSPayManager *payManager = [YJSPayManager sharedManager];
        
        if([code isEqualToString:@"success"]){
            if(payManager.unionResultBlock){
                payManager.unionResultBlock(0, @"支付成功");
            }
            
        }
        else if([code isEqualToString:@"fail"]){
            if(payManager.unionResultBlock){
                payManager.unionResultBlock(-1, @"支付失败");
            }
        }
        else if([code isEqualToString:@"cancel"]){
            if(payManager.unionResultBlock){
                payManager.unionResultBlock(-2, @"支付取消");
            }
        }
        else{
            if(payManager.unionResultBlock){
                payManager.unionResultBlock(-99, @"未知错误");
            }
        }
        
    }];
    
    return YES;
}
- (void)unionPayWithSerialNo:(NSString *)serialNo viewController:(id)viewController respBlock:(YJSPayManagerResultBlock)block{
    self.unionResultBlock = block;
    
    [[UPPaymentControl defaultControl] startPay:serialNo fromScheme:@"UnionPay" mode:@"00" viewController:viewController];
}

@end
