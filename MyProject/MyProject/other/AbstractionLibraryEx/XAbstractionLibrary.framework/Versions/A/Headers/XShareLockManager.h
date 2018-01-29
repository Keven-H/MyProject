//
//  XShareLockManager.h
//  XAbstractionLibrary
//
//  Created by 兰彪 on 16/1/11.
//  Copyright © 2016年 lanbiao. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  分享锁定
 */
@interface XShareLockManager : XData

/**
 *  构建对象
 */
+ (XShareLockManager *) shareLockManager;

/**
 *  锁定
 */
- (void) lock:(void(^)()) block;

/**
 *  解锁
 */
- (void) unlock;
@end
