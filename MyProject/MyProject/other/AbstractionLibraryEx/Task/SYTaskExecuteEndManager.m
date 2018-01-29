//
//  SYTaskExecuteEndManager.m
//  Foodie
//
//  Created by 兰彪 on 15/12/19.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "SYTaskExecuteEndManager.h"

@implementation SYTaskExecuteEndManager

+ (instancetype) shareTaskExecuteEndManager
{
    static SYTaskExecuteEndManager *taskExecuteEndManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        taskExecuteEndManager = [[SYTaskExecuteEndManager alloc] init];
    });
    return taskExecuteEndManager;
}



@end
