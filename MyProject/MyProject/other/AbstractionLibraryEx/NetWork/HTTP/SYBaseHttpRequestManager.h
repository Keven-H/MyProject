//
//  SYBaseHttpRequestManager.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/17.
//  Copyright © 2015年 兰彪. All rights reserved.
//
#import "SYResponse.h"
#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  接口请求回调
 *
 *  @param request     被回调的请求对象
 *  @param response    请求结果对象
 *  @param responseDic 请求结果原始数据
 */
typedef void(^SYResponseBlock)(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic);

/**
 *  http(含https)请求基础类，添加一些网络公共参数的组合及其相关逻辑
 */
@interface SYBaseHttpRequestManager : XHttpRequestManager

/**
 *  接口请求主机地址
 */
@property (nonatomic,strong) NSString *httpHostAddress;

/**
 *  组合公共参数
 *
 *  @param param 私有参数
 *
 *  @return 返回组合参数字典
 */
- (NSDictionary *) addDefaultParam:(NSDictionary *) param;

/**
 *  get请求
 *
 *  @param requestParams  接口请求参数集合
 *  @param delegate       接口请求代理
 *  @param className      返回请求的数据类型，方便在网络层直接解析处理(注意此类必须mantle的基类,否侧不解析直接返回网络层数据).
 *  @param responseblock  接口请求回调执行体
 *
 *  @return 接口请求对象
 */
- (id<XHttpRequestDelegate>) getRequestWithRequestParams:(NSDictionary *) requestParams
                                            httpDelegate:(id<XHttpResponseDelegate>) delegate
                                               className:(Class) className
                                           responseblock:(SYResponseBlock) responseblock;

/**
 *  post请求
 *
 *  @param postParams    接口请求参数集合
 *  @param delegate      接口请求代理
 *  @param className     返回请求的数据类型，方便在网络层直接解析处理(注意此类必须mantle的基类,否侧不解析直接返回网络层数据).
 *  @param responseblock 接口请求回调执行体
 *
 *  @return 接口请求对象
 */
- (id<XHttpRequestDelegate>) postRequestWithRequestParams:(NSDictionary *) postParams
                                          httpDelegate:(id<XHttpResponseDelegate>) delegate
                                             className:(Class) className
                                         responseblock:(SYResponseBlock) responseblock;

/**
 *  upload上传
 *
 *  @param uploadParams  上传请求参数
 *  @param filePath      待上传的文件
 *  @param delegate      上传请求代理
 *  @param className     返回请求的数据类型，方便在网络层直接解析处理(注意此类必须mantle的基类,否侧不解析直接返回网络层数据).
 *  @param responseblock 接口请求回调执行体
 *
 *  @return 接口请求对象
 */
- (id<XHttpRequestDelegate>) uploadRequesrWithRequestParam:(NSDictionary *) uploadParams
                                                  filePath:(NSString *) filePath
                                              httpDelegate:(id<XHttpResponseDelegate>) delegate
                                                 className:(Class) className
                                             responseblock:(SYResponseBlock) responseblock;

@end
