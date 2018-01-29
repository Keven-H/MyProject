//
//  XUploadRequestTask.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/4.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XHttpNetTask.h"

/**
 *  上传任务
 */
@interface XUploadRequestTask : XHttpNetTask

/**
 *  待上传文件本地路径
 */
@property (nonatomic,strong) NSString *uploadFilePath;

@end
