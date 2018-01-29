//
//  XDateDefaultManager.m
//  EatEquity
//
//  Created by liyunqi on 02/01/2018.
//  Copyright © 2018 兰彪. All rights reserved.
//


/**
 *  缓存文件夹
 */
#define             cacheFileDirectory              @"cacheFileDirectory"
/**
 *  当前用户对象缓存文件
 */
#define             currentUserFile                 @"currentUserFile.cache"
#define         smallYelloO_token_key           @"smallYello_token_key"

#define         smallYellowO_CheckIntegral_Key  @"smallYellow_CheckIntegral_Key"


#define       smallYellowO_clientUser    [NSString stringWithFormat:@"smallYelloO_clientUser_keys_%d",1]
#import "XDateDefaultManager.h"
#import "XUserDefaults.h"
#import "XFileManager.h"
@implementation XDateDefaultManager
+ (XDateDefaultManager *) shareManager;
{
    static XDateDefaultManager *shareUserDefaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUserDefaultManager = [[XDateDefaultManager alloc] init];
    });
    return shareUserDefaultManager;
}

- (NSString *) getCacheFileDirectoryPath
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    NSString *fn = [NSString stringWithFormat:@"%@/%@",path,cacheFileDirectory];
    return fn;
}

- (NSString *) getCacheFilePath:(NSString *) fileName
{
    NSString *path = [self getCacheFileDirectoryPath];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,fileName];
    return filePath;
}
- (void) clear
{
    [self clearToken];
}

- (void) saveToken:(NSString *) token
{
    [XUserDefaults saveValue:token forKey:smallYelloO_token_key];
}

- (NSString *) readToken
{
    return [XUserDefaults getValueForKey:smallYelloO_token_key];
}

- (void) clearToken
{
    [XUserDefaults removeValueForKey:smallYelloO_token_key];
}


- (void) saveModel:(SYBaseModel *) model
{
    if(!model)
        return;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [XUserDefaults saveValue:data forKey:NSStringFromClass([model class])];
}

- (SYBaseModel *) getModel:(Class)classModel
{
    if(!classModel)
        return nil;
    SYBaseModel *baseModel = nil;
    id value = [XUserDefaults getValueForKey:NSStringFromClass(classModel)];
    if([value isKindOfClass:[NSData class]])
    {
        id objValue = [NSKeyedUnarchiver unarchiveObjectWithData:value];
        if([objValue isKindOfClass:[SYBaseModel class]])
            baseModel = (SYBaseModel*)objValue;
        
    }
    return baseModel;
}

- (void) clearModel:(Class) classModel
{
    if(classModel)
        [XUserDefaults removeValueForKey:NSStringFromClass(classModel)];
}

- (id) getValueForKey:(NSString *const) key
{
    return [XUserDefaults getValueForKey:key];
}

- (BOOL) removeValueForKey:(NSString *const) key
{
    return [XUserDefaults removeValueForKey:key];
}

- (BOOL) saveValue:(id) value forKey:(NSString *const) key
{
    return [XUserDefaults saveValue:value forKey:key];
}
#pragma mark -keychain
- (id) getKeyChainValueForKey:(NSString *const) key
{
    return [XUserDefaults getKeyChainValueForKey:key];
}
- (BOOL) removeKeyChainValueForKey:(NSString *const) key
{
    return [XUserDefaults removeKeyChainValueForKey:key];
}
- (BOOL) saveKeyChainValue:(id) value forKey:(NSString *const) key
{
    return [XUserDefaults saveKeyChainValue:value forKey:key];
}
-(BOOL)saveClientAccount:(HCXAccountUser *)clientAccount
{
    if(!clientAccount || ![clientAccount conformsToProtocol:@protocol(NSCoding)])
        return NO;
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:clientAccount];
#if CONFIG==4
    //    reportenabled = YES;
    return [XUserDefaults saveKeyChainValue:modelData forKey:smallYellowO_clientUser];
#endif
    return [XUserDefaults saveValue:modelData forKey:smallYellowO_clientUser];
}

-(HCXAccountUser *)clientAccount
{
    NSData *modelData;

    modelData = [XUserDefaults getKeyChainValueForKey:smallYellowO_clientUser];
    if(!modelData)
        return nil;
    if (![modelData isKindOfClass:[NSData class]]) {
        return nil;
    }
    HCXAccountUser *model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return model;
}


- (BOOL) saveCurrentUser:(HCXAccountUser *) user
{
    if(!user || ![user conformsToProtocol:@protocol(NSCoding)])
        return NO;
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:user];
    return [XFileManager writeFileAtPath:[self getCacheFilePath:currentUserFile] content:modelData];
}

- (HCXAccountUser *) readCurrentUser
{
    NSData *modelData = [XFileManager readFileAtPathAsData:[self getCacheFilePath:currentUserFile]];
    if(!modelData)
        return nil;
    HCXAccountUser *user = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return user;
}

- (void) clearCurrentUser
{
    [XFileManager removeItemAtPath:[self getCacheFilePath:currentUserFile ] error:nil];
}

@end
