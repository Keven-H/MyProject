//
//  SYCacheModel.h
//  smallYellowO
//
//  Created by 兰彪 on 15/11/27.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYBaseModel.h"

/**
 *   在本地缓存池中存放的对象
 */
@interface SYCacheModel : SYBaseModel

/**
 *  根据最新数据更新本地缓存数据
 *
 *  @param model 最新数据
 */
- (void) updateInfo:(SYCacheModel *) model fromJSONDictionary:(NSDictionary *)JSONDictionary;

@end
