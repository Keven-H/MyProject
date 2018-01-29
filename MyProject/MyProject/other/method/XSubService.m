//
//  XSubService.m
//  EatEquity
//
//  Created by liyunqi on 20/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "XSubService.h"
#import "XEmptyViewManager.h"
@interface XSubService()<XHttpResponseDelegate>
{
    
}
PROPERTY_STRONG NSMutableDictionary* requestDic;
@end
@implementation XSubService
+(instancetype)share
{
    static dispatch_once_t onceToken;
    static XSubService *httpManager=nil;
    dispatch_once(&onceToken, ^{
        httpManager=[[self alloc]init];
    });
    return httpManager;
}


-(void) pushResponse:(NSDictionary *)dic className:(Class) className controller:(UIViewController *)controller responseblock:(SYResponseBlock) responseblock
{
    [[XEmptyViewManager share]postRequestWithRequestParams:dic controller:controller className:className responseblock:responseblock];
    FNWeak(controller, weakController);
        id<XHttpRequestDelegate>respon= [[SYHttpRequestManager shareHttpRequestManager] postRequestWithRequestParams:dic httpDelegate:self className:className responseblock:^(id<XHttpRequestDelegate> request, SYResponse *response, id responseDic) {
        //responseDic==nil  默认主动cancel response
        //        if (responseDic!=nil) {
       [[XEmptyViewManager share]resultRequest:weakController response:response];
        if (responseblock) {
            responseblock(request,response,responseDic );
        }
         
            
            
            
        
        //        }
    }];
    if (controller) {
        
    }else
    {
        [self.requestDic setObject:respon forKey:respon.command];
    }
    
}
-(void) pushResponse:(NSDictionary *)dic className:(Class) className responseblock:(SYResponseBlock) responseblock
{
    [self pushResponse:dic className:className controller:nil responseblock:responseblock];
}
- (void) willStartRequest:(id<XHttpRequestDelegate>) request
{
    
}
- (void) completeDidRequest:(id<XHttpRequestDelegate>) request
                responseDic:(id) responseDic
                      error:(NSError *) error
{
    [self removeKey:request.command];
}
-(void)removeKey:(NSString *)command
{
    [self.requestDic removeObjectForKey:command];
}
- (BOOL)cancelKey:(NSString*)key
{
    id<XHttpRequestDelegate>request = self.requestDic[key];
    if (request) {
        [self removeKey:key];
        [request cancel];
        request = nil;
        return YES;
    }
    return NO;
}
@end
