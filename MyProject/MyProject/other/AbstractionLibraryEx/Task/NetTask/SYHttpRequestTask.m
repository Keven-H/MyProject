//
//  SYHttpRequestTask.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/26.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYHttpRequestTask.h"
#import "SYHttpRequestManager.h"
#import "SYHttpsRequestManager.h"

@interface SYHttpRequestTask ()
@property (nonatomic,strong) SYResponse* response;
@property (nonatomic,strong) NSDictionary *responseDic;
@property (nonatomic,strong) id<XHttpRequestDelegate> request;
@end

@implementation SYHttpRequestTask

+ (instancetype) createHttpRequestTaskWithHttpSafe:(HttpSafeType) httpSafe
                                          httpType:(HttpType) httpType
                                     requestParams:(NSDictionary *) requestParams
                                          delegate:(id<XTaskDelegate>) delegate
                                         className:(Class) className
                                     responseblock:(SYTaskResponseBlock) responseblock
{
    SYHttpRequestTask *httpTask = [[SYHttpRequestTask alloc] init];
    httpTask.command = [requestParams objectForKey:@"command"];
    httpTask.httpType = httpType;
    httpTask.httpSafeType = httpSafe;
    httpTask.requestParam = requestParams;
    httpTask.delegate = delegate;
    httpTask.className = className;
    httpTask.taskResponseBlock = [responseblock copy];
    [httpTask.delegate willAddTask:httpTask];
    return httpTask;
}

+ (instancetype) createHttpRequestTaskWithHttpSafe:(HttpSafeType) httpSafe
                                     requestParams:(NSDictionary *) requestParams
                                          delegate:(id<XTaskDelegate>) delegate
                                         className:(Class) className
                                     responseblock:(SYTaskResponseBlock) responseblock
{
    return [self createHttpRequestTaskWithHttpSafe:httpSafe
                                          httpType:HttpType_None
                                     requestParams:requestParams
                                          delegate:delegate
                                         className:className
                                     responseblock:responseblock];
}

+ (instancetype) createHttpRequestTaskWithHttpType:(HttpType) httpType
                                     requestParams:(NSDictionary *) requestParams
                                          delegate:(id<XTaskDelegate>) delegate
                                         className:(Class) className
                                     responseblock:(SYTaskResponseBlock) responseblock
{
    return [self createHttpRequestTaskWithHttpSafe:HttpSafeType_None
                                     requestParams:requestParams
                                          delegate:delegate
                                         className:className
                                     responseblock:responseblock];
}

+ (instancetype) createHttpRequestTaskWithRequestParams:(NSDictionary *) requestParams
                                               delegate:(id<XTaskDelegate>) delegate
                                              className:(Class) className
                                          responseblock:(SYTaskResponseBlock) responseblock
{
    return [self createHttpRequestTaskWithHttpSafe:HttpSafeType_None
                                          httpType:HttpType_None
                                     requestParams:requestParams
                                          delegate:delegate
                                         className:className
                                     responseblock:responseblock];
}

- (void) taskExecutorEnd
{
    sleep(0.2f);
    [super taskExecutorEnd];
}

- (void) taskExecutor
{
    if(![super isValidataTask])
        return;
    
    if(self.bCanceled)
        return;
    
    __weak typeof(self) weakSelf = self;
    if(self.httpSafeType == HttpSafeType_Http)
    {
        if(self.httpType == HttpType_Get)
        {
            [[SYHttpRequestManager shareHttpRequestManager] getRequestWithRequestParams:self.requestParam
                                                                         httpDelegate:self
                                                                            className:self.className
                                                                        responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
                                                                            weakSelf.request = request;
                                                                            weakSelf.response = response;
                                                                            weakSelf.responseDic = responseDic;
                                                                            [weakSelf taskExecutorEnd];
                                                                        }];
        }
        else if(self.httpType == HttpType_Post)
        {
            [[SYHttpRequestManager shareHttpRequestManager] postRequestWithRequestParams:self.requestParam
                                                                       httpDelegate:self
                                                                          className:self.className
                                                                      responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
                                                                          weakSelf.request = request;
                                                                          weakSelf.response = response;
                                                                          weakSelf.responseDic = responseDic;
                                                                          [weakSelf taskExecutorEnd];
                                                                      }];
        }
    }
    else if(self.httpSafeType == HttpSafeType_Https)
    {
        if(self.httpType == HttpType_Get)
        {
            [[SYHttpsRequestManager shareHttpsRequestManager] getRequestWithRequestParams:self.requestParam
                                                                           httpDelegate:self
                                                                              className:self.className
                                                                          responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
                                                                              weakSelf.request = request;
                                                                              weakSelf.response = response;
                                                                              weakSelf.responseDic = responseDic;
                                                                              [weakSelf taskExecutorEnd];
                                                                          }];
        }
        else if(self.httpType == HttpType_Post)
        {
            [[SYHttpsRequestManager shareHttpsRequestManager] postRequestWithRequestParams:self.requestParam
                                                                         httpDelegate:self
                                                                            className:self.className
                                                                        responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
                                                                            weakSelf.request = request;
                                                                            weakSelf.response = response;
                                                                            weakSelf.responseDic = responseDic;
                                                                            [weakSelf taskExecutorEnd];
                                                                        }];
        }
    }
    [super taskExecutor];
}

- (void) taskResultCallBack
{
    [super taskResultCallBack];
    if(self.taskResponseBlock)
        self.taskResponseBlock(self,_response,_responseDic);
}

@end
