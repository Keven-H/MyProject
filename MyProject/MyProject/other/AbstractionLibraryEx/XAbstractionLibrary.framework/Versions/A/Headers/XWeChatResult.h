//
//  XWeChatResult.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/29.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XWeChatCommon.h"

/**
 *  条件错误码
 */
typedef NS_ENUM(NSInteger, XWeChatConditionError){
    /**
     *  标题太短
     */
    XWeChatConditionErrorTitleTooShort,
    /**
     *  标题太长
     */
    XWeChatConditionErrorTitleTooLong,
    
    /**
     *  描述太长
     */
    XWeChatConditionErrorDescTooLong,
    
    /**
     *  缩略图太小
     */
    XWeChatConditionErrorThumbImageTooSmall,
    
    /**
     *  缩略图太大
     */
    XWeChatConditionErrorThumbImageTooLarge,
    
    /**
     *  视频地址长度太短
     */
    XWeChatConditionErrorVideoURLTooShort,
    
    /**
     *  视频地址长度太长
     */
    XWeChatConditionErrorVideoURLTooLong,
    
    /**
     *  文本内容太短
     */
    XWeChatConditionErrorTextContentTooShort,
    
    /**
     *  文本内容太长
     */
    XWeChatConditionErrorTextContentTooLong,
    
    /**
     *  web的url地址太短
     */
    XWeChatConditionErrorWebUrlTooShort,
    
    /**
     *  web的url地址太长
     */
    XWeChatConditionErrorWebUrlTooLong,
    
    /**
     *  web的tagName太长
     */
    XWeChatConditionErrorTagNameTooLong,
    
    /**
     *  分享的图片太小
     */
    XWeChatConditionErrorImageTooSmall,
    
    /**
     *  分享的图片太大
     */
    XWeChatConditionErrorImageTooLarge,
};


@class BaseResp;

/**
 *  微信分享结果基础类
 */
@interface XWeChatResult : XData

/**
 *  分享结果信息
 */
@property (nonatomic,strong) NSString *errorInfo;

/**
 *  分享结果码
 */
@property (nonatomic,assign) XWeChatResultCode resultCode;

/**
 *  操作成功
 *
 *  @return 成功对象
 */
+ (XWeChatResult *) success;

/**
 *  没有安装微信错误
 *
 *  @return 返回相关错误对象
 */
+ (XWeChatResult *) notInstallApp;

/**
 *  当前客户端不支持
 *
 *  @return 返回相关错误对象
 */
+ (XWeChatResult *) notSupportAPI;

/**
 *  未知错误
 *
 *  @return 返回相关错误对象
 */
+ (XWeChatResult *) DontKownError;

/**
 *  构建由于条件不成立回调的对象
 *
 *  @param errorCode 条件错误码
 *
 *  @return 返回回调对象
 */
+ (XWeChatResult *) createWeChatResultWithConditionErrorCode:(XWeChatConditionError) errorCode;

/**
 *  微信结果信息对工程结果信息的映射
 *
 *  @param resp 微信返回的分享结果基础类
 */
- (void) pasteData:(BaseResp *) resp;

@end
