//
//  AppDelegate.m
//  MyProject
//
//  Created by Admin on 2018/1/2.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[HCXThirdLibraryManager share]appStartWithOptions:launchOptions];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    [HCXLoginManager showMainController];

    [self.window makeKeyAndVisible];
    return YES;

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[XShareLockManager shareLockManager] unlock];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 微信delegate
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    return [self processApplication:application openURL:url];
}

- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    return [self processApplication:application openURL:url];
}

- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [self processApplication:app openURL:url];
}

- (BOOL)processApplication:(UIApplication*)application
                   openURL:(NSURL*)url
{
    BOOL bSuccess = YES;
    if ([[XWeChatEngine shareWeChatEngine] canHandleOpenURL:url])
        bSuccess = [[XWeChatEngine shareWeChatEngine] handleOpenURL:url];
    else if ([[XWeiBoEngine shareWeiBoEngine] canHandleOpenURL:url])
        bSuccess = [[XWeiBoEngine shareWeiBoEngine] handleOpenURL:url];


    return bSuccess;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler
{
    if([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb])
    {
        //        NSURL *webUrl = userActivity.webpageURL;
        //open other
    }
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

//    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
//    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
//    if (pushServiceData) {
//        NSLog(@"该远程推送包含来自融云的推送服务");
//        for (id key in [pushServiceData allKeys]) {
//            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
//        }
//    } else {
//        NSLog(@"该远程推送不包含来自融云的推送服务");
//    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

//    [[RCIMClient sharedRCIMClient] recordLocalNotificationEvent:notification];
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    [[HCXThirdLibraryManager share ]registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"推送注册失败---%@",error);
}

+(AppDelegate *)shareDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
@end
