//
//  XWeChatLinkReq.h
//  XAbstractionLibrary
//
//  Created by 兰彪 on 16/1/9.
//  Copyright © 2016年 lanbiao. All rights reserved.
//

#import "XWeChatReq.h"

/**
 *  分享一个链接
 */
@interface XWeChatLinkReq : XWeChatReq

/**
 *  网页的url地址
 */
@property (nonatomic,strong) NSString *urlString;

/**
 *  媒资标记名
 */
@property (nonatomic,strong) NSString *urlTagName;

/**
 *  标题
 */
@property (nonatomic,strong) NSString *urlTitle;

/**
 *  描述内容
 */
@property (nonatomic,strong) NSString *urlDescription;

/**
 *  缩略图
 */
@property (nonatomic,strong) NSData *urlThumbImageData;

/**
 *  构建链接对象
 *
 *  @param urlString   网页url
 *  @param tagName     媒质标记名称
 *  @param title       标题
 *  @param description 描述
 *  @param thumbImage  缩略图
 *  @param scene       分享到的目的地
 *
 *  @return 返回链接对象
 */
+ (instancetype) createLinkReq:(NSString *) urlString
                           tagName:(NSString *) tagName
                             title:(NSString *) title
                       description:(NSString *) description
                    thumbImageData:(NSData *) thumbImageData
                             scene:(XWeChatScene) scene;

@end
