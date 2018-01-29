//
//  XShareDataSource.h
//  XAbstractionLibrary
//
//  Created by 兰彪 on 16/1/11.
//  Copyright © 2016年 lanbiao. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

typedef void(^XShareCallBlock)(XData *result);

/**
 *  分享数据集合
 */
@interface XShareDataSource : XData

/**
 *  构建抽象分享数据对象
 *
 *  @param dataSource     抽象的分享数据
 *  @param shareCallBlock 抽象的回调
 *
 *  @return 返回构建的抽象数据对象
 */
+ (XShareDataSource *) createShareData:(XData *) dataSource
                             callBlock:(XShareCallBlock) shareCallBlock;

/**
 *  返回分享数据源对象
 *
 *  @return 分享数据源
 */
- (XData *) dataSource;

/**
 *  分享的回调执行块
 *
 *  @return 返回分享执行块
 */
- (XShareCallBlock) shareCallBlock;

@end
