//
//  XWeChat.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/29.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "WXApi.h"
#import "XWeChatCommon.h"

/**
 *  微信分享请求基础类
 */
@interface XWeChatReq : XData

/**
 *  分享的目的地
 */
@property (nonatomic,assign) XWeChatScene scene;

/**
 *  初始化微信请求对象
 *
 *  @param scene 分享的目的地
 *
 *  @return 返回微信请求对象
 */
- (instancetype) initWithScene:(XWeChatScene) scene;

/**
 *  验证分享的数据合法性
 *
 *  @return YES合法  NO不合法
 */
- (BOOL) invalidaData:(void(^)(XWeChatResult *result)) block;

/**
 *  将自身的分享结构数据映射回微信请求对象
 *
 *  @return 返回微信请求对象
 */
- (BaseReq *) messageObj;

@end
