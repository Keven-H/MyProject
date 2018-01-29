//
//  XBaseTableModel.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/15.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XIntType.h"
#import "XTextType.h"
#import "XDataType.h"
#import "XDoubleType.h"

/**
 *  表的动作
 */
typedef NS_ENUM(NSInteger, XTableControlStyle){
    /**
     *  创建表
     */
    XTableControlStyleCreate = 1,
    /**
     *  查询
     */
    XTableControlStyleSelect,
    /**
     *  插入
     */
    XTableControlStyleInsert,
    /**
     *  更新
     */
    XTableControlStyleUpdate,
    /**
     *  删除
     */
    XTableControlStyleDelete,
    /**
     *  不知道的动作
     */
    XTableControlStyleUnKown,
};

/**
 *  查询结果的排序样式
 */
typedef NS_ENUM(NSInteger,XTableSelectOrderByStyle) {
    /**
     *  不排序
     */
    XTableSelectOrderByStyle_None,
    /**
     *  升序
     */
    XTableSelectOrderByStyle_Asc,
    /**
     *  降序
     */
    XTableSelectOrderByStyle_Desc,
};

/**
 *  基础表model
 */
@interface XBaseTableModel : XData

/**
 *  表的操作
 */
@property (nonatomic,assign) XTableControlStyle controlStyle;

/**
 *  主键指针
 */
@property (nonatomic,strong) XBaseType *primaryKey;

/**
 *  排序键，主要用在select
 */
@property (nonatomic,strong) XBaseType *orderByKey;

/**
 *  查询相关的排序样式
 */
@property (nonatomic,assign) XTableSelectOrderByStyle orderByStyle;

/**
 *  获得SQL语句的前缀
 */
- (NSString *) getSQLPrefix;

/**
 *  获得SQL语句的后缀
 */
- (NSString *) getSQLSuffix;

@end
