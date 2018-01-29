//
//  XWeiBoCommon.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XWeiBoCommon_h
#define XAbstractionLibrary_XWeiBoCommon_h

@class XWeiBoResult;
typedef void(^weiboBackCallBlock)(XWeiBoResult *result);

/**
 *  微博错误码
 */
typedef NS_ENUM(NSInteger, XWeiBoResultCode){
    /**
     *  成功
     */
    XWeiBoResultCodeSuccess,
    /**
     *  用户取消发送
     */
    XWeiBoResultCodeUserCancel,
    /**
     *  发送失败
     */
    XWeiBoResultCodeSendFail,
    /**
     *  授权失败
     */
    XWeiBoResultCodeAuthDeny,
    /**
     *  用户取消安装微博客户端
     */
    XWeiBoResultCodeUserCancelInstall,
    /**
     *  支付失败
     */
    XWeiBoResultCodePayFail,
    /**
     *  分享失败
     */
    XWeiBoResultCodeShareInSDKFailed,
    /**
     *  没有安装微博客户端
     */
    XWeiBoResultCodeUnInstall,
    /**
     *  不支持的请求
     */
    XWeiBoResultCodeUnSupport,
    /**
     *  不知道的请求
     */
    XWeiBoResultCodeUnKown,
    
    /**
     *  条件错误
     */
    XWeiBoResultCodeConditionError,
};

#endif
