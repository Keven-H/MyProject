//
//  HCXThirdLibraryConfig.m
//  EatEquity
//
//  Created by liyunqi on 03/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXThirdLibraryConfig.h"

@implementation HCXThirdLibraryConfig

#pragma mark -友盟相关
+ (NSString *)keyUmengAnalysis
{
    NSString *key=@"5a581fa1b27b0a1d6d00012b";
#if CONFIG==5
    key=@"5a581fa1b27b0a1d6d00012b";
#endif

    return key;
}


+ (ReportPolicy)umengSendPolicy
{
    ReportPolicy reportPolicy;
#ifdef DEBUG
    reportPolicy = REALTIME;
#else
    reportPolicy = BATCH;
#endif
    return reportPolicy;
}

+(BOOL)crashReportEnabled
{
    BOOL reportenabled=NO;
#if CONFIG==5
    reportenabled = YES;
#endif
    
    return reportenabled;
    
}

#pragma mark -神策相关
+(NSString *)SA_SERVER_URL
{
    NSString * url=nil;
#if CONFIG==5
    url = @"http://47.104.89.243:8106/sa?project=default";
#endif
    return url;
    
}

+(SensorsAnalyticsDebugMode)debugModel
{
    SensorsAnalyticsDebugMode  model=SensorsAnalyticsDebugAndTrack;
#if CONFIG==5
    model = SensorsAnalyticsDebugOff;
#endif
    return model;
}


#pragma mark-融云相关
+(NSString *)rcimAppKey
{
    return RongAppKey;
}
@end
