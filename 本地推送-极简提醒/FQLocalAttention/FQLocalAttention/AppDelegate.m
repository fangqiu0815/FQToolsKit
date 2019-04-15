//
//  AppDelegate.m
//  FQLocalAttention
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self pushSetting];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)pushSetting
{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              }];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        }];
    } else {
        
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
            [[UIApplication sharedApplication] registerUserNotificationSettings:
             [UIUserNotificationSettings settingsForTypes:
              UIUserNotificationTypeAlert|
              UIUserNotificationTypeBadge|
              UIUserNotificationTypeSound categories:nil]];
        }
        
    }
    
}

///*! 本地通知回调 */
//- (void)application:(UIApplication *)application
//didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    NSLog(@"noti:%@",notification);
//
//    // 这里真实需要处理交互的地方
//    // 获取通知所带的数据
//    NSString *notMess = [notification.userInfo objectForKey:@"key"];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"去看看效果...(用于测试阶段)"message:notMess delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确定",nil];
//    [alert show];
//    // 图标上的数字减1
//    //    application.applicationIconBadgeNumber -= 1;
//    //    NSLog(@"didReceiveLocalNotification");
//
//    // 更新显示的badge个数
//    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
//    badge--;
//    badge = badge >= 0 ? badge : 0;
//    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
//
//    // 在不需要再推送时，可以取消推送
//}
//
///*! 代理方法 */
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"buttonIndex is : %li",(long)buttonIndex);
//
//    switch (buttonIndex)
//    {
//            // 取消
//        case 0:
//            return;
//            break;
//            // 确定
//        case 1:
//            [self moveToVC];
//            break;
//
//        default:
//            break;
//    }
//
//}
//
//// 实现跳转
//- (void)moveToVC
//{
//    /// 可以跳转本地界面 也可以 跳转外部链接
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
//}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification NS_AVAILABLE_IOS(4_0) {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:notification.alertTitle
                          message:notification.alertBody
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil,
                          nil];
    [alert show];
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0){
    
    NSLog(@"应用在前台运行是接受到通知，会直接调用该方法");
    
    completionHandler(UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionAlert);
    
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED{
    
    NSLog(@"后台或者未启动时接受到通知，点击通知会调用该方法");
    
}

- (void)startLocalPush {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *fireDate = [formatter dateFromString:@"2019-04-04 17:47"];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    localNotification.fireDate = fireDate;
    localNotification.repeatInterval = kCFCalendarUnitDay;
    localNotification.alertBody = @"移动考勤提醒您：下班啦，记得考勤打卡哦！事务千万条，打卡第一条，打卡不及时，发薪两行泪！";
    localNotification.alertTitle = @"考勤提醒";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
