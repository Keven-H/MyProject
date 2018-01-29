//
//  XIntType.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/15.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XBaseType.h"

#define           XIntInitValue             -666666

/**
 *  数据库字端整型类型
 */
@interface XIntType : XBaseType

/**
 *  整形值
 */
@property (nonatomic,assign) NSInteger value;

/**
 *  创建表结构时才有意义,否则忽略
 */
@property (nonatomic,assign) NSInteger defaultValue;

/**
 *  更新数据时才有意义,作为where后的条件部分,否则忽略
 */
@property (nonatomic,assign) NSInteger oldValue;

@end
