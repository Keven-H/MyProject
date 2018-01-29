//
//  XWeChatAuthResult.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/30.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XWeChatResult.h"

/**
 *  微信授权请求结果基础对象
 */
@interface XWeChatAuthResult : XWeChatResult

/**
 *  微信返回，登录相关
 */
@property (nonatomic,strong) NSString *code;

/**
 *  第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传
 *  @note state字符串长度不能超过1K
 */
@property (nonatomic,strong) NSString *state;

/**
 *  微信返回，保留
 */
@property (nonatomic,strong) NSString *lang;

/**
 *  微信返回，保留
 */
@property (nonatomic,strong) NSString *country;

@end
