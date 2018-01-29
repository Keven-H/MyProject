//
//  SYHttpRequestManager.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/18.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYHttpRequestManager.h"

@implementation SYHttpRequestManager

#pragma mark --单例模式
+ (instancetype) shareHttpRequestManager
{
    static SYHttpRequestManager *requestManager = nil;
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
    return [[self shareHttpRequestManager] retain];
#else
    static SYHttpRequestManager *requestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[super allocWithZone:zone] init];
    });
    return requestManager;
#endif
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

- (id) copyWithZone:(NSZone *)zone
{
    return self;
}

- (instancetype) init
{
    if(self = [super init])
    {
        self.httpHostAddress = NET_HEADER_ADRESS;
    }
    return self;
}

@end
