//
//  DeviceMacros.h
//  EatEquity
//
//  Created by 兰彪 on 2017/12/29.
//  Copyright © 2017年 兰彪. All rights reserved.
//

#ifndef DeviceMacros_h
#define DeviceMacros_h

/**
 *  判断是否为iPhone
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/**
 *  判断是否为iPad
 */
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 *  判断是否为ipod
 */
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/**
 *  判断是否retina屏
 */
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/**
 *  屏幕宽度
 */
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

/**
 *  获得屏幕长的那边
 */
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

/**
 *  获得屏幕短的那边
 */
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


/**
 *  iPhone4(包含)以下机型
 */
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)

/**
 *  iPhone5、iPhone5S机型
 */
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)

/**
 *  iPhone6机型
 */
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)

/**
 *  iPhone6P机型
 */
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

/**
 *  IOS7.0以上系统版本
 */
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? (YES):(NO))

#endif /* DeviceMacros_h */
