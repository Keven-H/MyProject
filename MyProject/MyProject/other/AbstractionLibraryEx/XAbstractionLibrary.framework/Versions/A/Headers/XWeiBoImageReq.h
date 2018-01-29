//
//  XWeiBoImageReq.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/14.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XWeiBoReq.h"

/**
 *  微博图片资源数据对象
 */
@interface XWeiBoImageReq : XWeiBoReq

/**
 *  构建微博图片资源数据对象
 *
 *  @param imageData 图片数据流
 *  @param messageContent   消息文本内容
 *
 *  @return 返回微博图片资源数据对象
 */
+ (instancetype) createWeiBoImageReqWithImageData:(NSData *) imageData
                                   messageContent:(NSString *) messageContent;

/**
 *  构建微博图片资源数据对象
 *
 *  @param imageData   图片数据流
 *  @param accessToken 微博accessToken
 *  @param messageContent   消息文本内容
 *
 *  @return 返回微博图片资源数据对象
 */
+ (instancetype) createWeiBoImageReqWithImageData:(NSData *) imageData
                                   messageContent:(NSString *) messageContent
                                          accessToken:(NSString *) accessToken;
@end
