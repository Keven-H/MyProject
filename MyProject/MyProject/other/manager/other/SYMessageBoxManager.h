//
//  SYMessageBoxManager.h
//  Foodie
//
//  Created by lanbiao on 16/7/13.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>
#import "HCXAppUpgradeModel.h"
/**
 *  提示框类型
 */
typedef NS_ENUM(NSInteger,MessageBoxType) {
    /**
     *  token过期
     */
    MessageBoxType_TokenTimeOut,
    /**
     *  账号冻结
     */
    MessageBoxType_AcountShutDown,
    
    /**
     *  强制更新
     */
    MessageBoxType_ForceUpdate,
    
};

/**
 *  是否显示提示框管理器单例
 */
@interface SYMessageBoxManager : XData

/**
 *  提示框管理器蛋里
 */
+ (instancetype) shareMessageBoxManager;

/**
 *  显示重新登录提示框
 *
 *  @param tipText 提示语
 */
- (void) showDialog:(MessageBoxType) type tipText:(NSString *) tipText;

/**
 *  显示更新提示框
 *
 */
- (void) showUpdateDialogVersion:(HCXAppUpgradeModel *)upmodel;
@end
