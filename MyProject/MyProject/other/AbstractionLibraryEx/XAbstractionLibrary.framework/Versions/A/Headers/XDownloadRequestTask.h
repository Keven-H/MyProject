//
//  XDownloadRequestTask.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/4.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XHttpNetTask.h"

/**
 *  下载请求任务
 */
@interface XDownloadRequestTask : XHttpNetTask

/**
 *  下载保存地址
 */
@property (nonatomic,strong) NSString *saveFilePath;

@end
