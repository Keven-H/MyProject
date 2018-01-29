//
//  XUserDefaults.m
//  myFrameworkDemo
//
//  Created by liyunqi on 28/03/2017.
//  Copyright © 2017 liyunqi. All rights reserved.
//

#import "XUserDefaults.h"
#import <UICKeyChainStore.h>
@interface  XUserDefaults()


@end

@implementation XUserDefaults

+ (id) getValueForKey:(NSString *const) key
{
    if(key.length <=0)
        return nil;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

+ (BOOL) removeValueForKey:(NSString *const)key
{
    if(key.length <= 0)
        return NO;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
    return [userDefault synchronize];
}

+ (BOOL) saveValue:(id)value forKey:(NSString *const)key
{
    if(key.length <= 0)
        return NO;
    if(!value)
        return NO;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:key];
    return [userDefault synchronize];
}



#pragma mark -keychain
+ (id) getKeyChainValueForKey:(NSString *const) key
{
    if (key.length<=0) {
        return nil;
    }
    return [UICKeyChainStore dataForKey:key];
}
+ (BOOL) removeKeyChainValueForKey:(NSString *const) key
{
    if (key.length<=0) {
        return NO;
    }
    return [UICKeyChainStore removeItemForKey:key];
}
+ (BOOL) saveKeyChainValue:(id) value forKey:(NSString *const) key
{
    if (key.length<=0) {
        return NO;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [UICKeyChainStore setString:value forKey:key];
    }
    if ([value isKindOfClass:[NSData class]]) {
        return [UICKeyChainStore setData:value forKey:key];
    }
    return NO;
}@end
