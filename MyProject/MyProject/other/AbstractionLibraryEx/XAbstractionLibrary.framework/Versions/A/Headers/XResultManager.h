//
//  XResultManager.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/11.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  任务结果调度管理器
 */
@interface XResultManager : XData

/**
 *  返回任务结果调度管理器，单例模式
 *
 */
+ (instancetype) shareResultManager;

/**
 *  添加任务到结果调度管理器
 *
 *  @param task 抽象任务对象
 */
- (void) addTask:(XData *) task;
@end

