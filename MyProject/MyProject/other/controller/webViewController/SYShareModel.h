//
//  SYShareModel.h
//  Foodie
//
//  Created by liyunqi on 6/1/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import "SYBaseModel.h"

typedef NS_ENUM(NSInteger, SYShareType)
{
    SYShareType_none=0,
    SYShareType_img=1,//分享图片
};
@interface SYShareModel : SYBaseModel

PROPERTY_ASSIGN SYShareType type;

PROPERTY_STRONG NSString *img;//url
PROPERTY_STRONG NSString *content;

PROPERTY_STRONG NSString *title;
PROPERTY_STRONG UIImage *image;
PROPERTY_STRONG NSString *link;

//数据data
PROPERTY_STRONG NSData *imageData;
PROPERTY_STRONG NSData *imageThumbnailData;

-(void)downShareImage;//下载分享图片
-(UIImage *)downShareIMG;//获取下载的图片
-(BOOL)validate;
@end
