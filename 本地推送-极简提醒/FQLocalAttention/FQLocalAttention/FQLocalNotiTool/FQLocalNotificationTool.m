//
//  FQLocalNotificationTool.m
//  FQLocalAttention
//
//  Created by mac on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQLocalNotificationTool.h"

@implementation FQLocalNotificationTool

// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  @"本地通知请求体";
    notification.alertAction = @"本地通知事件";
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    // 设置应用程序右上角的提醒个数
    notification.applicationIconBadgeNumber ++;
    //    notification.applicationIconBadgeNumber = 1;
    
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"本地通知内容" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    }
    else
    {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    }
    
    // 将通知添加到系统中
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key
{
    /*!
     
     有一点需要注意，如果我们的应用程序给系统发送的本地通知是周期性的，那么即使把程序删了重装，之前的本地通知在重装时依然存在（没有从系统中移除）。例如，我们在viewDidLoad方法中启动添加本地通知的方法，多跑几次，然后把程序在模拟器中删除，再重新跑，并用下列方法输出所有的本地通知：
     */
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications)
    {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo)
        {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil)
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}



@end
