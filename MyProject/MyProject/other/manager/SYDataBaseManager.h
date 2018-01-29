//
//  SYDataBaseManager.h
//  smallYellowO
//
//  Created by 兰彪 on 15/12/1.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYTaskTableModel.h"
#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  数据库操作管理器
 */
@interface SYDataBaseManager : XDataBaseManager

/**
 *  构造数据库操作管理器单例
 */
+ (instancetype) shareDataBaseManager;

/**
 *  删除表
 */
+ (BOOL) dropTable:(SYBaseTableModel *) tableModel;

@end
