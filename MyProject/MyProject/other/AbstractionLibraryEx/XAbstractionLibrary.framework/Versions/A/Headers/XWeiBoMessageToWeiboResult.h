//
//  XWeiBoMessageToWeiboResult.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/19.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XWeiBoAuthResult.h"

/**
 *  微博请求回调对象 除了认证请求以外
 */
@interface XWeiBoMessageToWeiboResult : XWeiBoResult

/**
 *  请求过程中可能存在的认证对象
 */
@property (nonatomic,strong) XWeiBoAuthResult *authResult;

@end
