//
//  XDataType.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/15.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XBaseType.h"

#define         XDataInitValue                  nil

/**
 *  数据库字节流类型
 */
@interface XDataType : XBaseType

/**
 *  字节流
 */
@property (nonatomic,strong) NSData *value;

/**
 *  创建表结构时才有意义,否则忽略
 */
@property (nonatomic,strong) NSData *defaultValue;

/**
 *  更新数据时才有意义,作为where后的条件部分,否则忽略
 */
@property (nonatomic,strong) NSData *oldValue;
@end
