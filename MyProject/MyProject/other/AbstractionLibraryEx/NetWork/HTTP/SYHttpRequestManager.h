//
//  SYHttpRequestManager.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYBaseHttpRequestManager.h"

/**
 *  http网络请求管理器,单例模式
 */
@interface SYHttpRequestManager : SYBaseHttpRequestManager

/**
 *  获取http单例网络请求管理器对象
 *
 *  @return 返回单例对象
 */
+ (id) shareHttpRequestManager;

@end
