//
//  XWeChatEngine.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/29.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XWeChatAuthReq.h"
#import "XWeChatLinkReq.h"
#import "XWeChatImageReq.h"
#import "XWeChatAuthResult.h"

/**
 *  第三方微信引擎
 */
@interface XWeChatEngine : XData

/**
 *  单例对象
 *
 *  @return 返回微信引擎单例对象
 */
+ (XWeChatEngine *) shareWeChatEngine;

/**
 *  判断是否安装微信
 *
 *  @return YES安装  NO未安装
 */
- (BOOL) isWXAppInstalled;

/**
 *  判断当前版本的微信是否支持openAPI
 *
 *  @return YES支持  NO不支持
 */
- (BOOL) isWXAppSupportAPI;

/**
 *  处理微信通过URL启动App时传递的数据
 *
 *  @param url 返回的url数据
 *
 *  @return YES能处理 NO不能处理
 */
- (BOOL) canHandleOpenURL:(NSURL *) url;

/**
 *  处理微信通过URL启动App时传递的数据
 *  需要在application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 *
 *  @param url 返回的url数据
 *
 *  @return 成功返回YES 失败返回NO
 */
- (BOOL) handleOpenURL:(NSURL *) url;

/**
 *  获取当前微信SDK的版本号
 *
 *  @return 返回当前微信SDK的版本号
 */
- (NSString*) getAPIVersion;

/**
 *  打开微信
 *
 *  @return 成功返回YES 失败返回NO
 */
- (BOOL) openWXApp;

/**
 *  获取微信的安装地址
 *
 *  @return 返回微信的安装地址
 */
- (NSString *) getWXAppInstallURL;

/**
 *  发送微信请求
 *
 *  @param weChat              请求对象
 *  @param weChatBackCallBlock 请求回调
 *
 *  @return 成功返回YES 失败返回NO
 */
- (BOOL) sendReqWithWeChat:(XWeChatReq *) weChat
       weChatBackCallBlock:(weChatBackCallBlock) weChatBackCallBlock;


@end
