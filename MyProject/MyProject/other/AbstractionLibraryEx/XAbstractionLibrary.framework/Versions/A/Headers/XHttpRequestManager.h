//
//  XHttpRequestManager.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/25.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XHttpRequestDelegate.h"
#import "XHttpResponseDelegate.h"

typedef NS_ENUM(NSInteger, NetworkReachabilityStatus) {
    NetworkReachabilityStatusUnknown          = -1,
    NetworkReachabilityStatusNotReachable     = 0,
    NetworkReachabilityStatusReachableViaWWAN = 1,
    NetworkReachabilityStatusReachableViaWiFi = 2,
};


/**
 *  接口请求管理对象
 */
@interface XHttpRequestManager : XData

/**
 *  get请求
 *
 *  @param requestUrlString     接口请求url
 *  @param requestParams        接口请求参数集合
 *  @param delegate             接口请求回调代理
 *  @param responseblock        接口请求结果回调block
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithUrlString:(NSString *) requestUrlString
                                  requestParams:(NSDictionary *) requestParams
                                   httpDelegate:(id<XHttpResponseDelegate>) delegate
                                  responseblock:(XResponseBlock) responseblock;


/**
 *  get请求,公共参数放在header中
 *
 *  @param requestUrlString     接口请求url
 *  @param requestParams        接口请求私有参数集合
 *  @param publicParams         接口共有参数集合
 *  @param delegate             接口请求回调代理
 *  @param responseblock        接口请求结果回调block
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithUrlString:(NSString *) requestUrlString
                                       requestParams:(NSDictionary *) requestParams
                                        publicParams:(NSDictionary *) publicParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock;

/**
 *  post请求
 *
 *  @param postUrlString    接口请求url
 *  @param postParams       接口请求参数集合
 *  @param delegate         接口请求代理
 *  @param responseblock    接口请求回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithUrlString:(NSString *) postUrlString
                                      postParams:(NSDictionary *) postParams
                                    httpDelegate:(id<XHttpResponseDelegate>) delegate
                                   responseblock:(XResponseBlock) responseblock;

/**
 *  post请求，公共参数放在header中
 *
 *  @param postUrlString    接口请求url
 *  @param postParams       接口请求参数集合
 
 *  @param delegate         接口请求代理
 *  @param responseblock    接口请求回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithUrlString:(NSString *) postUrlString
                                           postParams:(NSDictionary *) postParams
                                         publicParams:(NSDictionary *) publicParams
                                         httpDelegate:(id<XHttpResponseDelegate>) delegate
                                        responseblock:(XResponseBlock) responseblock;


/**
 *  上传文件
 *
 *  @param uploadUrlString 接口请求url
 *  @param parameters      接口请求参数集合
 *  @param filePath        待上传的文件路径
 *  @param delegate        接口请求代理
 *  @param responseblock   接口请求回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) uploadRequestWithUrlString:(NSString *) uploadUrlString
                                             parameters:(NSDictionary *) parameters
                                         uploadFilePath:(NSString *) filePath
                                           httpDelegate:(id<XHttpResponseDelegate>) delegate
                                          responseblock:(XResponseBlock) responseblock;

/**
 *  下载文件
 *
 *  @param downloadUrlString 接口请求url
 *  @param parameters        接口请求参数集合
 *  @param saveFilePath      下载保存文件路径
 *  @param delegate          接口请求代理
 *  @param responseblock     接口请求回调
 *
 *  @return 请求对象
 */
- (id<XHttpRequestDelegate>) downloadRequestWithUrlString:(NSString *) downloadUrlString
                                               parameters:(NSDictionary *) parameters
                                             saveFilePath:(NSString *) saveFilePath
                                             httpDelegate:(id<XHttpResponseDelegate>) delegate
                                            responseblock:(XResponseBlock) responseblock;

@end
