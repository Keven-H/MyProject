//
//  SYDataBaseManager.m
//  smallYellowO
//
//  Created by 兰彪 on 15/12/1.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYDataBaseManager.h"

@implementation SYDataBaseManager

+ (instancetype) shareDataBaseManager
{
    static SYDataBaseManager *dataBaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBaseManager = [[SYDataBaseManager alloc] init];
    });
    return dataBaseManager;
}

+ (BOOL) dropTable:(SYBaseTableModel *) tableModel{
    if(!tableModel)
        return NO;
    
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@",[tableModel class]];
    return [[SYDataBaseManager shareDataBaseManager] updateDataBaseWithSQL:sql];
}

@end
