//
//  SYHttpsRequestManager.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYHttpsRequestManager.h"

@implementation SYHttpsRequestManager

#pragma mark --单例模式
+ (instancetype) shareHttpsRequestManager
{
    static SYHttpsRequestManager *requestManager = nil;
#if !__has_feature(objc_arc)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [NSAllocateObject([self class], 0, nil) init];
    });
#else
//    requestManager = [[[self class] alloc] init];
    requestManager = [[self class] alloc];
#endif
    return requestManager;
}

+ (id) allocWithZone:(struct _NSZone *)zone
{
#if !__has_feature(objc_arc)
    return [[self shareHttpsRequestManager] retain];
#else
    static dispatch_once_t onceToken;
    static SYHttpsRequestManager *requestManager = nil;
    dispatch_once(&onceToken, ^{
        requestManager = [[super allocWithZone:zone] init];
    });
    return requestManager;
#endif
}

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}

#if !__has_feature(objc_arc)
- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax;
}

- (id) autorelease
{
    return self;
}

- (oneway void) release
{
    
}
#endif

- (instancetype) init
{
    if(self = [super init])
    {
        self.httpHostAddress = @"https://219.234.131.42";
    }
    return self;
}

@end
