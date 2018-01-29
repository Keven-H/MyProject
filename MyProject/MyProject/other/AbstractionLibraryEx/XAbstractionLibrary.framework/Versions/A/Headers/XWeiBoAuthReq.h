//
//  XWeiBoAuthReq.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XWeiBoReq.h"

/**
 *  微博授权请求对象基础类
 */
@interface XWeiBoAuthReq : XWeiBoReq

/**
 *  微博开放平台第三方应用scope
 */
@property (nonatomic,strong) NSString *scope;

/**
 *  微博授权请求的自定义信息字典
 */
@property (nonatomic,strong) NSDictionary *userInfo;

/**
 *  微博开放平台第三方应用授权回调页地址
 */
@property (nonatomic,strong) NSString *kRedirectURI;

@end
