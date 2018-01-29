//
//  SYDefaultBaseTask.m
//  Foodie
//
//  Created by liyunqi on 07/12/2017.
//  Copyright © 2017 SY. All rights reserved.
//

#import "SYDefaultBaseTask.h"
#import "SYFeedBackModel.h"
#import "SYLock.h"
@interface SYDefaultBaseTask()
{
    
}
@property (nonatomic,assign) BOOL bFail;

/**
 *  原子锁对象
 */
@property (nonatomic,strong) XCondition *taskCondition;

/**
 *  问题反馈model
 */
@property (nonatomic,strong) SYFeedBackModel *feedBackModel;

/**
 *  任务执行完成回调
 */
@property (nonatomic,copy) completeBlock block;

/**
 *  回调结果
 */
@property (nonatomic,strong) SYResponse *response;
PROPERTY_STRONG id responseDic;
PROPERTY_ASSIGN Class modelcalss;
@end
@implementation SYDefaultBaseTask

+ (instancetype) createFeedBackTask:(completeBlock) completeBlock modelClass:(Class)modelcalss
{
    SYDefaultBaseTask *feedBackTask = [[self alloc] init];
    feedBackTask.modelcalss=modelcalss;
    [feedBackTask initDefault];
    feedBackTask.block = [completeBlock copy];
    return feedBackTask;
}


-(void)initDefault
{
   
    if ([self.modelcalss isSubclassOfClass:[SYFeedBackModel class]]) {
        self.feedBackModel=[[self.modelcalss alloc]init];
    }else
    {
        self.feedBackModel = [[SYFeedBackModel alloc] init];
    }
    self.feedBackModel.ID = self.ID;
}
- (instancetype)init
{
    if(self = [super init])
    {
        self.command = @"/food/publishFoodData.do";
        self.className = [SYResponse class];
        self.taskCondition = [[XCondition alloc] init];
    }
    return self;
}

- (void) uploadAssetFail
{
    self.bFail = YES;
    [self.taskCondition writeDataWithLockBlock:nil];
}
-(NSMutableDictionary *)parDic
{
    return [NSMutableDictionary new];
}
- (void) uploadAssetComplete
{
    if([[self getFeedBackModel] isAllUploadImageContentModelComplete])
    {
        [self.taskCondition writeDataWithLockBlock:nil];
    }
}

- (void) startAllUploadAssets
{
    self.bFail = NO;
    for(SYBaseImageAsset *imageAsset in [[self getFeedBackModel] allImageContent])
    {
        [imageAsset startUploadFile];
    }
}

- (SYFeedBackModel *) getFeedBackModel
{
    return _feedBackModel;
}

- (void) taskExecutor
{
    if(![super isValidataTask])
        return;
    
    if(self.bCanceled)
        return;
    
//    [[[SYDataManager shareDataManager]imageQueue ]waitUntilAllOperationsAreFinished];
    [self startAllUploadAssets];
    
    __weak typeof(self) weakSelf = self;
    [self.taskCondition readDataWithLockStateLock:^NSUInteger{
        return [[weakSelf getFeedBackModel] isAllUploadImageContentModelComplete] ? 1 : 0;
    }
                                    WithLockBlock:^{
                                        if(weakSelf.bCanceled)
                                        {
                                            weakSelf.taskExecutState = XTaskExecutStateFail;
                                            return ;
                                        }
                                        else
                                        {
                                            if(weakSelf.bFail)
                                            {
                                                weakSelf.taskExecutState = XTaskExecutStateFail;
                                                return;
                                            }
                                            else
                                            {
                                                NSMutableDictionary *dic =[self parDic];
                                                [[SYHttpRequestManager shareHttpRequestManager] postRequestWithRequestParams:dic httpDelegate:nil className:[SYResponse class] responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
                                                    weakSelf.response = response;
                                                    weakSelf.responseDic=responseDic;
                                                    [weakSelf taskExecutorEnd];
                                                }];
                                                [super taskExecutor];
//                                                [[SYDataManager shareDataManager] removeAssetImageWithID:weakSelf.ID];
                                            }
                                        }
                                    }];
}

- (void) taskExecutorEnd
{
    sleep(0.2f);
    [super taskExecutorEnd];
}

- (void) taskResultCallBack
{
    [super taskResultCallBack];
    
    if([self.response isSuccess])
    {
        self.taskExecutState = XTaskExecutStateComplete;
    }
    else
    {
        self.taskExecutState = XTaskExecutStateFail;
    }
    
    if(self.block)
        self.block(self.response,self.responseDic);
}



@end
