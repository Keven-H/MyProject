//
//  SYBaseModel.m
//  smallYellowO
//
//  Created by 兰彪 on 15/11/17.
//  Copyright © 2015年 兰彪. All rights reserved.
//

#import "SYBaseModel.h"

@implementation SYBaseModel
+ (void)syenumeratePropertiesUsingBlock:(void (^)(objc_property_t property, BOOL *stop))block {
    Class cls = self;
    BOOL stop = NO;
    while (!stop && ![cls isEqual:SYBaseModel.class]) {
        unsigned count = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        
        cls = cls.superclass;
        if (properties == NULL)
        {
            continue;
        }
        
        for (unsigned i = 0; i < count; i++) {
            block(properties[i], &stop);
            if (stop) break;
        }
        free(properties);
    }
    block=nil;
}
+ (NSDictionary *) JSONKeyPathsByPropertyKey
{
    //不在取super JSONKeyPathsByPropertyKey
    NSMutableDictionary *keys = [NSMutableDictionary new];
    [self syenumeratePropertiesUsingBlock:^(objc_property_t property, BOOL *stop) {
        NSString *key = @(property_getName(property));
        keys[key] = key;
    }];
    keys[@"ID"] = @"id";
    return keys;
}
//
- (BOOL) validateID
{
    if(_ID.length <= 0)
        return NO;
    else
        return YES;
}

#pragma mark --XJSONAdapterSerializing

#pragma mark NSCoping
- (instancetype) copyWithZone:(NSZone *)zone
{
    SYBaseModel *baseModel = [super copyWithZone:zone];
    baseModel.ID = [self.ID copy];
    return baseModel;
}

#pragma mark NSCoding
- (instancetype) initWithCoder:(NSCoder *)coder
{
    if(self = [super initWithCoder:coder])
    {
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
}

@end
