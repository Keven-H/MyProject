//
//  XTask.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/22.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XTaskDelegate.h"

/**
 *  任务优先级
 */
typedef NS_ENUM(NSInteger, XTaskPriority){
    /**
     *  默认低优先级
     */
    XTaskPriorityNone,
    /**
     *  低优先级
     */
    XTaskPriorityLow = XTaskPriorityNone,
    /**
     *  中等优先级
     */
    XTaskPriorityMedium,
    /**
     *  高优先级
     */
    XTaskPriorityHigh
};

/**
 *  任务执行状态
 */
typedef NS_ENUM(NSInteger, XTaskExecutState) {
    /**
     *  准备状态
     */
    XTaskExecutStateReady,
    /**
     *  执行中
     */
    XTaskExecutStateExecing,
    /**
     *  完成
     */
    XTaskExecutStateComplete,
    
    /**
     *  取消
     */
    XTaskExecutStateCancel,
    
    /**
     *  失败
     */
    XTaskExecutStateFail,
};

/**
 *  基础任务对象
 */
@interface XTask : XData

/**
 *  任务是否完成
 */
@property (nonatomic,assign,readonly) BOOL bFinish;
/**
 *  任务是否取消
 */
@property (nonatomic,assign) BOOL bCanceled;

/**
 *  任务进度
 */
@property (nonatomic,assign) CGFloat taskProgress;

/**
 *  任务代理
 */
@property (nonatomic,weak) id<XTaskDelegate> delegate;

/**
 *  任务处理结果是否在主线程，YES 是 NO 不是
 */
@property (nonatomic,assign) BOOL bMainThreadCallBack;

/**
 *  任务优先级
 */
@property (nonatomic,assign) XTaskPriority taskPriority;

/**
 *  任务执行状态
 */
@property (nonatomic,assign) XTaskExecutState taskExecutState;


/**
 *  任务执行器
 */
- (void) taskExecutor;

/**
 *  表示任务执行器执行结束,程序员忽略该方法
 */
- (void) taskExecutorEnd;

/**
 *  任务请求结果回调
 */
- (void) taskResultCallBack;

/**
 *  取消任务
 */
- (void) taskCancel;

/**
 *  判断任务合法性
 *
 *  @return YES 合法 NO 不合法
 */
- (BOOL) isValidataTask;

@end
