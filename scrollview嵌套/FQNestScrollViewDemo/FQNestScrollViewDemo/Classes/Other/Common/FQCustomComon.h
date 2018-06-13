//
//  FQCustomComon.h
//  FQNestScrollViewDemo
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef FQCustomComon_h
#define FQCustomComon_h

// 3rd


// category
#import "UIView+Frame.h"
#import "UIImage+Extension.h"


//lib
#import "HMSegmentedControl.h"


// base


//信息提示
#define TEXT_NETWORK_ERROR @"网络异常，请检查网络连接"
#define TEXT_SERVER_NOT_RESPOND @"服务器或网络异常,请稍后重试"

//获取程序当前版本信息
#define kCurrentVersions  [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]
//获取沙盒路径
#define kSandboxPath      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

/* 屏幕适配 */
#define iphone4 ScreenH == 480
#define iphoneSE ScreenH == 568
#define iphone7 ScreenH == 667
#define iphone7p ScreenH == 736

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define KEYWINDOW  [UIApplication sharedApplication].keyWindow

#define CachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject
#define DocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject

#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

// iPhone X
#define KDM_iPhoneX (ScreenW == 375.f && ScreenH == 812.f ? YES : NO)

#define KD_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define KDMScreenStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KDMScreenNavigationBarHeight 44.f
#define KDMScreenTopStatusNaviHeight KDMScreenStatusBarHeight + KDMScreenNavigationBarHeight
#define KDMScreenTabBarHeight  KDM_iPhoneX?83:49
/**
 // MARK: 安全区底部高度
 */
#define KDMScreenTabBarSafeBottomMargin (KD_iPhoneX ? 34.f : 0.f)

#ifdef DEBUG //开发状态
#define JLLog(FORMAT, ...) fprintf(stderr,"%s:第 %d 行\n%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define debugMethod() NSLog(@"%s", __func__)

#else  //发布状态
#define JLLog(...)
#define debugMethod()

#endif




#endif /* FQCustomComon_h */
