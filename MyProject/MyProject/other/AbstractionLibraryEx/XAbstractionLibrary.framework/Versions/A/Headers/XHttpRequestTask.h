//
//  XHttpRequestTask.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/4.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XHttpNetTask.h"

/**
 *  短链接接口请求任务
 */
@interface XHttpRequestTask : XHttpNetTask

/**
 *  请求方式 GET/POST
 */
@property (nonatomic,assign) HttpType httpType;

@end
