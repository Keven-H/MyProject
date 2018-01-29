//
//  XDateDefaultManager.h
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface XDateDefaultManager : XData
/**
 *  单例管理器
 */
+ (instancetype ) shareManager;

/**
 *  清除本管理器相关的所有缓存
 */
- (void) clear;

/**
 *  保存token
 */
- (void) saveToken:(NSString *) token;

/**
 *  读取token
 */
- (NSString *) readToken;

/**
 *  从本地缓存清除token
 */
- (void) clearToken;


/**
 *  保存对象
 *
 *  @param model 待保存的对象
 */
- (void) saveModel:(SYBaseModel *) model;

/**
 *  获取对应的model
 *
 *  @param classModel model对应的class
 *
 *  @return 返回class对应的对象model
 */
- (SYBaseModel *) getModel:(Class) classModel;

/**
 *  清除对应的model数据
 *
 *  @param classModel 待清除的model数据
 */
- (void) clearModel:(Class) classModel;

/**
 *  获取指定key对应的value
 *
 *  @param key 待获取数据的key
 *
 *  @return 对应的结果，没有找到对应的key返回nil
 */
- (id) getValueForKey:(NSString *const) key;

/**
 *  删除指定key对应的数据
 *
 *  @param key 待删除的数据对应的key
 *
 *  @return YES 删除成功 否则失败
 */
- (BOOL) removeValueForKey:(NSString *const) key;

/**
 *  根据对应的key保存数据value
 *
 *  @param value 待保存的数据
 *  @param key   待保存数据对应的key
 *
 *  @return YES 删除成功 否则失败
 */
- (BOOL) saveValue:(id) value forKey:(NSString *const) key;


//KeyChain

/**
 *  获取指定key对应的value KeyChain
 *
 *  @param key 待获取数据的key
 *
 *  @return 对应的结果，没有找到对应的key返回nil
 */
- (id) getKeyChainValueForKey:(NSString *const) key;

/**
 *  删除指定key对应的数据 KeyChain
 *
 *  @param key 待删除的数据对应的key
 *
 *  @return YES 删除成功 否则失败
 */
- (BOOL) removeKeyChainValueForKey:(NSString *const) key;

/**
 *  根据对应的key保存数据value KeyChain
 *
 *  @param value 待保存的数据
 *  @param key   待保存数据对应的key
 *
 *  @return YES 删除成功 否则失败
 */
- (BOOL) saveKeyChainValue:(id) value forKey:(NSString *const) key;



/**
 游客数据
 
 */
-(BOOL)saveClientAccount:(HCXAccountUser *)clientAccount;

/**
 游客数据
 */
-(HCXAccountUser *)clientAccount;

/**
 *  保存当前用户信息到文件
 *
 *  @param user 用户对象
 *  @return YES成功 否则失败
 */
- (BOOL) saveCurrentUser:(HCXAccountUser *) user;

/**
 *  读取文件返回当前用户信息
 */
- (HCXAccountUser *) readCurrentUser;

/**
 *  清除当前用户在本地的缓存
 */
- (void) clearCurrentUser;
@end
