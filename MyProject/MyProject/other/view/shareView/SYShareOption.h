//
//  SYShareOption.h
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYShareActivityList.h"
#import "SYShareOptionConfig.h"
@class SYShareItemsView;
@interface SYShareOption : NSObject

PROPERTY_STRONG SYBaseModel *model;
//一般情况不用指定
PROPERTY_WEAK SYShareItemsView *view;
PROPERTY_STRONG NSMutableArray<SYShareActivityList *>*activitys;//便于以后分组显示
PROPERTY_COPY syshareContentBlock doneBlock;
PROPERTY_ASSIGN SYShareContentType contentType;
PROPERTY_ASSIGN BOOL showClose;//yes

-(void)optionClickItem:(SYShareActivityItem *)activityItem;
@end
