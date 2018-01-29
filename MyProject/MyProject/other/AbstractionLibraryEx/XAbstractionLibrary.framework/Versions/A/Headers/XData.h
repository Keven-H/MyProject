//
//  XData.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/9.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XGlobalMacros.h"

/**
 *  基础对象
 */
@interface XData : NSObject<NSCopying,NSCoding>

/**
 *  对象ID
 */
@property (nonatomic,strong) NSString *ID;

/**
 *  确保本地每个数据源、任务等有本地唯一的ID,继承自XData的对象都会自动调用处理
 *
 *  @return 返回一个唯一的ID
 */
+ (NSString *) uuid;

/**
 *  验证对象ID是否存在
 *
 *  @return YES 存在 NO 不存在
 */
- (BOOL) validateID;

/**
 *  ^o^
 */
+ (BOOL) validity;
@end
