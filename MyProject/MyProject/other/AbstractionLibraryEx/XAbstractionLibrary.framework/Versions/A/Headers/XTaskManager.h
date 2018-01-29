//
//  XTaskManager.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/4.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XOtherTask.h"
#import "XHttpRequestTask.h"
#import "XUploadRequestTask.h"
#import "XDownloadRequestTask.h"
#import "XLongHttpRequestTask.h"

@class XTask;
/**
 *  基础任务调度管理器，主要用于管理任务的调度
 */
@interface XTaskManager : XData

/**
 *  抽象工厂模式的任务调度管理器
 *
 *  @param task 抽象任务
 *
 *  @return 根据task抽象任务返回合适的任务调度管理器
 */
+ (XTaskManager *) taskManagerWithTask:(XTask *) task;

/**
 *  暂停任务管理器
 */
+ (void) pauseTaskService:(XTask *) task;

/**
 *  打开或唤醒任务管理器
 */
+ (void) executeTaskService:(XTask *) task;

/**
 *  停止任务管理器
 */
+ (void) stopTaskService:(XTask *) task;
/**
 *  获得目前待调度处理的任务个数
 *
 *  @return 待处理的调度任务个数
 */
- (NSUInteger) count;

/**
 *  获得目前最近即将等待调度的任务
 *
 *  @return 等待调度的抽象任务
 */
- (XTask *) firstTask;

/**
 *  清除当前任务调度器管理下的所有任务
 */
- (void) removeAllTask;

/**
 *  添加抽象任务到当前任务调度器中，等待调度
 *
 *  @param task 被添加的抽象任务
 */
- (void) addTask:(XTask *) task;

/**
 *  从当前任务调度器中移除等待调度的抽象任务
 *
 *  @param task 期望被移除的抽象任务
 */
- (void) removeTask:(XTask *) task;

@end
