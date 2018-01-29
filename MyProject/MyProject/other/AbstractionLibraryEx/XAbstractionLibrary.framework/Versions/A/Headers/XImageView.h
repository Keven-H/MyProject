//
//  XImageView.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/27.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XView.h"
#import "XImage.h"

/**
 *  加载进度回调
 */
typedef void(^ProgressBlock)(CGFloat progress);

/**
 *  加载完成回调
 */
typedef void(^BackCallBlock)(UIImage *image);

@interface XImageView : XView

/**
 *  不建议这么用
 */
- (id) init __attribute__((unavailable("init not available")));

/**
 *  不建议这么用
 */
- (id) initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("init not available")));

/**
 *  重置页面
 */
- (void) reset;

/**
 *  界面初始化
 */
- (void) setup;

/**
 *  显示图像区域
 *
 *  @return 返回显示区域对象
 */
- (UIImageView *) imageView;

/**
 *  加载指定图像对象
 *
 *  @param imageObj      待加载的图像对象
 *  @param progressBlock 加载进度回调
 *  @param block         加载完成回调
 */
- (void) setImageObj:(XImage *) imageObj
       progressBlock:(ProgressBlock) progressBlock
       backCallBlock:(BackCallBlock) backCallBlock;

/**
 *  添加控件点击事件
 *
 *  @param target 响应目标
 *  @param action 响应动作
 */
- (void) addTarget:(id) target
            action:(SEL)action;

@end
