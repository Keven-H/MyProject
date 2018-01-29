//
//  XBaseType.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/15.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"

/**
 *  数据库基础类型
 */
@interface XBaseType : XData

/**
 *  建议无需理会该参数，内部使用
 */
@property (nonatomic,assign) BOOL bCondition;

/**
 *  只对创建表结构时，才能起作用，YES字端不能为空 否则无意义
 */
@property (nonatomic,assign) BOOL bNotNil;

/**
 *  只对创建表结构时，整型主键的定义时才有意思，YES自增长 否则无意义
 */
@property (nonatomic,assign) BOOL bAutoIncrement;

@end
