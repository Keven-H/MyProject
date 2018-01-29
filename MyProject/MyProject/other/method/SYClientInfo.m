//
//  SYClientInfo.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYClientInfo.h"

@implementation SYClientInfo

+ (NSString *) clientID
{
    return [XDeviceInfo getDeviceID];
}

+ (NSString *) fromSource
{
    return @"9999";//[XAppInfo getFromSource];
}

+ (NSString *) appVersion
{
    return [XAppInfo getAppVersion];
}

+ (NSString *) osVersion
{
    return [XDeviceInfo getOSVersion];
}

+ (NSNumber *) screenWidth
{
    return [XDeviceInfo screenWidth];
}

+ (NSNumber *) screenHeight
{
    return [XDeviceInfo screenHeight];
}

+ (NSString *) machineModel
{
    return [XDeviceInfo machineModel];
}

+ (NSString *) machineModelName
{
    return [XDeviceInfo machineModelName];
}

@end
