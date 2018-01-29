//
//  SYHttpsRequestManager.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYBaseHttpRequestManager.h"

/**
 *  https请求管理器，单例模式
 */
@interface SYHttpsRequestManager : SYBaseHttpRequestManager

/**
 *  获取https单例网络请求管理器对象
 *
 *  @return 返回单例对象
 */
+ (instancetype) shareHttpsRequestManager;

@end
