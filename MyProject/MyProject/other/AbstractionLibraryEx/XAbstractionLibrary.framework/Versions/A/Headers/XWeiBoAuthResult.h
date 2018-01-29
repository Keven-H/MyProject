//
//  XWeiBoAuthResult.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XWeiBoResult.h"

/**
 *  微博授权请求对象
 */
@interface XWeiBoAuthResult : XWeiBoResult

/**
 *  用户ID
 */
@property (nonatomic,strong) NSString *sinaUserID;

/**
 *  认证口令
 */
@property (nonatomic,strong) NSString *accessToken;

/**
 *  当认证口令过期时用于换取认证口令的更新口令
 */
@property (nonatomic,strong) NSString *refreshToken;

/**
 *  认证过期时间
 */
@property (nonatomic,strong) NSDate *expirationData;

@end
