//
//  XImage.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/27.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"

/**
 *  图片对象
 */
@interface XImage : XData

/**
 *  加载图像的路径
 */
@property (nonatomic,strong) NSString *webImageURL;

/**
 *  加载的图像
 */
@property (nonatomic,strong) UIImage *image;

/**
 *  根据图像Url构建加载对象
 *
 *  @param webImageURL 待加载的图像地址
 *
 *  @return 新构造的图像对象
 */
- (instancetype) initWithWebImageURL:(NSString *) webImageURL;


/**
 *  无效的图片加载对象
 *
 *  @return YES 失效的 NO有效的
 */
- (BOOL) invalidImage;

@end
