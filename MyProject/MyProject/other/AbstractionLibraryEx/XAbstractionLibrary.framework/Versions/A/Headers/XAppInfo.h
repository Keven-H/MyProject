//
//  XAppInfo.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/22.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"

/**
 *  获取app信息
 */
@interface XAppInfo : XData

/**
 *  获取app版本号
 */
+ (NSString *) getAppVersion;

/**
 *  获取下载来源
 */
+ (NSString *) getFromSource;

@end
