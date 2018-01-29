//
//  XUserDefaults.h
//  myFrameworkDemo
//
//  Created by liyunqi on 28/03/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//



@interface XUserDefaults : NSObject


/**
 *  获取指定key对应的value
 *
 *  @param key 待获取数据的key
 *
 *  @return 对应的结果，没有找到对应的key返回nil
 */
+ (id) getValueForKey:(NSString *const) key;

/**
 *  删除指定key对应的数据
 *
 *  @param key 待删除的数据对应的key
 *
 *  @return YES 删除成功 否则失败
 */
+ (BOOL) removeValueForKey:(NSString *const) key;

/**
 *  根据对应的key保存数据value
 *
 *  @param value 待保存的数据
 *  @param key   待保存数据对应的key
 *
 *  @return YES 删除成功 否则失败
 */
+ (BOOL) saveValue:(id) value forKey:(NSString *const) key;



//KeyChain

/**
 *  获取指定key对应的value KeyChain
 *
 *  @param key 待获取数据的key
 *
 *  @return 对应的结果，没有找到对应的key返回nil
 */
+ (id) getKeyChainValueForKey:(NSString *const) key;

/**
 *  删除指定key对应的数据 KeyChain
 *
 *  @param key 待删除的数据对应的key
 *
 *  @return YES 删除成功 否则失败
 */
+ (BOOL) removeKeyChainValueForKey:(NSString *const) key;

/**
 *  根据对应的key保存数据value KeyChain
 *
 *  @param value 待保存的数据
 *  @param key   待保存数据对应的key
 *
 *  @return YES 删除成功 否则失败
 */
+ (BOOL) saveKeyChainValue:(id) value forKey:(NSString *const) key;
@end
