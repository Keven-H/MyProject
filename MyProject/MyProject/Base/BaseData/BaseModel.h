//
//  BaseModel.h
//  EatEquity
//
//  Created by 兰彪 on 2017/12/29.
//  Copyright © 2017年 兰彪. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 *  会吃侠基础model
 */
@interface BaseModel : MTLModel<MTLJSONSerializing>

/**
 *  获取随机的唯一ID
 */
+ (NSString *) uuid;

/**
 *  获取对象ID
 */
- (NSString *) getID;

@end
