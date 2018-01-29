//
//  SYClientInfo.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  客户端信息
 */
@interface SYClientInfo : XData

/**
 *  获取客户端设备ID
 */
+ (NSString *) clientID;

/**
 *  获取操作系统版本
 */
+ (NSString *) osVersion;

/**
 *  获取下载来源
 */
+ (NSString *) fromSource;

/**
 *  获取app版本号
 */
+ (NSString *) appVersion;

/**
 *  获取屏幕宽度
 */
+ (NSNumber *) screenWidth;

/**
 *  获取屏幕高度
 */
+ (NSNumber *) screenHeight;

/**
 *  获取机器型号
 */
+ (NSString *) machineModel;

/**
 *  获取机器型号名称
 */
+ (NSString *) machineModelName;
@end
