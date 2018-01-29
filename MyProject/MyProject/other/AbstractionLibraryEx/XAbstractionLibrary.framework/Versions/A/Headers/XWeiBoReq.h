//
//  XWeiBoReq.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XWeiBoCommon.h"

@class WBBaseRequest;

@interface XWeiBoReq : XData

/**
 *  验证分享的数据合法性
 *
 *  @return YES合法  NO不合法
 */
- (BOOL) invalidaData:(void(^)(XWeiBoResult *result)) block;

/**
 *  将自身的分享结构数据映射回微信请求对象
 *
 *  @return 返回微信请求对象
 */
- (WBBaseRequest *) messageObj;
@end
