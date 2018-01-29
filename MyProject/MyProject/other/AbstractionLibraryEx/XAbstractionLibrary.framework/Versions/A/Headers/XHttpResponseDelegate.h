//
//  XHttpResponseDelegate.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/25.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XHttpRequestDelegate;
/**
 *  接口请求回调block定义
 */
typedef void(^XResponseBlock)(id<XHttpRequestDelegate> httpRequest,id responseObj,NSError *error);


@protocol XHttpResponseDelegate <NSObject>
@optional
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
