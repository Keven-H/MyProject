//
//  PermanentStoreData.h
//  EatEquity
//
//  Created by 兰彪 on 2017/12/29.
//  Copyright © 2017年 兰彪. All rights reserved.
//

#import "BaseModel.h"

/**
 *  缓存池对象，用于持久缓存数据使用(删除app依然可以保留)
 */
@interface PermanentStoreData : BaseModel

/**
 *  缓存字符串到缓存池
 *
 *  @param value        待缓存的字符串
 *  @param cacheKey     待缓存字符串的key
 *  @return   YES 缓存成功  NO 缓存失败
 */
+ (BOOL) saveStringToCache:(NSString *) value cacheKey:(NSString *) cacheKey;

/**
 *  在本地缓存池中查找cachekey下的字符串
 *
 *  @param cacheKey 待缓存字符串的key
 *
 *  @return 获取到的cachekey下的字符串
 */
+ (NSString *) valueFromCache:(NSString *) cacheKey;


/**
 *  缓存数据模型到缓存池
 *
 *  @param modelValue   待缓存的模型数据
 *  @param cacheKey     待缓存模型的key
 *  @return   YES 缓存成功  NO 缓存失败
 */
+ (BOOL) saveModelToCache:(BaseModel *) modelValue cacheKey:(NSString *) cacheKey;

/**
 *  在本地缓存池中查找cachekey下的模型数据
 *
 *  @param cacheKey 缓存模型的key
 *
 *  @return 获取到模型数据
 */
+ (BaseModel *) modelFromCacheKey:(NSString *) cacheKey;

/**
 *  清除本地所有的缓存
 *
 *  @return YES 成功 否则失败
 */
+ (BOOL) removeAllCache;

@end
