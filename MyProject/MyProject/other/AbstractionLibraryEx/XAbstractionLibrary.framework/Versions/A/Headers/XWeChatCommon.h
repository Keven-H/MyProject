//
//  XWeChatCommon.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/29.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XWeChatCommon_h
#define XAbstractionLibrary_XWeChatCommon_h

@class XWeChatResult;
typedef void(^weChatBackCallBlock)(XWeChatResult *result);

/**
 *  分享目的地
 */
typedef NS_ENUM(NSInteger, XWeChatScene){
    /**
     *  聊天界面
     */
    XWeChatSceneSession,
    /**
     *  朋友圈
     */
    XWeChatSceneTimeLine,
    /**
     *  收藏
     */
    XWeChatSceneFavorite,
};

/**
 *  微信分享返回数据结构
 */
typedef NS_ENUM(NSInteger, XWeChatResultCode){
    /**
     *  不知道的错误
     */
    XWeChatResultCodeNone,
    /**
     *  分享成功
     */
    XWeChatResultCodeSuccess,
    /**
     *  普通错误类型
     */
    XWeChatResultCodeCommon,
    /**
     *  用户点击取消并返回
     */
    XWeChatResultCodeUserCancel,
    /**
     *  发送失败
     */
    XWeChatResultCodeSendFail,
    /**
     *  授权失败
     */
    XWeChatResultCodeAuthDeny,
    /**
     *  微信不支持
     */
    XWeChatResultCodeUnSupport,
    
    /**
     *  未安装微信
     */
    XWeChatResultCodeUnInstall,
    
    /**
     *  条件错误
     */
    XWeChatResultCodeConditionError,
};

#endif
