//
//  SYTaskTableModelManager.h
//  Foodie
//
//  Created by 兰彪 on 15/12/9.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface SYTaskTableModelManager : XData

+ (instancetype) shareTableModelManager;

/**
 *  移除所有任务
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL) removeAllTask;

/**
 *  移除指定任务
 *
 *  @param task 被移除对象
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL) removeTask:(XTask *) task;

/**
 *  添加任务
 *
 *  @param task 等待添加的任务
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL) addTask:(XTask *) task;

/**
 *  更新任务
 *
 *  @param task 等待等新的任务
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL) updateWithTask:(XTask *) task;

/**
 *  获得所有任务
 */
- (NSArray *) getAllTask;

/**
 *  根据任务ID查找得到对应任务对象
 *
 *  @param taskID 任务ID
 *
 *  @return 返回任务对象
 */
- (XTask *) getTaskWithID:(NSString *) taskID;

/**
 *  获得指定类型名的任务列表
 *
 *  @param className 任务类型名
 */
- (NSArray *) getTaskWithClassName:(NSString *) className;

@end
