//
//  PermanentStoreData.m
//  EatEquity
//
//  Created by 兰彪 on 2017/12/29.
//  Copyright © 2017年 兰彪. All rights reserved.
//

#import "UICKeyChainStore.h"
#import "PermanentStoreData.h"

@implementation PermanentStoreData

+ (BOOL) saveStringToCache:(NSString *) value cacheKey:(NSString *)cacheKey
{
    if(!value || !cacheKey)
        return NO;
    return [UICKeyChainStore setString:value forKey:cacheKey];
}

+ (NSString *) valueFromCache:(NSString *) cacheKey
{
    if(!cacheKey)
        return nil;
    return [UICKeyChainStore stringForKey:cacheKey];
}

+ (BOOL) saveModelToCache:(BaseModel *) modelValue cacheKey:(NSString *)cacheKey
{
    if(!modelValue || !cacheKey)
        return NO;
    
    if(![modelValue isKindOfClass:[BaseModel class]] ||
       ![modelValue conformsToProtocol:@protocol(NSCoding)])
        return NO;
    
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:modelValue];
    return [UICKeyChainStore setData:modelData forKey:cacheKey];
}

+ (BaseModel *) modelFromCacheKey:(NSString *) cacheKey
{
    if(!cacheKey)
        return nil;
    NSData *modelData = [UICKeyChainStore dataForKey:cacheKey];
    BaseModel *modelValue = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    return modelValue;
}

+ (BOOL) removeAllCache
{
    return [UICKeyChainStore removeAllItems];
}

@end
