//
//  XWeiBoResult.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/8/12.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XWeiBoCommon.h"

/**
 *  微博数据条件错误码
 */
typedef NS_ENUM(NSInteger, XWeiBoConditionError){
    /**
     *  文本内容太短
     */
    XWeiBoConditionErrorTextContentTooShort,
    /**
     *  文本内容太长
     */
    XWeiBoConditionErrorTextContentTooLong,
    /**
     *  图片内容太小
     */
    XWeiBoConditionErrorImageTooSmall,
    /**
     *  图片内容太大
     */
    XWeiBoConditionErrorImageTooLarge,
    /**
     *  多媒体对象唯一ID为空
     */
    XWeiBoConditionErrorObjectIDTooShort,
    /**
     *  多媒体对象唯一ID太长
     */
    XWeiBoConditionErrorObjectIDTooLong,
    /**
     *  多媒体对象标题为空
     */
    XWeiBoConditionErrorTitleTooShort,
    /**
     *  多媒体对象标题太长
     */
    XWeiBoConditionErrorTitleTooLong,
    /**
     *  多媒体对象描述太长
     */
    XWeiBoConditionErrorDescTooLong,
    /**
     *  多媒体对象缩略图太大
     */
    XWeiBoConditionErrorThumbnailTooLarge,
    /**
     *  多媒体资源页面url地址为空
     */
    XWeiBoConditionErrorMediaUrlTooShort,
    /**
     *  多媒体资源页面url地址太长
     */
    XWeiBoConditionErrorMediaUrlTooLong,
};


@class  WBBaseResponse;
@interface XWeiBoResult : XData

/**
 *  分享结果信息
 */
@property (nonatomic,strong) NSString *errorInfo;

/**
 *  分享结果码
 */
@property (nonatomic,assign) XWeiBoResultCode resultCode;

/**
 *  构建微博请求成功对象
 *
 *  @return 返回请求成功对象
 */
+ (XWeiBoResult *) success;

/**
 *  构建未安装微信对象
 *
 *  @return 返回未安装微信对象
 */
+ (XWeiBoResult *) notInstallApp;

/**
 *  构建不支持API对象
 *
 *  @return 返回不支持API对象
 */
+ (XWeiBoResult *) notSupportAPI;

/**
 *  构建未知错误对象
 *
 *  @return 返回位置错误对象
 */
+ (XWeiBoResult *) dontKownError;

/**
 *  根据条件错误构建条件错误对象
 *
 *  @param errorCode 条件码
 *
 *  @return 返回条件错误对象
 */
+ (XWeiBoResult *) createWeiBoResultWithConditionErrorCode:(XWeiBoConditionError) errorCode;

/**
 *  解析微博模型数据到本地数据模型
 *
 *  @param resp 微博模型数据
 */
- (void) pasteData:(WBBaseResponse *) resp;
@end
