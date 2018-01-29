//
//  SYTaskManager.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/26.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYTaskManager.h"

@implementation SYTaskManager

+ (XTaskManager *) taskManagerWithTask:(XTask *) task
{
    if([task isKindOfClass:[SYDefaultBaseTask class]])
    {
        if([[HCXDateManager shareDataManager] addNonInsertTaskDataBase:task])
        {
        }
    }
    return [super taskManagerWithTask:task];
}
@end
