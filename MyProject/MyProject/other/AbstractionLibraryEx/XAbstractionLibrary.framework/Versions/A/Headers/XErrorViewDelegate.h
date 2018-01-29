//
//  XErrorViewDelegate.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/25.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XRetryDelegate;

/**
 *  加载错误页的抽象基础接口定义
 */
@protocol XErrorViewDelegate <NSObject>

@optional
/**
 *  重试请求的代理对象
 */
@property (nonatomic,weak) id<XRetryDelegate> retryDelete;

/**
 *  开始准备加载之前会被调用
 */
- (void) startLoad;

/**
 *  加载过程中会被调用
 *
 *  @param progress      已加载的进度
 *  @param totalProgress 总的加载进度
 */
- (void) loadingWithProgress:(CGFloat) progress
               totalProgress:(CGFloat) totalProgress;

/**
 *  加载成功或失败的结果回调，用于在某些情况下显示必要的错误页
 *
 *  @param bComplete YES 访问成功 NO 访问失败
 */
- (void) completeLoad:(BOOL) bComplete;

@end

/**
 *  错误页相关的回调接口
 */
@protocol XRetryDelegate <NSObject>
@optional
/**
 *  重试请求回调
 */
- (void) retryControl:(id<XErrorViewDelegate>) delegate;
@end
