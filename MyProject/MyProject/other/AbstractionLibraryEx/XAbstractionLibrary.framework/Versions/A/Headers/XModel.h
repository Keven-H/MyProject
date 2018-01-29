//
//  XModel.h
//  XAbstractionLibrary
//
//  Created by lanbiao on 15/07/13.
//  Copyright (c) 2015年 lanbiao. All rights reserved.
//

#import "XMantle.h"

@protocol XJSONAdapterSerializing <NSObject>
@optional
+ (id) JSONTransformerForValue:(id) value
            fromJSONDictionary:(NSDictionary *) JSONDictionary;
@end

/**
 *  json数据解析基础类，对应mantle
 */
@interface XModel : MTLModel<MTLJSONSerializing,XJSONAdapterSerializing>

@end
