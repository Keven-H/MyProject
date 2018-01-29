//
//  XResponse.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/22.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XModel.h"

/**
 *  网络请求状态
 */
typedef NS_OPTIONS(NSUInteger, XResponseStatusCode){
    /**
     *  常规错误，除以上错误意外的所有错误
     */
    XResponseStatusCode_ErrorOtherGeneral,
    /**
     *  成功
     */
    XResponseStatusCode_Success,
    
    /**
     *  不支持的解析
     */
    XResponseStatusCode_UnSupportParse,
    
    /**
     *  用户取消
     */
    XResponseStatusCode_ErrorCancelled,
    
    /**
     *  请求超时
     */
    XResponseStatusCode_ErrorTimedOut,
    
    /**
     *  无效的请求地址
     */
    XResponseStatusCode_ErrorBadURL,
    
    /**
     *  不支持请求的链接，有可能由于http协议版本低导致
     */
    XResponseStatusCode_ErrorUnsupportedURL,
    
    /**
     *  不能找到主机
     */
    XResponseStatusCode_ErrorCannotFindHost,
    
    /**
     *  不能链接到主机
     */
    XResponseStatusCode_ErrorCannotConnectToHost,
    
    /**
     *  网络连接丢失
     */
    XResponseStatusCode_ErrorNetWorkConnectionLost,
    
    /**
     *  DNS查找失败
     */
    XResponseStatusCode_ErrorDNSLookupFailed,
    
    /**
     *  http重定向太多
     */
    XResponseStatusCode_ErrorHTTPTooManyRedirects,
    
    /**
     *  没有连接到互联网
     */
    XResponseStatusCode_ErrorNotConnectedToInternet,
    
    /**
     *  重定向到不存在的地址
     */
    XResponseStatusCode_ErrorRedirectToNonExistentLocation,
    
    /**
     *  服务器响应坏掉了
     */
    XResponseStatusCode_ErrorBadServerResponse,
    
    /**
     *  无法解析响应
     */
    XResponseStatusCode_ErrorCannotParseResponse,
    
    /**
     *  数据长度超过最大长度
     */
    XResponseStatusCode_ErrorDataLengthExceedsMaximum,
    
    /**
     *  安全链接失效
     */
    XResponseStatusCode_ErrorSecureConnectionFailed,
    
    /**
     *  服务器证书有错误的日期
     */
    XResponseStatusCode_ErrorServerCertificateHasBadDate,
    
    /**
     *  无法从网络加载
     */
    XResponseStatusCode_ErrorCannotLoadFromNetwork,
    
    /**
     *  漫游功能关闭
     */
    XResponseStatusCode_ErrorInternationalRoamingOff,
    
    /**
     *  通话过程中
     */
    XResponseStatusCode_ErrorDataNotAllowed,
};

/**
 *  json数据mantle解析基础类
 */
@interface XResponse : XModel

/**
 *  网络请求错误码
 */
@property (nonatomic,assign,readonly) NSInteger  errorCode;

/**
 *  构造接口请求成功对象
 */
+ (instancetype) success;

/**
 *  构造接口请求网络问题失败
 */
+ (instancetype) netWorkFail;

/**
 *  构造接口请求服务器无响应
 */
+ (instancetype) serverBad;

/**
 *  构造接口请求超时
 */
+ (instancetype) timeOut;

/**
 *  构造不支持解析错误对象
 */
+ (instancetype) unSupportParse;

/**
 *  构造接口请求其它错误
 */
+ (instancetype) otherGeneralFail;

/**
 *  根据错误信息生成对应自己的response
 *
 *  @param error error对象
 *
 */
- (void) responseWithError:(NSError *) error;

/**
 *  请求失败
 *
 *  @return YES 失败  NO 成功
 */
- (BOOL) isFail;

/**
 *  请求成功
 *
 *  @return YES 成功  NO 失败
 */
- (BOOL) isSuccess;

/**
 *  请求失败，是否由于网络问题
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) isNetWorkFail;

/**
 *  请求失败，是否由于服务器无响应
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) isServerBad;

/**
 *  请求失败，是否超时
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) isTimeOut;

/**
 *  请求逻辑错误
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) isLogicErrorFail;

/**
 *  请求失败，是否除以上失败原因以外的所有原因
 *
 *  @return YES 是 NO 不是
 */
- (BOOL) isOtherGeneralFail;

/**
 *  请求结果提示
 *
 *  @return 提示语
 */
- (NSString *) responseMsg;

@end
