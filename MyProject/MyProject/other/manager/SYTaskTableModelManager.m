//
//  SYTaskTableModelManager.m
//  Foodie
//
//  Created by 兰彪 on 15/12/9.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "SYDataBaseManager.h"
#import "SYTaskTableModelManager.h"

@implementation SYTaskTableModelManager

+ (instancetype) shareTableModelManager
{
    static SYTaskTableModelManager *shareTableModelManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareTableModelManager = [[SYTaskTableModelManager alloc] init];
        SYTaskTableModel *createTaskModel = [SYTaskTableModel createTaskTable];
        [[SYDataBaseManager shareDataBaseManager] updateDataBaseWithXTableModel:createTaskModel];
    });
    return shareTableModelManager;
}

- (instancetype) init
{
    if(self = [super init])
    {
       
    }
    return self;
}

- (NSArray *) getTaskWithClassName:(NSString*) className
{
    __block NSArray *taskList = nil;
    if(!className)
        return [self getAllTask];
    
    SYTaskTableModel *selectTaskTable = [[SYTaskTableModel alloc] init];
    [selectTaskTable selectTaskWithClassName:className];
    [[SYDataBaseManager shareDataBaseManager] QueryDataBaseWithXTableModel:selectTaskTable
                                                             responseBlock:^(NSArray *responseObj) {
                                                                 taskList = [selectTaskTable tasksWithDataList:responseObj];
                                                             }];
    return taskList;
}

- (XTask *) getTaskWithID:(NSString *) taskID
{
    __block XTask *task = nil;
    if(!taskID)
        return task;
    
    SYTaskTableModel *selectTaskTable = [[SYTaskTableModel alloc] init];
    [selectTaskTable selectTaskWithID:taskID];
    [[SYDataBaseManager shareDataBaseManager] QueryDataBaseWithXTableModel:selectTaskTable
                                                             responseBlock:^(NSArray *responseObj) {
                                                                NSArray *taskList = [selectTaskTable tasksWithDataList:responseObj];
                                                                 if(taskList.count > 0)
                                                                     task = [taskList objectAtIndex:0];
                                                             }];
    return task;
}

- (NSArray *) getAllTask
{
    __block NSArray *taskList = nil;
    SYTaskTableModel *selectTaskTable = [[SYTaskTableModel alloc] init];
    [selectTaskTable selectAllTask];
    [[SYDataBaseManager shareDataBaseManager] QueryDataBaseWithXTableModel:selectTaskTable
                                                             responseBlock:^(NSArray *responseObj) {
                                                                 taskList = [selectTaskTable tasksWithDataList:responseObj];
                                                             }];
    return taskList;
}

- (BOOL) addTask:(XTask *) task
{
    __block BOOL ret = NO;
    SYTaskTableModel *selectTaskModel = [[SYTaskTableModel alloc] init];
    [selectTaskModel selectTaskWithID:task.ID];
    [[SYDataBaseManager shareDataBaseManager] QueryDataBaseWithXTableModel:selectTaskModel
                                                             responseBlock:^(NSArray *responseObj) {
                                                                 if(responseObj.count > 0)
                                                                 {
                                                                     SYTaskTableModel *updateTaskModel = [[SYTaskTableModel alloc] init];
                                                                     [updateTaskModel updateTask:task];
                                                                     ret = [[SYDataBaseManager shareDataBaseManager] updateDataBaseWithXTableModel:updateTaskModel];
                                                                 }
                                                                 else
                                                                 {
                                                                     SYTaskTableModel *insertTaskModel = [[SYTaskTableModel alloc] init];
                                                                     [insertTaskModel insertTask:task];
                                                                     ret = [[SYDataBaseManager shareDataBaseManager] updateDataBaseWithXTableModel:insertTaskModel];
                                                                 }
                                                             }];
    
    
    return ret;
}

- (BOOL) removeTask:(XTask *) task
{
    SYTaskTableModel *removeTaskModel = [[SYTaskTableModel alloc] init];
    [removeTaskModel removeTask:task];
    BOOL ret = [[SYDataBaseManager shareDataBaseManager] updateDataBaseWithXTableModel:removeTaskModel];
    return ret;
}

- (BOOL) removeAllTask
{
    SYTaskTableModel *removeAllTaskModel = [[SYTaskTableModel alloc] init];
    [removeAllTaskModel removeAllTask];
    BOOL ret = [[SYDataBaseManager shareDataBaseManager] updateDataBaseWithXTableModel:removeAllTaskModel];
    return ret;
}

- (BOOL) updateWithTask:(XTask *) task
{
    SYTaskTableModel *updateTaskModel = [[SYTaskTableModel alloc] init];
    [updateTaskModel updateTask:task];
    BOOL ret = [[SYDataBaseManager shareDataBaseManager] updateDataBaseWithXTableModel:updateTaskModel];
    return ret;
}

@end
