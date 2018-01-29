//
//  HCXSubService.m
//  EatEquity
//
//  Created by liyunqi on 03/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import "HCXSubService.h"
#import <AFNetworking.h>
@interface HCXSubService()<XHttpResponseDelegate>
{
    
}

@end
@implementation HCXSubService

-(void)loadGetRongToken:(NSString  *)userID nickName:(NSString *)nickName avatar:(NSString *)aratar ClassName:(Class) className  responseblock:(SYResponseBlock) responseblock
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    DICT_PUT(dic, @"userId", userID);
    DICT_PUT(dic, @"name", nickName);
    DICT_PUT(dic, @"portraitUri", aratar);
    [self pushResponse:dic className:className responseblock:responseblock];
}

- (void)loadAmendUserInfoRequestWithImage:(NSString *)imageStr nickName:(NSString *)nickName sex:(NSInteger)sex ClassName:(Class)className responseblock:(SYResponseBlock)responseblock{

    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];

    NSString *command = @"/user/edit/info";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"nickname", nickName);
    DICT_PUT(dic, @"headImg", imageStr);
    DICT_PUT(dic, @"sex", [NSNumber numberWithInteger:sex]);
    [self pushResponse:dic className:className responseblock:responseblock];
}

- (void)loadAmendUserPhoneRequestWithPhone:(NSString *)phone vcode:(NSString *)vcode password:(NSString *)password ClassName:(Class)className responseblock:(SYResponseBlock)responseblock{

    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];

    NSString *command = @"/user/edit/phone";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"phone", phone);
    DICT_PUT(dic, @"vcode", vcode);
    DICT_PUT(dic, @"password", password);
    [self pushResponse:dic className:className responseblock:responseblock];
}

- (void) loadSendSMSCodeRequestPhone:(NSString *)phone type:(NSInteger)type ClassName:(Class)className responseblock:(SYResponseBlock)responseblock{

    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"/validatecode/send";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"phone", phone);
    DICT_PUT(dic, @"type", [NSNumber numberWithInteger:type]);
    [self pushResponse:dic className:className responseblock:responseblock];

}
- (void)loadPasswordLoginRequestPhone:(NSString *)phone pwd:(NSString *)psw ClassName:(Class)className responseblock:(SYResponseBlock)responseblock{

    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"/login/pwd";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"loginName", phone);
    DICT_PUT(dic, @"password", psw);
    [self pushResponse:dic className:className responseblock:responseblock];
}
- (void)loadCodeLoginRequestPhone:(NSString *)phone code:(NSString *)code ClassName:(Class)className responseblock:(SYResponseBlock)responseblock{

    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];

    NSString *command = @"/login/vcode";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"phone", phone);
    DICT_PUT(dic, @"vcode", code);
    [self pushResponse:dic className:className responseblock:responseblock];
}
- (void)loadFindPasswordRequset:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code ClassName:(Class)className responseblock:(SYResponseBlock)responseblock{

    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];

    NSString *command = @"/user/reset";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"phone", phone);
    DICT_PUT(dic, @"password", pwd);
    DICT_PUT(dic, @"vcode", code);
    [self pushResponse:dic className:className responseblock:responseblock];
}
- (void)loadEquityListRequsetWithCity:(NSString *)cityCode lastId:(NSString *)lastId Sequence:(NSInteger)sequence type:(NSString *)type ClassName:(Class)className responseblock:(SYResponseBlock)responseblock controller:(UIViewController *)controller{

    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];

    NSString *command = @"/shop/benefit/list";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"cityCode", cityCode);
    DICT_PUT(dic, @"sequence", [NSNumber numberWithInteger:sequence]);
    DICT_PUT(dic, @"lastId", lastId);
    DICT_PUT(dic, @"type", type);
    [self pushResponse:dic className:className controller:controller responseblock:responseblock];
}

- (void)loadEquityDetailsRequsetWithID:(NSInteger)ID longitude:(double)longitude latitude:(double)latitude ClassName:(Class)className responseblock:(SYResponseBlock)responseblock controller:(UIViewController *)controller{

    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];

    NSString *command = @"/shop/benefit/detail";
    DICT_PUT(dic, @"command", command);
    if (longitude > 0) {
        DICT_PUT(dic, @"longitude", [NSNumber numberWithDouble:longitude]);
        DICT_PUT(dic, @"latitude", [NSNumber numberWithDouble:latitude]);
    }
    DICT_PUT(dic, @"id", [NSNumber numberWithInteger:ID]);
    [self pushResponse:dic className:className controller:controller responseblock:responseblock];
}
- (void)loadLogoutClassName:(Class)className responseblock:(SYResponseBlock)responseblock
{
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"login/logout";
    DICT_PUT(dic, @"command", command);
    [self pushResponse:dic className:className responseblock:responseblock];

}

- (void)loadRecommend_daily_list:(NSInteger)offset number:(NSInteger)num ClassName:(Class)className responseblock:(SYResponseBlock)responseblock controller:(UIViewController *)controller
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"recommend/recommend_daily_list";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"pageIndex", NSStringFromInt(offset));
    DICT_PUT(dic, @"pageSize", NSStringFromInt(num));
    [self pushResponse:dic className:className controller:controller responseblock:responseblock];
}
- (void)loadDeviceRptClassName:(Class)className responseblock:(SYResponseBlock)responseblock
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"app/device/rpt";
    DICT_PUT(dic, @"command", command);
    [self pushResponse:dic className:className responseblock:responseblock];
}

- (void)loadClosepush:(NSString *)open className:(Class)className responseblock:(SYResponseBlock)responseblock
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"app/device/push";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"isPush", open);
    [self pushResponse:dic className:className responseblock:responseblock];
}
- (void)loadAppCheckclassName:(Class)className responseblock:(SYResponseBlock)responseblock
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"app/upgrade/check";
    DICT_PUT(dic, @"command", command);
    [self pushResponse:dic className:className responseblock:responseblock];
}
- (void)loadDeviceToken:(NSString *)token className:(Class)className responseblock:(SYResponseBlock)responseblock
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"app/device/token";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"deviceToken", token);
    [self pushResponse:dic className:className responseblock:responseblock];
}

- (void)loadAppConfigclassName:(Class)className configid:(NSString *)configID responseblock:(SYResponseBlock)responseblock
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:@"app/config" forKey:@"command"];
    [dic setObject:configID forKey:@"id"];
    [self pushResponse:dic className:className responseblock:responseblock];
}

- (void)loadMyEquityWithStatus:(NSInteger)status lastId:(NSInteger)lastId ClassName:(Class)className responseblock:(SYResponseBlock)responseblock withController:(UIViewController *)controller
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSString *command = @"my/benefit/list";
    DICT_PUT(dic, @"command", command);
    DICT_PUT(dic, @"status", [NSNumber numberWithInteger:status]);
    DICT_PUT(dic, @"lastId", [NSNumber numberWithInteger:lastId]);
    [self pushResponse:dic className:className controller:controller responseblock:responseblock];
}

- (void)loadAppRegisterSwitchClassName:(Class)className  responseblock:(SYResponseBlock)responseblock
{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:@"app/reg/switch" forKey:@"command"];
    [self pushResponse:dic className:className responseblock:responseblock];
}
@end
