//
//  HCXThirdLibraryManager.m
//  EatEquity
//
//  Created by liyunqi on 03/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXThirdLibraryManager.h"
#import "HCXThirdLibraryConfig.h"
@interface HCXThirdLibraryManager()
{
    
}
@end
@implementation HCXThirdLibraryManager
+(HCXThirdLibraryManager *)share
{
    static dispatch_once_t onceToken;
    static HCXThirdLibraryManager *thirdLibraryManager=nil;
    dispatch_once(&onceToken, ^{
        thirdLibraryManager=[[HCXThirdLibraryManager alloc]init];
    });
    return thirdLibraryManager;
}
-(void)appStartWithOptions:(NSDictionary*)launchOptions
{
    [HCXDateManager resetUserAgent];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                            settingsForTypes:(UIUserNotificationTypeBadge |
                                                              UIUserNotificationTypeSound |
                                                              UIUserNotificationTypeAlert)
                                            categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    
    
    NSString * appVersion= [SYClientInfo appVersion];
    //友盟
    [MobClick setCrashReportEnabled:[HCXThirdLibraryConfig crashReportEnabled]];
    
    [UMAnalyticsConfig sharedInstance].appKey=[HCXThirdLibraryConfig  keyUmengAnalysis];
     [UMAnalyticsConfig sharedInstance].channelId=@"999";
    [UMAnalyticsConfig sharedInstance].ePolicy=[HCXThirdLibraryConfig umengSendPolicy];
    [MobClick startWithConfigure:[UMAnalyticsConfig sharedInstance]];
 
    [MobClick setAppVersion:appVersion];
    [MobClick setLogEnabled:NO];
    
    //神策
    [SensorsAnalyticsSDK sharedInstanceWithServerURL:[HCXThirdLibraryConfig SA_SERVER_URL]
                                     andConfigureURL:nil
                                        andDebugMode:[HCXThirdLibraryConfig debugModel]];
    [[SensorsAnalyticsSDK sharedInstance] identify:[SYClientInfo clientID]];
    [[SensorsAnalyticsSDK sharedInstance] enableAutoTrack:SensorsAnalyticsEventTypeAppStart |
     SensorsAnalyticsEventTypeAppEnd |
     SensorsAnalyticsEventTypeAppViewScreen ];
    
    //融云
//    [[RCIM sharedRCIM] initWithAppKey:[HCXThirdLibraryConfig rcimAppKey]];
//    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
}
-(void)login
{
//    KS1z7tWBO

    if (SYStringisEmpty([[HCXDateManager shareDataManager]account].user.rongToken)) {
        NSLog(@"融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误融云错误 ***************************************无token");
        return;
    }
//    RCUserInfo *_currentUserInfo =
//    [[RCUserInfo alloc] initWithUserId:[[HCXDateManager shareDataManager]account].user.ID name:[[HCXDateManager shareDataManager]account].user.nickName portrait:[[HCXDateManager shareDataManager]account].user.image.url];
//    [RCIM sharedRCIM].currentUserInfo = _currentUserInfo;
//    [[RCIM sharedRCIM] setUserInfoDataSource:self];
//    [RCIM sharedRCIM].connectionStatusDelegate=self;
//    [RCIM sharedRCIM].enableMessageAttachUserInfo=YES;
//     [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
//
//    [[RCIM sharedRCIM] connectWithToken:[[HCXDateManager shareDataManager]account].user.rongToken    success:^(NSString *userId) {
//        NSLog(@"融云--登陆成功。当前登录的用户ID：%@", userId);
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"融云---登陆的错误码为:%d", status);
//    } tokenIncorrect:^{
//        NSLog(@"融云--token错误");
//    }];

}
//- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status
// {
//     NSLog(@"网络状态变化%zi",status);
// }
//-(void)loginOut
//{
//    [[RCIM sharedRCIM] logout];
//}
-(void)registerDeviceToken:(NSData *)deviceToken
{
    NSString *pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    [[HCXSubService share]loadDeviceToken:pushToken className:[SYResponse class] responseblock:nil];
    [[HCXDateManager shareDataManager]saveDeviceToken:pushToken];
//    [[RCIMClient sharedRCIMClient] setDeviceToken:pushToken];
}

//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
//{
//    RCUserInfo *user = [[RCUserInfo alloc]init];
//    user.userId =[[HCXDateManager shareDataManager]account].user.ID;
//    user.name = [[HCXDateManager shareDataManager]account].user.nickName;
//    user.portraitUri = [[HCXDateManager shareDataManager]account].user.image.url;
//    return completion(user);
//}

@end
