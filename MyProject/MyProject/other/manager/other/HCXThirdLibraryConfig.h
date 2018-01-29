//
//  HCXThirdLibraryConfig.h
//  EatEquity
//
//  Created by liyunqi on 03/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>
#import <UMMobClick/MobClick.h>
@interface HCXThirdLibraryConfig : XData

#pragma mark - 友盟相关
/**
 *  umeng统计分析key
 */
+ (NSString *)keyUmengAnalysis;

/**
 *  umeng发送策略
 */
+ (ReportPolicy)umengSendPolicy;

/**
 *  umeng 错误报告开启关闭
 *
 *  @return void
 */
+(BOOL)crashReportEnabled;

#pragma mark--神策相关
+(NSString *)SA_SERVER_URL;
+(SensorsAnalyticsDebugMode)debugModel;

#pragma mark-融云
+(NSString *)rcimAppKey;
@end
