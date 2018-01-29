//
//  XRouterManager.m
//  EatEquity
//
//  Created by liyunqi on 09/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "XRouterManager.h"

@implementation XRouterManager

+ (instancetype) shareManager
{
    static dispatch_once_t onceToken;
    static HCXRouterManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[HCXRouterManager alloc]init];
    });
    return manager;
}
-(void)startRegister
{
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.prefix=@"hcx://";
    }
    return self;
}
+(void)load
{
    [super load];
    [[XRouterManager shareManager]startRegister];
}
-(BOOL)CanOpen:(NSString *)url
{
    if ([url.lowercaseString hasPrefix:self.prefix]) {
        return YES;
    }
    return NO;
}
-(void)openUrl:(NSString *)url
{
    if ([url hasPrefix:self.prefix]) {
        [YQRouter openURL:url];
    }else
    {
        [YQRouter openURL:[NSString stringWithFormat:@"%@%@",self.prefix,url]];
    }
    
}
-(void)registerURLPattern:(NSString *)URLPattern toHandler:(YQRouterHandler)handler
{
    NSString *url=[NSString stringWithFormat:@"%@%@",self.prefix,URLPattern];
    [YQRouter registerURLPattern:url toHandler:handler];
}
@end
