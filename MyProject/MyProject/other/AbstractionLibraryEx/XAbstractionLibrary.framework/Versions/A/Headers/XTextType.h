//
//  XTextType.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/15.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XBaseType.h"

#define         XTextInitValue          nil

/**
 *  数据库字符串类型
 */
@interface XTextType : XBaseType

/**
 *  字符串值
 */
@property (nonatomic,strong) NSString *value;

/**
 *  创建表结构时才有意义,否则忽略
 */
@property (nonatomic,strong) NSString *defaultValue;

/**
 *  更新数据时才有意义,作为where后的条件部分,否则忽略
 */
@property (nonatomic,strong) NSString *oldValue;
@end
