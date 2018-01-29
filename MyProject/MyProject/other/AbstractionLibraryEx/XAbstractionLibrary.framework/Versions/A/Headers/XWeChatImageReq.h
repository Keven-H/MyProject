//
//  XWeChatImageReq.h
//  XAbstractionLibrary
//
//  Created by 兰彪 on 16/1/12.
//  Copyright © 2016年 lanbiao. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  微信分享图片请求对象
 */
@interface XWeChatImageReq : XWeChatReq

/**
 *  构建微信分享图片请求对象
 *
 *  @param imageData 图片对象
 *  @param thumbImageData 缩略图对象
 *  @param scene          分享的位置
 *
 *  @return 图片请求对象
 */
+ (XWeChatImageReq *) createWeChatImageData:(NSData *) imageData
                             thumbImageData:(NSData *) thumbImageData
                                      scene:(XWeChatScene) scene;

@end
