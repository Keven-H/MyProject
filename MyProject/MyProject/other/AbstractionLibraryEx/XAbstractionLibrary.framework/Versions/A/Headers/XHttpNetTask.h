//
//  XHttpNetTask.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/31.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XNetTask.h"
#import "XHttpResponseDelegate.h"
/**
 *  请求样式Get或Post
 */
typedef NS_OPTIONS(NSUInteger, HttpType){
    /**
     *  默认Post请求
     */
    HttpType_None,
    /**
     *  Get请求
     */
    HttpType_Post = HttpType_None,
    /**
     *  Post请求
     */
    HttpType_Get,
};

/**
 *  安全请求样式
 */
typedef NS_OPTIONS(NSUInteger, HttpSafeType){
    /**
     *  默认HTTP请求
     */
    HttpSafeType_None,
    /**
     *  HTTP请求
     */
    HttpSafeType_Http = HttpSafeType_None,
    /**
     *  HTTPS请求
     */
    HttpSafeType_Https,
};

/**
 *  HTTP基础网络任务
 */
@interface XHttpNetTask : XNetTask<XHttpResponseDelegate>
{
@protected
    NSMutableArray  *_requestList;
}

/**
 *  链接类型
 */
@property (nonatomic,assign) HttpSafeType httpSafeType;

/**
 *  接口名
 */
@property (nonatomic,strong) NSString *command;

/**
 *  接口请求参数
 */
@property (nonatomic,strong) NSDictionary *requestParam;

/**
 *  解析model
 */
@property (nonatomic,strong) Class className;
@end
