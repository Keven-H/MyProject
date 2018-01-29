//
//  SYImage.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/17.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYBaseModel.h"
typedef NS_ENUM(NSInteger,ImageAssetStyle)
{
    ImageAsset_none,
    ImageAsset_jpg,
    ImageAsset_gif,
    ImageAsset_video,
};

@protocol SYImage <NSObject>
@end

/**
 *  小黄圈图像对象
 */
@interface SYImage : SYBaseModel

/**
 *  图片高度
 */
@property (nonatomic,assign) CGFloat height;

/**
 *  图片宽度
 */
@property (nonatomic,assign) CGFloat width;

/**
 *  高清图链接地址
 */
@property (nonatomic,strong) NSString *url;

/**
 *  缩略图链接地址
 */
@property (nonatomic,strong) NSString *thumbUrl;

/**
 *  对应的图片资源
 */
@property (nonatomic,strong) UIImage *image;

/**
 *  图片类型jpg,video,gif
 */
@property(nonatomic,assign) ImageAssetStyle type;


/**
 *  判断url是否存在
 *
 *  @return YES为空 否则不为空
 */
- (BOOL) isEmptyUrl;

/**
 *  判断是否网络连接
 */
- (BOOL) isNetUrl;

@end
