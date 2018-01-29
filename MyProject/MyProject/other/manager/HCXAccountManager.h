//
//  HCXAccountManager.h
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface HCXAccountManager : XData
/**
 *  小黄圈账户管理对象
 *
 *  @return 返回账户管理单例对象
 */
+ (HCXAccountManager *) shareAccountManager;

-(void)resetDefaultUser;

/**
 * 是否登陆
 */
+(BOOL)isLogin;

/**
 * 退出
 */
+(void)loginOut;


/**
 * 保存数据     clear 是否比对上次账号
 */
+(void)saveAccountWithModel:(HCXAccountUser *)loginUser shouldClear:(BOOL)clear;

/**
 *  根据user保存对象
 */
+(void)saveAccountWithUserModel:(HCXUser *)user;


/**
 * 账号 对外使用 可能是登录的账号 也可能是游客模式
 */
+(HCXAccountUser *)account;



/**
 * 账号的user 对外使用 可能是登录的账号 也可能是游客模式
 */
+(HCXUser *)currentUser;
+(void)write;


@end
