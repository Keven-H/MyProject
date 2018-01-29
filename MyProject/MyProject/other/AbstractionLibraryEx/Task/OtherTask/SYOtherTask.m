//
//  SYOtherTask.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/26.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYOtherTask.h"

@implementation SYOtherTask

- (void) taskExecutorEnd
{
    sleep(0.2f);
    [super taskExecutorEnd];
}

- (void) taskExecutor
{
    if(self.bCanceled)
        return;
    
    if(![super isValidataTask])
        return;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3.0f);
        [weakSelf taskExecutorEnd];
    });
    [super taskExecutor];
}

- (void) taskResultCallBack
{
    [super taskResultCallBack];
    if(!self.bCanceled)
    {
        
    }
}

@end
