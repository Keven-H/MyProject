//
//  SYResolveResponse.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYResponse.h"
#import <XAbstractionLibrary/XAbstractionLibrary.h>

/**
 *  小黄圈解析网络请求结果
 */
@interface SYResolveResponse : XData

/**
 *  根据网络请求结果解析返回小黄圈model
 *
 *  @param Class       解析到的模型类类型
 *  @param responseObj 被解析的原始数据
 *  @param error       错误对象
 *
 *  @return 返回解析后的结果
 */
+ (SYResponse *) resolveWithClass:(Class) Class
                      responseObj:(id) responseObj
                            error:(NSError*) error;
@end
