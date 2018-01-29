//
//  XHttpRequestDelegate.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/25.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  下载超时时间
 */
#define                 DOWNLOAD_TIMEOUT            30

/**
 *  接口请求超时时间
 */
#define                 REQUEST_TIMEOUT             30


#define                 NETWORK_CHANGE_NOTIFICATION     @"NetWork_Change_Notifition"

@protocol XHttpResponseDelegate;
@protocol XHttpRequestDelegate <NSObject>
@optional

/**
 *  请求接口命令名
 */
@property (nonatomic,strong) NSString *command;

/**
 *  允许超时的次数
 */
@property (nonatomic,assign) NSUInteger retryCount;

/**
 *  请求拥有者
 */
@property (nonatomic,weak) id<XHttpResponseDelegate> owner;

/**
 *  取消请求
 */
- (void) cancel;

/**
 *  重试请求
 *
 *  @return nil 不能重试 否则返回一个新请求对象
 */
- (instancetype) retry;

/**
 *  删除依赖于该接口的所有代理
 */
- (void) removeAllDelegates;

/**
 *  返回当前请求操作对象
 */
- (NSOperation *) operation;

/**
 *  添加接口与代理之间的依赖关系
 *
 *  @param delegate 接口代理
 */
- (void) addDelegate:(id<XHttpResponseDelegate>) delegate;

/**
 *  删除接口与代理之间的依赖关系
 *
 *  @param delegate 接口代理
 */
- (void) removeDelegate:(id<XHttpResponseDelegate>) delegate;

/**
 *  即将开始准备请求
 *
 *  @param request 请求对象
 */
- (void) willStartRequest:(id<XHttpRequestDelegate>) request;

/**
 *  请求重试
 *
 *  @param oldRequest   旧的请求对象
 *  @param newRequest   新的请求对象
 */
- (void) willRetryRequest:(id<XHttpRequestDelegate>) oldRequest
               newRequest:(id<XHttpRequestDelegate>) newRequest;

/**
 *  请求进度回调
 *
 *  @param request 请求对象
 *  @param progress 请求进度
 *  @param totalProgress    总的进度
 */
- (void) execWithRequest:(id<XHttpRequestDelegate>) request
                progress:(long long) progress
           totalProgress:(long long) totalProgress;

/**
 *  请求完成
 *
 *  @param  request 请求对象
 *  @param  responseDic 请求结果
 *  @param  error   请求错误，如果有的话，否则nil
 */
- (void) completeDidRequest:(id<XHttpRequestDelegate>) request
                responseDic:(id) responseDic
                      error:(NSError *) error;
@end
