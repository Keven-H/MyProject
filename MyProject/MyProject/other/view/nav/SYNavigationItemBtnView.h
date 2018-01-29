//
//  SYNavigationItemBtnView.h
//  Foodie
//
//  Created by yunqi on 16/3/10.
//  Copyright © 2016年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSNavigationButton.h"
typedef enum
{
    SYbadgeViewType_none,//默认
    SYbadgeViewType_number,//数字
}SYbadgeViewType;
@interface SYNavigationItemBtnView : MSNavigationButton
PROPERTY_ASSIGN SYbadgeViewType badgeType;
PROPERTY_ASSIGN NSInteger maxBadgeNum;//9

PROPERTY_ASSIGN NSInteger bgdgeNumber;
@end
