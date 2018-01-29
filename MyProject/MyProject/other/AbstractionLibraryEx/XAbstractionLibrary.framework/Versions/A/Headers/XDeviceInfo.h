//
//  XDeviceInfo.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/22.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"

/**
 *  获得设备信息
 */
@interface XDeviceInfo : XData

/**
 *  获取设备ID
 */
+ (NSString *) getDeviceID;

/**
 *  获取操作系统版本
 */
+ (NSString *) getOSVersion;

/**
 *  获取屏幕宽度
 */
+ (NSNumber *) screenWidth;

/**
 *  获取屏幕高度
 */
+ (NSNumber *) screenHeight;

/**
 *  获取MAC地址
 */
+ (NSString *)macAddress;

/**
 *  获取机器型号
 */
+ (NSString *)machineModel;

/**
 *  获取机器型号名称
 */
+ (NSString *)machineModelName;

/**
 *  对低端机型的判断
 */
+ (BOOL)isLowLevelMachine;

/**
 *  设备可用空间
 *  freespace/1024/1024/1024 = B/KB/MB/14.02GB
 */
+(NSNumber *)freeSpace;

/**
 *  设备总空间
 */
+(NSNumber *)totalSpace;

/**
 *  获取运营商信息
 */
+ (NSString *)carrierName;

/**
 *  获取运营商代码
 */
+ (NSString *)carrierCode;

/**
 *  获取电池电量
 */
+ (CGFloat) getBatteryValue;

/**
 *  获取电池状态
 */
+ (NSInteger) getBatteryState;

/**
 *  是否能发短信 不准确
 */
+ (BOOL) canDeviceSendMessage;

/**
 *  获取可用内存信息
 */
+ (unsigned long)freeMemory;

/**
 *  获取已用内存信息
 */
+ (unsigned long)usedMemory;
@end
