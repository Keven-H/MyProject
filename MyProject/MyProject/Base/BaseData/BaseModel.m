//
//  BaseModel.m
//  EatEquity
//
//  Created by 兰彪 on 2017/12/29.
//  Copyright © 2017年 兰彪. All rights reserved.
//

#import "BaseModel.h"
#import "PermanentStoreData.h"

@interface BaseModel(){
    NSString *ID;
}
@end

@implementation BaseModel
+ (NSString *) uuid{
    return @"";
}

- (instancetype) init{
    if(self = [super init]){
        ID = [BaseModel uuid];
    }
    return self;
}

- (NSString *) getID{
    if(ID == NULL || ID.length <= 0){
        ID = [BaseModel uuid];
    }
    return ID;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return NULL;
}
@end
