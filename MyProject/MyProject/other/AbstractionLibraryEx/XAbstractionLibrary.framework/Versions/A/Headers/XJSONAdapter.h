//
//  XJSONAdapter.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/7/14.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "MTLJSONAdapter.h"

@interface XJSONAdapter : MTLJSONAdapter

/**
 *  oc对象转json
 *
 *  @param object 待转oc对象
 *
 *  @return 返回json字符串
 */
+ (NSString *) objectToJson:(id) object;

/**
 *  json转oc对象
 *
 *  @param JSONString 待转json串
 *
 *  @return 返回oc对象
 */
+ (id) jsonToObject:(NSString *) JSONString;

@end
