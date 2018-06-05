//
//  FQLocalNotificationTool.h
//  FQLocalAttention
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FQLocalNotificationTool : NSObject


// 设置本地通知
/**
 注册本地通知

 @param alertTime 时间
 */
+ (void)registerLocalNotification:(NSInteger)alertTime;

/**
 取消注册本地通知

 @param key key
 */
+ (void)cancelLocalNotificationWithKey:(NSString *)key;



@end
