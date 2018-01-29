//
//  SYShareActivityItem.h
//  Foodie
//
//  Created by liyunqi on 11/2/16.
//  Copyright © 2016 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYShareOptionConfig.h"
@interface SYShareActivityItem : NSObject

PROPERTY_STRONG NSString *title;
PROPERTY_STRONG NSString *imagePath;
PROPERTY_WEAK id action;
PROPERTY_ASSIGN SEL sel;
PROPERTY_ASSIGN id infoDic;
PROPERTY_ASSIGN SYShareContenTtem itemType;
//
PROPERTY_ASSIGN SEL autoSel;
-(id)initWithTitle:(NSString *)title imagePath:(NSString *)imagePath action:(id)action sel:(SEL)sel itemType:(SYShareContenTtem )item;
@end
