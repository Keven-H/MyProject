//
//  XWeiBoEngine.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XWeiBoAuthReq.h"
#import "XWeiBoImageReq.h"
#import "XWeiBoAuthResult.h"
#import "XWeiBoMessageToWeiboResult.h"

/**
 *  第三方微博引擎
 */
@interface XWeiBoEngine : XData

/**
 *  构建微博引擎单例对象
 *
 *  @return 返回微博引擎单例对象
 */
+ (XWeiBoEngine *) shareWeiBoEngine;

/**
 *  检查用户是否安装了微博客户端程序
 *
 *  @return 已安装返回YES，未安装返回NO
 */
- (BOOL) isWBAppInstalled;

/**
 *  检查用户是否可以通过微博客户端进行分享
 *
 *  @return 已安装返回YES，未安装返回NO
 */
- (BOOL) isCanShareInWeiboAPP;

/**
 *  检查用户是否可以使用微博客户端进行SSO授权
 *
 *  @return 已安装返回YES，未安装返回NO
 */
- (BOOL)isCanSSOInWeiboApp;

/**
 *  获取当前微博SDK的版本号
 *
 *  @return 当前微博SDK的版本号
 */
- (NSString *) getSDKVersion;

/**
 *  获取微博客户端程序的itunes安装地址
 *
 *  @return 微博客户端程序的itunes安装地址
 */
- (NSString *)getWeiboAppInstallUrl;

/**
 *  打开微博客户端程序
 *
 *  @return 已安装返回YES，未安装返回NO
 */
- (BOOL)openWeiboApp;

/**
 *  判断微博通过URL启动App时传递的数据
 *  需要在application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 *
 *  @param url 返回的url数据
 *
 *  @return 成功返回YES 失败返回NO
 */
- (BOOL) canHandleOpenURL:(NSURL*) url;

/**
 *  处理微博通过URL启动App时传递的数据
 *  需要在application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 *
 *  @param url 返回的url数据
 *
 *  @return 成功返回YES 失败返回NO
 */
- (BOOL) handleOpenURL:(NSURL *) url;

/**
 *  发起微博请求
 *
 *  @param weiBoReq           请求对象
 *  @param weiboBackCallBlock 请求回调
 *
 *  @return 成功返回YES 失败返回NO
 */
- (BOOL) sendReqWithWeiBo:(XWeiBoReq *) weiBoReq
       weiboBackCallBlock:(weiboBackCallBlock) weiboBackCallBlock;
@end
