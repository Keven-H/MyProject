//
//  XDoubleType.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/15.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XBaseType.h"

#define             XDoubleInitValue            -666666.0

/**
 *  数据库字端浮点类型
 */
@interface XDoubleType : XBaseType

/**
 *  浮点值
 */
@property (nonatomic,assign) double value;

/**
 *  创建表结构时才有意义,否则忽略
 */
@property (nonatomic,assign) double defaultValue;

/**
 *  更新数据时才有意义,作为where后的条件部分,否则忽略
 */
@property (nonatomic,assign) double oldValue;

@end
