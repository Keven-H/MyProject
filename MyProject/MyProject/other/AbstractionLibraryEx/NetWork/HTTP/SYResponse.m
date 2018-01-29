//
//  SYResponse.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYResponse.h"

@implementation SYResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSMutableDictionary *keys = [NSMutableDictionary dictionaryWithDictionary:[super JSONKeyPathsByPropertyKey]];
    keys[@"command"] = @"command";
    keys[@"toVersion"] = @"newVersion";
    keys[@"updateUrl"] = @"updateUrl";
    keys[@"responseMsg"]=@"desc";
    keys[@"code"]=@"code";
    return keys;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _code=-1;
    }
    return self;
}
-(NSInteger)errorCode
{
    return _code;
}
-(BOOL)isSuccess
{
    if (_code==0) {
        return YES;
    }
    return NO;
}
- (BOOL) isTokenTimeOut
{
    BOOL timeOut = NO;
    if(self.errorCode == 9999)
        timeOut = YES;
    return timeOut;
}

- (BOOL) isShutdownACount
{
    BOOL bShutdown = NO;
    if(self.errorCode == 2015)
        bShutdown = YES;
    return bShutdown;
}

- (BOOL) isForceUpdate
{
    BOOL bForceUpdate = NO;
    if(self.errorCode == 10)
        bForceUpdate = YES;
    return bForceUpdate;
}

- (BOOL) isWeChatAuthTimeOut
{
    BOOL bWeChatAuthTimeOut = NO;
    if(self.errorCode == 601)
        bWeChatAuthTimeOut = YES;
    return bWeChatAuthTimeOut;
}
-(BOOL)isQQAuthTimeOut
{
    if (self.errorCode==901) {
        return YES;
    }
    return NO;
}
-(BOOL)isSineAuthTimeOut
{
    if (self.errorCode==1001) {
        return YES;
    }
    return NO;
}


- (NSString *) responseMsg
{
    NSString *errorMsg =_responseMsg;
    if ([self isNetWorkFail]) {
        errorMsg=@"网络无法连接，请稍后重试";
    }
    if ([self isTimeOut]) {
        errorMsg=@"数据加载失败，请稍后重试";
    }
    if (self.errorCode==2008) {
        errorMsg=@"您还不是会吃侠会员，请前往注册";

    }
    
    return errorMsg;
}

+ (instancetype) success
{
    SYResponse *succ=[super success];
    succ.code=0;
    return succ;
}
+ (instancetype) otherGeneralFail
{
    SYResponse *succ=[super success];
    succ.code=-1;
    return succ;
}

@end
