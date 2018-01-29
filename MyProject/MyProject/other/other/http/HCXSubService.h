//
//  HCXSubService.h
//  EatEquity
//
//  Created by liyunqi on 03/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>
#import "XSubService.h"
@interface HCXSubService : XSubService
-(void)loadGetRongToken:(NSString  *)userID nickName:(NSString *)nickName avatar:(NSString *)aratar ClassName:(Class) className  responseblock:(SYResponseBlock) responseblock;

/*--------------------------------- 个人中心 ----------------------------*/


/**
 我的权益列表

 @param status 类型：1-已使用权益   -1-已过期权益
 @param lastId 默认为0，当前列表最后一条数据Id
 @param className className description
 @param responseblock responseblock description
 */
- (void)loadMyEquityWithStatus:(NSInteger)status lastId:(NSInteger)lastId ClassName:(Class)className responseblock:(SYResponseBlock)responseblock withController:(UIViewController *)controller;

/**
 个人资料修改接口 /user/edit/phone

 @param imageStr 图片data
 @param nickName 昵称
 @param sex 性别 1男 2女 3未知
 @param className 类名
 @param responseblock 回调

 */
- (void)loadAmendUserInfoRequestWithImage:(NSString *)imageStr nickName:(NSString *)nickName sex:(NSInteger)sex ClassName:(Class)className responseblock:(SYResponseBlock)responseblock;

/**
 修改手机号接口

 @param phone 手机号
 @param vcode 验证码 
 @param password 密码
 @param className className description
 @param responseblock responseblock description
 */
- (void)loadAmendUserPhoneRequestWithPhone:(NSString *)phone vcode:(NSString *)vcode password:(NSString *)password ClassName:(Class)className responseblock:(SYResponseBlock)responseblock;


/*--------------------------------- 登录注册 ----------------------------*/
/**
 发送验证码接口

 @param phone 手机号
 @param type 验证码类型：1登录 2重置密码 3更改绑定手机
 @param className className description
 @param responseblock responseblock description
 */
- (void)loadSendSMSCodeRequestPhone:(NSString *)phone type:(NSInteger)type ClassName:(Class)className responseblock:(SYResponseBlock)responseblock;


/**
 密码登录

 @param phone 手机号或者卡号
 @param psw 密码
 @param className className description
 @param responseblock responseblock description
 */
- (void)loadPasswordLoginRequestPhone:(NSString *)phone pwd:(NSString *)psw ClassName:(Class)className responseblock:(SYResponseBlock)responseblock;

/**
 验证码登录

 @param phone 手机号
 @param code 验证码
 @param className className description
 @param responseblock responseblock description
 */
- (void)loadCodeLoginRequestPhone:(NSString *)phone code:(NSString *)code ClassName:(Class)className responseblock:(SYResponseBlock)responseblock;

/**
 找回密码

 @param phone 手机号
 @param pwd 密码
 @param code 验证码
 @param className className description
 @param responseblock responseblock description
 */
- (void)loadFindPasswordRequset:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code ClassName:(Class)className responseblock:(SYResponseBlock)responseblock;

/*--------------------------------- 权益接口 ----------------------------*/

/**
 权益列表接口 

 @param cityCode 城市编码
 @param lastId 最后一条的ID
 @param type  权益类型：1-硬菜当道   2-到店打折
 @param className className description
 @param responseblock responseblock description
 */
- (void)loadEquityListRequsetWithCity:(NSString *)cityCode lastId:(NSString *)lastId Sequence:(NSInteger)sequence type:(NSString *)type ClassName:(Class)className responseblock:(SYResponseBlock)responseblock controller:(UIViewController *)controller;


/**
 权益详情接口

 @param ID 权益ID
 @param className className description
 @param responseblock responseblock description
 */
- (void)loadEquityDetailsRequsetWithID:(NSInteger)ID longitude:(double)longitude latitude:(double)latitude ClassName:(Class)className responseblock:(SYResponseBlock)responseblock controller:(UIViewController *)controller;


/**
 登出
 
 */
- (void)loadLogoutClassName:(Class)className responseblock:(SYResponseBlock)responseblock;

/**
 吃啥列表
 */
- (void)loadRecommend_daily_list:(NSInteger)offset number:(NSInteger)num ClassName:(Class)className responseblock:(SYResponseBlock)responseblock controller:(UIViewController *)controller;

/**
 设备上报
 */
- (void)loadDeviceRptClassName:(Class)className responseblock:(SYResponseBlock)responseblock;

//closepush
- (void)loadClosepush:(NSString *)open className:(Class)className responseblock:(SYResponseBlock)responseblock;


/**
 检查更新

 @param className className description
 @param responseblock responseblock description
 */
- (void)loadAppCheckclassName:(Class)className responseblock:(SYResponseBlock)responseblock;

/**
deviceToken上报
 */
- (void)loadDeviceToken:(NSString *)token className:(Class)className responseblock:(SYResponseBlock)responseblock;



/**
 配置接口
 */
- (void)loadAppConfigclassName:(Class)className configid:(NSString *)configID responseblock:(SYResponseBlock)responseblock;



- (void)loadAppRegisterSwitchClassName:(Class)className  responseblock:(SYResponseBlock)responseblock;
@end
