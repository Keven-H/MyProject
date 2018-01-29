//
//  XDataBaseManager.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/15.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XData.h"
#import "XBaseTableModel.h"

typedef void(^XDataBaseResponseBlock)(NSArray *responseObj);

/**
 *  本地数据库访问对象API
 */
@interface XDataBaseManager : XData

/**
 *  数据库路径
 */
@property (nonatomic,strong)  NSString *dataBasePath;

/**
 *  判断字段名在对应表中是否存在
 *  @param columnName   字段名
 *  @param tableName    表名
 *
 *  @return YES 存在 否则不存在
 */
- (BOOL) columnExists:(NSString*)columnName
      inTableWithName:(NSString*)tableName;

/**
 *  除SELECT以外的操作
 *  @param sql SQL语句
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL) updateDataBaseWithSQL:(NSString *) sql;

/**
 *  除SELECT以外的操作
 *
 *  @param tableModel 表模型
 *
 *  @return YES 成功 NO 失败
 */
- (BOOL) updateDataBaseWithXTableModel:(XBaseTableModel *) tableModel;

/**
 *  SELECT查询操作
 *
 *  @param tableModel 表模型
 */
- (void) QueryDataBaseWithXTableModel:(XBaseTableModel *) tableModel
                        responseBlock:(XDataBaseResponseBlock) responseBlock;


@end
