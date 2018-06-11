//
//  WXPayToolManage.m
//  WXPayTool
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WXPayToolManage.h"

@implementation WXPayToolManage

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXPayToolManage *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXPayToolManage alloc] init];
    });
    return instance;
}


#pragma mark - WXApiDelegate
/* 精简一下支付回调的代理 成功 失败 取消  下面注释的是完整版的支付回调方法 */
-(void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp*) resp;  // 微信终端返回给第三方的关于支付结果的结构体
//        STUserDefaults.joinInPayState = 0;
        
        switch (response.errCode) {
            case WXSuccess:
            {// 支付成功，向后台发送消息
                [self alert:@"温馨提示" msg:@"支付成功"];
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_PaySuccess" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
                // 参与支付的状态
//                STUserDefaults.joinInPayState = 1;
            }
                break;
                
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                NSLog(@"取消支付");
                [self alert:@"温馨提示" msg:@"您已取消支付"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_Error_quxiao" object:nil userInfo:@{@"status":@(2)}];
                [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
//                STUserDefaults.joinInPayState = 2;
                
            }
                break;
            default:
                
                [self alert:@"温馨提示" msg:@"支付失败"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_Error_shibai" object:nil userInfo:@{@"status":@(3)}];
                [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
//                STUserDefaults.joinInPayState = 3;
                
                break;
        }
        
        
    }
}

/*
 #pragma mark - WXApiDelegate
 -(void)onResp:(BaseResp *)resp {
 if ([resp isKindOfClass:[PayResp class]]) {
 PayResp *response = (PayResp*) resp;  // 微信终端返回给第三方的关于支付结果的结构体
 switch (response.errCode) {
 case WXSuccess:
 {// 支付成功，向后台发送消息
 [self alert:@"温馨提示" msg:@"支付成功"];
 JLLog(@"支付成功");
 [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_PaySuccess" object:nil];
 [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
 
 }
 break;
 case WXErrCodeCommon:
 { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
 [self alert:@"温馨提示" msg:@"支付失败"];
 JLLog(@"支付失败");
 [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_Error_shibai" object:nil userInfo:@{@"status":@(3)}];
 [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
 
 }
 break;
 case WXErrCodeUserCancel:
 { //用户点击取消并返回
 JLLog(@"取消支付");
 [self alert:@"温馨提示" msg:@"您已取消支付"];
 [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_Error_quxiao" object:nil userInfo:@{@"status":@(2)}];
 [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
 
 }
 break;
 case WXErrCodeSentFail:
 { //发送失败
 JLLog(@"发送失败");
 [self alert:@"温馨提示" msg:@"发送失败"];
 [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_Error_shibai" object:nil userInfo:@{@"status":@(3)}];
 [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
 
 }
 break;
 case WXErrCodeUnsupport:
 { //微信不支持
 JLLog(@"微信不支持");
 [self alert:@"温馨提示" msg:@"微信不支持或未安装微信"];
 [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_Error_shibai" object:nil userInfo:@{@"status":@(3)}];
 [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
 
 }
 break;
 case WXErrCodeAuthDeny:
 { //授权失败
 JLLog(@"授权失败");
 [self alert:@"温馨提示" msg:@"微信授权失败"];
 [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_Error_shibai" object:nil userInfo:@{@"status":@(3)}];
 [[NSNotificationCenter defaultCenter] postNotificationName:KDMPayResultBackNoti object:nil];
 
 }
 break;
 default:
 break;
 }
 
 
 }
 }
 */

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}


+(void)wxSendPayLoseWithLocalOrderString:(NSString *)localorderStr
{
    NSDictionary *dictemp = @{@"localorder":localorderStr};
    NSLog(@"dictemp---%@",dictemp);
//    [STRequest GoodsBuyOrderShiBaiRunLockData:dictemp WithDataBlock:^(id ServersData, BOOL isSuccess) {
//        JLLog(@"解锁订单---%@",ServersData);
//        if (isSuccess) {
//            if ([ServersData isKindOfClass:[NSDictionary class]]) {
//                if ([ServersData[@"c"] intValue] == 1) {
//                    STUserDefaults.isDeblockingSuccess = YES;
//                    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:ServersData[@"d"]];
//                    if ([[dictemp allKeys] containsObject:@"rebackscore"] ) {
//                        float userScore = [STUserDefaults.userScore floatValue] ;
//                        userScore += [dict[@"rebackscore"] floatValue];
//                        STUserDefaults.userScore = [NSString stringWithFormat:@"%.f",userScore];
//                        NSLog(@"解锁当前订单成功");
//                    }
//                }else{
//                    NSLog(@"解锁订单出现的问题---%@",ServersData[@"m"]);
//                }
//            }else{
//                NSLog(@"数据请求格式出错");
//            }
//        }else{
//            NSLog(@"数据请求不成功");
//        }
//    }];
    
}


+ (void)wxSendPayWithDict:(NSDictionary*)backDict{
    
    //微信支付先注册服务端下发appID
    [WXApi registerApp:[backDict objectForKey:@"wx_applyid"] enableMTA:YES];
    
    PayReq *request = [[PayReq alloc] init];
    
    request.openID = [backDict objectForKey:@"wx_applyid"];
    // *** 商户号
    request.partnerId = [backDict objectForKey:@"wx_account"];
    // *** 单号
    request.prepayId = [backDict objectForKey:@"prepayid"];
    // *** 随机字符
    request.nonceStr = [backDict objectForKey:@"noncestr"];
    // *** 时间戳
    request.timeStamp = [[backDict objectForKey:@"timestamp"] intValue];
    request.package = @"Sign=WXPay";
    // *** 签名
    request.sign = [backDict objectForKey:@"sign"];
    
    NSString *lowerCaseString = [backDict[@"sign"] lowercaseString];
    NSLog(@"lowercasestring---%@",lowerCaseString);
    [WXApi sendReq:request];
}


+(NSString *)getSign:(NSDictionary*)backDict{
    
    
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject: WXDevelopmentAppKey      forKey:@"appid"];
    [signParams setObject: [backDict objectForKey:@"nonce_str"]    forKey:@"noncestr"];
    [signParams setObject: @"Sign=WXPay"      forKey:@"package"];
    [signParams setObject: WXDevelopmentMCHID      forKey:@"partnerid"];
    [signParams setObject: [backDict objectForKey:@"time"]   forKey:@"timestamp"];
    [signParams setObject: [backDict objectForKey:@"prepay_id"] forKey:@"prepayid"];
    //生成签名
    NSString *sign  = [self createMd5Sign:signParams];
    
    return sign;
}
//创建package签名
+(NSString*) createMd5Sign:(NSMutableDictionary*)dict{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            ){
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", WXDevelopmentPARTNERID];
    //得到MD5 sign签名
    NSString *md5Sign = [self md5:contentString];
    
    return md5Sign;
}



#pragma mark - MD5加密
+ (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


@end
