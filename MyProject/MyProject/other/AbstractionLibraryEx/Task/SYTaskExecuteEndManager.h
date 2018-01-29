//
//  SYTaskExecuteEndManager.h
//  Foodie
//
//  Created by 兰彪 on 15/12/19.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  任务执行结束逻辑处理管理器
 */
@interface SYTaskExecuteEndManager : XData

/**
 *  任务执行结束逻辑管理器单例
 */
+ (instancetype) shareTaskExecuteEndManager;

@end
