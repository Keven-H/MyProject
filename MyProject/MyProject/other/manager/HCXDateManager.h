//
//  HCXDateManager.h
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//

#import <XAbstractionLibrary/XAbstractionLibrary.h>

@interface HCXDateManager : XData

/**
 *  数据管理器单例对象
 */
+ (instancetype) shareDataManager;

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

#pragma mark 登陆账号相关


/**
 * 是否登陆
 */
-(BOOL)accountIsLogin;

/**
 * 退出
 */
-(void)accountloginOut;

/**
 * 保存数据     clear 是否比对上次账号
 */
-(void)saveAccountWithModel:(HCXAccountUser *)loginUser shouldClear:(BOOL)clear;

/**
 *  根据user保存对象
 */
-(void)saveAccountWithUserModel:(HCXUser *)user;

/**
 * 账号-----任何user里面的内容有更改 需调用accountSave 进行保存
 */
-(HCXAccountUser *)account;

/**
 * 账号的user-----任何user里面的内容有更改 需调用accountSave 进行保存
 */
-(HCXUser *)currentUser;

/**
 * 保存
 */
-(void)accountSave;


/**
 版本号是否变化
 
 */
-(BOOL)versionChange;


-(NSString *)getCurrentController:(NSString *)pageName;

-(NSString *)controllerPageID;

-(NSString *)controllerPageTitle;

- (void) clearAllCacheData;


- (float) getCacheItemsSize;

/**
 获取设备token
 */
-(NSString *)deviceToken;

/**
 保存设备token
 */
-(void)saveDeviceToken:(NSString *)token;

/**
 清空设备token
 */
-(void)clearDeviceToken;




- (NSArray *) allTasks;
- (NSArray *) taskWithClassName:(NSString*) className;
- (XTask *) taskWithID:(NSString *) taskID;
- (BOOL) addTask:(XTask *) task;

- (BOOL) addNonInsertTaskDataBase:(XTask *) task;

- (BOOL) updateTask:(XTask *) task;

- (BOOL) removeTask:(XTask*) task;


- (BOOL) removeTaskWithTaskID:(NSString *) taskID;


- (BOOL) removeAllTask;


/**
 *  添加同步队列任务
 */
- (void) addAsyncTask:(void(^)(void)) block;


/**
 查询push开关
 */
-(BOOL)pushSwitch;

/**
 设置push开关
 */
-(void)setPushSwitch:(void(^)(BOOL result))block open:(BOOL)open;


/**
 是否开通
 */
-(void)CityCodeOpen:(void(^)(BOOL result,NSInteger code,NSString *msg,NSDictionary *info))block;

/**
 呼叫电话
 */
+(void)callPhonesWithPhons:(NSString *)phone;


/**
 重置ua
 */
+(void)resetUserAgent;


/**
 注册按钮开关
 */
+(BOOL)appRegisterSwitch;
+(void)appRegisterSwitch:(BOOL)open;


/**
 时间描述
 */
+ (NSString *)getCurrentMLDDate;
@end
