//
//  SYBaseHttpRequestManager.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/17.
//  Copyright © 2015年 兰彪. All rights reserved.
//


#import "SYBaseHttpRequestManager.h"
#import "SYResolveResponse.h"

#define         APPKEY          @""

@implementation SYBaseHttpRequestManager
- (NSString *) getRequestSignWithParams:(NSDictionary *) params
{
    NSMutableString *appendParam = nil;
    NSArray *keys = [params.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        if(!appendParam)
            appendParam = [[NSMutableString alloc] init];
        //        [appendParam appendFormat:@"%@=%@",key,[params objectForKey:key]];
        [appendParam appendFormat:@"%@=%@%@",key , [params objectForKey:key],[key isEqualToString:keys.lastObject]?@"":@"&"];
    }
    [appendParam appendString:APPKEY];
    
    NSString *encodeParam = appendParam;
    
    NSString *sign = [XMD5Digest md5:encodeParam];
    
    return sign;
}

- (NSDictionary *) addDefaultParam:(NSDictionary *) param
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    //NSString *sign = [self getRequestSignWithParams:param];
    if([[HCXDateManager shareDataManager] accountIsLogin])
    {
        DICT_PUT(params, @"account", [HCXAccountManager account].user.ID);
        DICT_PUT(params, @"token", [HCXAccountManager account].token);
    }
    DICT_PUT(params, @"source", @"1");
    DICT_PUT(params, @"channel", @"999");

    DICT_PUT(params, @"clientId", [SYClientInfo clientID]);
//    DICT_PUT(params, @"visitorAccount", [SYAccountManager clientAccount].user.ID);
    NSString *version = [SYClientInfo appVersion];
    NSArray *versionCompoments = [version componentsSeparatedByString:@"."];
    if([versionCompoments count] >= 4)
    {
        version = [NSString stringWithFormat:@"%@.%@.%@",[versionCompoments objectAtIndex:0],[versionCompoments objectAtIndex:1],[versionCompoments objectAtIndex:2]];
    }
    DICT_PUT(params, @"version", version);
    DICT_PUT(params, @"osVersion", [SYClientInfo osVersion]);
    DICT_PUT(params, @"device", [SYClientInfo machineModel]);
    DICT_PUT(params, @"pageId", [[HCXDateManager shareDataManager]controllerPageID]);
    return params;
}
- (id<XHttpRequestDelegate>) getRequestWithUrlString:(NSString *) requestUrlString
                                       requestParams:(NSDictionary *) requestParams
                                        httpDelegate:(id<XHttpResponseDelegate>) delegate
                                       responseblock:(XResponseBlock) responseblock
                                                type:(NSInteger)type
{
    if (type==0) {
        return  [self getRequestWithUrlString:requestUrlString
                                requestParams:requestParams
                                 httpDelegate:delegate
                                responseblock:responseblock];
        
    }
    if (type==1) {
        return  [self postRequestWithUrlString:requestUrlString
                                    postParams:requestParams
                                  httpDelegate:delegate
                                 responseblock:responseblock];
    }
    return nil;
}
- (void) requestCallBackWithRequestType:(NSInteger) type
                          requestParams:(NSDictionary *) requestParams
                               delegate:(id<XHttpResponseDelegate>) delegate
                                request:(id<XHttpRequestDelegate>) request
                              className:(Class) className
                            responseObj:(id) responseObj
                                  error:(NSError *) error
                          responseBlock:(SYResponseBlock) responseBlock{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        SYResponse *response = [SYResolveResponse resolveWithClass:className
                                                       responseObj:responseObj
                                                             error:error];
        response.command = request.command;
        if([response isSuccess])
        {
            
        }
        else
        {
            if([response isNetWorkFail])
            {
                
            }
            else if([response isTimeOut])
            {
                
            }
            else if([response isServerBad])
            {
                
            }
            else if([response isTokenTimeOut])
            {
                [[SYMessageBoxManager shareMessageBoxManager] showDialog:MessageBoxType_TokenTimeOut tipText:nil];
            }
            else if([response isShutdownACount])
            {
                [[SYMessageBoxManager shareMessageBoxManager] showDialog:MessageBoxType_AcountShutDown tipText:[response responseMsg]];
            }
            else if([response isForceUpdate])
            {
            }else if([response isSineAuthTimeOut])
            {
              
            }
            else if([response isQQAuthTimeOut])
            {
            }
            else if([response isWeChatAuthTimeOut])
            {
               
            }
            else if([response isOtherGeneralFail])
            {

            }
            else
            {

            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(responseBlock)
                responseBlock(request,response,responseObj);
        });
    });
}


- (NSString *) getRequestUrlWithCommand:(NSString *) command
{
    NSString *requestPath = [NSString stringWithFormat:@"%@",command];
    NSString *requestUrl = [[NSURL URLWithString:requestPath relativeToURL:[NSURL URLWithString:self.httpHostAddress]] absoluteString];
    return requestUrl;
}

- (id<XHttpRequestDelegate>) getRequestWithRequestParams:(NSDictionary *) requestParams
                                            httpDelegate:(id<XHttpResponseDelegate>) delegate
                                               className:(Class) className
                                           responseblock:(SYResponseBlock) responseblock
{
    __weak typeof(self) weakSelf = self;
    NSString *command = [requestParams objectForKey:@"command"];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    
    NSString *urlString = [self getRequestUrlWithCommand:command];
    id<XHttpRequestDelegate> request = [self getRequestWithUrlString:urlString
                                                       requestParams:paramsDic
                                                        httpDelegate:delegate
                                                       responseblock:^(id<XHttpRequestDelegate> httpRequest, id responseObj, NSError *error) {
                                                           [weakSelf requestCallBackWithRequestType:0
                                                                                      requestParams:requestParams
                                                                                           delegate:delegate
                                                                                            request:httpRequest
                                                                                          className:className
                                                                                        responseObj:responseObj
                                                                                              error:error
                                                                                      responseBlock:responseblock];
                                                       }];
    return request;
}

- (id<XHttpRequestDelegate>) postRequestWithRequestParams:(NSDictionary *) postParams
                                             httpDelegate:(id<XHttpResponseDelegate>) delegate
                                                className:(Class) className
                                            responseblock:(SYResponseBlock) responseblock
{
    __weak typeof(self) weakSelf = self;
    NSString *command = [postParams objectForKey:@"command"];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:postParams];
    NSString *urlString = [self getRequestUrlWithCommand:command];
    id<XHttpRequestDelegate> request = [self postRequestWithUrlString:urlString
                                                           postParams:paramsDic
                                                         httpDelegate:delegate
                                                        responseblock:^(id<XHttpRequestDelegate> httpRequest, id responseObj, NSError *error) {

                                                            [weakSelf requestCallBackWithRequestType:1
                                                                                       requestParams:postParams
                                                                                            delegate:delegate
                                                                                             request:httpRequest
                                                                                           className:className
                                                                                         responseObj:responseObj
                                                                                               error:error
                                                                                       responseBlock:responseblock];
                                                        }];
    return request;
}

- (id<XHttpRequestDelegate>) uploadRequesrWithRequestParam:(NSDictionary *)uploadParams
                                                  filePath:(NSString *)filePath
                                              httpDelegate:(id<XHttpResponseDelegate>)delegate
                                                 className:(Class)className
                                             responseblock:(SYResponseBlock)responseblock
{
    __weak typeof(self) weakSelf = self;
    NSString *command = [uploadParams objectForKey:@"command"];
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:uploadParams];
    NSString *urlString = [self getRequestUrlWithCommand:command];
    id<XHttpRequestDelegate> request = [self uploadRequestWithUrlString:urlString
                                                             parameters:[self addDefaultParam:paramsDic]
                                                         uploadFilePath:filePath
                                                           httpDelegate:delegate
                                                          responseblock:^(id<XHttpRequestDelegate> httpRequest, id responseObj, NSError *error) {
                                                              [weakSelf requestCallBackWithRequestType:2
                                                                                         requestParams:uploadParams
                                                                                              delegate:delegate
                                                                                               request:httpRequest
                                                                                             className:className
                                                                                           responseObj:responseObj
                                                                                                 error:error
                                                                                         responseBlock:responseblock];
                                                          }];
    return request;
}
-(NSDictionary *)getPublicParamsWithDic:(NSDictionary *)paramsDic
{
    NSDictionary *pubdic=[self addDefaultParam:[NSMutableDictionary new]];
////    NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]initWithDictionary:paramsDic];
////    [tempDic setObject:[pubdic objectForKey:@"clientID"] forKey:@"clientID"];
////    NSString *paramSort=[self getRequestSignWithParams:tempDic];
////    NSMutableDictionary *publicParams=[[NSMutableDictionary alloc]initWithDictionary:pubdic];
////    DICT_PUT(publicParams, @"sign", paramSort);
    return pubdic;
}
//重写request
-(id<XHttpRequestDelegate>)postRequestWithUrlString:(NSString *)postUrlString postParams:(NSDictionary *)postParams httpDelegate:(id<XHttpResponseDelegate>)delegate responseblock:(XResponseBlock)responseblock
{

    NSLog(@"postUrlString:%@",postUrlString);
    NSDictionary *Public=[self getPublicParamsWithDic:nil];
    return [super postRequestWithUrlString:postUrlString postParams:postParams  publicParams:Public httpDelegate:delegate responseblock:responseblock];
//        return [super postRequestWithUrlString:postUrlString postParams:[self addDefaultParam:postParams] httpDelegate:delegate responseblock:responseblock];
}
-(id<XHttpRequestDelegate>)getRequestWithUrlString:(NSString *)requestUrlString requestParams:(NSDictionary *)requestParams httpDelegate:(id<XHttpResponseDelegate>)delegate responseblock:(XResponseBlock)responseblock
{
    NSLog(@"requestUrlString:%@",requestUrlString);
    NSDictionary *Public=[self getPublicParamsWithDic:requestParams];
    return [super getRequestWithUrlString:requestUrlString requestParams:requestParams publicParams:Public httpDelegate:delegate responseblock:responseblock];
//        return [super getRequestWithUrlString:requestUrlString requestParams: [self addDefaultParam:requestParams] httpDelegate:delegate responseblock:responseblock];
}
@end
