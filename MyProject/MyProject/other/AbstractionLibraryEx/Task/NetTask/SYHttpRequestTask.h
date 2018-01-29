//
//  SYHttpRequestTask.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/26.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYBaseHttpRequestTask.h"

/**
 *  http接口请求任务
 */
@interface SYHttpRequestTask : SYBaseHttpRequestTask

/**
 *  任务执行完成回调执行体
 */
@property (nonatomic,copy) SYTaskResponseBlock taskResponseBlock;

/**
 *  创建接口请求任务
 *
 *  @param httpSafe      安全链接类型
 *  @param httpType      请求方式
 *  @param requestParams 接口请求参数
 *  @param delegate      接口请求代理
 *  @param className     接口解析
 *  @param responseblock 接口回调
 *
 *  @return 返回接口请求任务
 */
+ (instancetype) createHttpRequestTaskWithHttpSafe:(HttpSafeType) httpSafe
                                          httpType:(HttpType) httpType
                                     requestParams:(NSDictionary *) requestParams
                                          delegate:(id<XTaskDelegate>) delegate
                                         className:(Class) className
                                     responseblock:(SYTaskResponseBlock) responseblock;

/**
 *  创建接口请求任务
 *
 *  @param httpSafe      安全链接类型
 *  @param requestParams 接口请求参数
 *  @param delegate      接口请求代理
 *  @param className     接口解析
 *  @param responseblock 接口回调
 *
 *  @return 返回接口请求任务
 */
+ (instancetype) createHttpRequestTaskWithHttpSafe:(HttpSafeType) httpSafe
                                     requestParams:(NSDictionary *) requestParams
                                          delegate:(id<XTaskDelegate>) delegate
                                         className:(Class) className
                                     responseblock:(SYTaskResponseBlock) responseblock;

/**
 *  创建接口请求任务
 *
 *  @param httpType      请求方式
 *  @param command       接口名
 *  @param requestParams 接口请求参数
 *  @param delegate      接口请求代理
 *  @param className     接口解析
 *  @param responseblock 接口回调
 *
 *  @return 返回接口请求任务
 */
+ (instancetype) createHttpRequestTaskWithHttpType:(HttpType) httpType
                                     requestParams:(NSDictionary *) requestParams
                                          delegate:(id<XTaskDelegate>) delegate
                                         className:(Class) className
                                     responseblock:(SYTaskResponseBlock) responseblockl;

/**
 *  创建接口请求任务
 *
 *  @param requestParams 接口请求参数
 *  @param delegate      接口请求代理
 *  @param className     接口解析
 *  @param responseblock 接口回调
 *
 *  @return 返回接口请求任务
 */
+ (instancetype) createHttpRequestTaskWithRequestParams:(NSDictionary *) requestParams
                                               delegate:(id<XTaskDelegate>) delegate
                                              className:(Class) className
                                          responseblock:(SYTaskResponseBlock) responseblock;

@end
