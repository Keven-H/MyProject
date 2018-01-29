//
//  SYShareActivityList.h
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYShareActivityItem.h"
@interface SYShareActivityList : NSObject
PROPERTY_STRONG NSString *title;
PROPERTY_STRONG NSMutableArray<SYShareActivityItem *> *listItems;
PROPERTY_ASSIGN SYShareContenTtem contentItem;

PROPERTY_ASSIGN float leftRMargin;//左右两边边距;  0
PROPERTY_ASSIGN float topMargin;//0
PROPERTY_ASSIGN float itemVerticalMargin ;//20
PROPERTY_ASSIGN float bottomMargin;//0
PROPERTY_ASSIGN float spacing;//10
PROPERTY_STRONG UIFont *font;//12
PROPERTY_STRONG UIColor *color;

@end
