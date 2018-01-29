//
//  XWeChatAuth.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/30.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XWeChatReq.h"
#import "WXApiObject.h"

@interface XWeChatAuthReq : XWeChatReq

/**
 *  微信需要，一般all
 */
@property (nonatomic,strong) NSString *scope;

/**
 *  传给微信，回调也会传回来，可以用来校验
 */
@property (nonatomic,strong) NSString *state;

@end
