//
//  SYResponse.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  小黄圈借口返回数据基础对象
 */
@interface SYResponse : XResponse

/**
 *  接口名
 */
@property (nonatomic,strong) NSString *command;

/**
 *  更新到的新版本号
 */
@property (nonatomic,strong) NSString *toVersion;

/**
 *  更新新版本的url
 */
@property (nonatomic,strong) NSString *updateUrl;

/**
 *  服务器提示语句
 */

@property (nonatomic,strong) NSString *responseMsg;

PROPERTY_ASSIGN NSInteger code;



/**
 *  是否token过期
 *
 *  @return YES过期 否则没过期
 */
- (BOOL) isTokenTimeOut;

/**
 *  判断该账户是否冻结
 *
 *  @return YES 冻结 否则正常使用
 */
- (BOOL) isShutdownACount;

/**
 *  判断该app是否需要强制更新
 *
 *  @return YES 需要强制更新 否则不需要
 */
- (BOOL) isForceUpdate;

/**
 *  判断微信授权过期错误
 */
- (BOOL) isWeChatAuthTimeOut;

/**
 *  判断qq授权过期错误
 */
-(BOOL)isQQAuthTimeOut;

/**
 *  判断sine授权过期错误
 */
-(BOOL)isSineAuthTimeOut;
@end
