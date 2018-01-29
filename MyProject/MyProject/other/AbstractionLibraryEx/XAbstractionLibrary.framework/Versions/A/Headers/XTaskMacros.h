//
//  XTaskMacros.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/19.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#ifndef XAbstractionLibrary_XTaskMacros_h
#define XAbstractionLibrary_XTaskMacros_h

/**
 *  等待消息默认超时时间，主要用于线程取任务队列的超时时间 单位：秒
 */
#define             Thread_Wait_Message_TimeOut                        3

/**
 *  管理线程默认的等待超时时间 单位：秒
 */
#define             ManagerThread_Wait_Exec_TimeOut                    3


/**
 *  设置线程等待状态，自动醒过来的等待时间，很久，单位：秒
 */
#define             Thread_Pause_TimeOut                      60 * 60 * 24 * 100

/**
 *  结果处理线程的runloop等待超时时间，单位：秒
 */
#define             Result_Wait_TimeOut                       10

/**
 *  任务回调等待主线程等待超时重试次数
 */
#define             Result_TimeOut_retryCount                 3

/**
 *  任务回调等待主线程等待超时时间 单位：秒
 */
#define             Result_WaitMainThread_TimeOut             1.f

/**
 *  关闭管理线程过程中的等待时长，由于是异步的，所以需要等待先设置任务线程的状态以后才能关闭管理线程本身.
 */
#define             Close_ManagerThread_Wait_Time             1.f

#endif
