//
//  XTaskDelegate.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/2.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTask;

/**
 *  任务代理接口
 */
@protocol XTaskDelegate <NSObject>
@optional

/**
 *  即将新添加的任务
 *
 *  @param newTask 任务对象
 */
- (void) willAddTask:(XTask *) newTask;

/**
 *  即将移除旧的任务
 *
 *  @param oldTask  旧的任务对象
 */
- (void) willRemoveTask:(XTask *) oldTask;

/**
 *  任务即将开始请求
 *
 *  @param task 任务对象
 */
- (void) willStartTask:(XTask *) task;


/**
 *  任务请求超时，重试请求
 *
 *  @param task 任务对象
 */
- (void) willRetryTask:(XTask *) task;


/**
 *  任务请求进度
 *
 *  @param task 任务对象
 *  @param progress 当前的进度
 *  @param totalProgress 总的进度
 */
- (void) execWithTask:(XTask *) task
             progress:(long long) progress
        totalProgress:(long long) totalProgress;

/**
 *  任务请求结束回调
 *
 *  @param task 任务对象
 *  @param responseObj 任务请求结束回调
 *  @param error 任务请求错误信息，如果有的话
 */
- (void) completeDidTask:(XTask *) task
             responseObj:(NSDictionary *) responseObj
                   error:(NSError *) error;


@end
