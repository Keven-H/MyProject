//
//  XRouterManager.h
//  EatEquity
//
//  Created by liyunqi on 09/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>
#import "YQRouter.h"
@interface XRouterManager : XData
PROPERTY_STRONG NSString *prefix;
+ (instancetype) shareManager;
-(BOOL)CanOpen:(NSString *)url;
-(void)openUrl:(NSString *)url;
-(void)registerURLPattern:(NSString *)URLPattern toHandler:(YQRouterHandler)handler;
-(void)startRegister;
@end
